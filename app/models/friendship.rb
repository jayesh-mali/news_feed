class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :friend_cant_same_as_user
  validates_uniqueness_of :user_id, scope: [:friend_id]

  private
  def friend_cant_same_as_user
    errors.add(:friend, "can't be the same as the user") if self.user == self.friend
  end

end
