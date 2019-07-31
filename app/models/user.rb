# frozen_string_literal: true

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :friendships
  has_many :friends, through: :friendships

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
  
  def add_friend(friend_id)
    friend = User.find_by_id(friend_id)
    self.friends << friend
  end

  def remove_friend(friend_id)
    friendships = Friendship.where(user_id:friend_id).or(Friendship.where(friend_id:friend_id))
    friendships.destroy_all
  end

  def received_friends
    received_friend_ids = Friendship.where(friend_id:id).where.not(user_id:Friendship.where(user_id:id).pluck(:friend_id)).pluck(:user_id)
    User.where(id:received_friend_ids)
  end

  def active_friends
    friends.select{ |friend| friend.friends.include?(self) }  
  end

  def pending_friends
    friends.select{ |friend| !friend.friends.include?(self) }  
  end

  def suggested_friends
    available_user_ids = Role.find_by_name("user").users.pluck(:id)
    suggested_friend_ids = Friendship.where(user_id:self.id).or(Friendship.where(friend_id:self.id)).pluck(:user_id,:friend_id).flatten.uniq
    suggested_friend_ids.delete(self.id)
    available_user_ids -= suggested_friend_ids
    User.where(id:available_user_ids)
  end

end
