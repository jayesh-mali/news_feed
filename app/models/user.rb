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

  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :received_friends, through: :received_friendships, source: 'user'

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
  
  def add_friend(friend_id)
    friend = User.find_by_id(friend_id)
    self.friends << friend
  end

  def remove_friend(friend_id)
    friendships = Friendship.where(user_id:2).or(Friendship.where(friend_id:2))
    friendships.destroy_all
  end

  def active_friends
    friends.select{ |friend| friend.friends.include?(self) }  
  end

  def pending_friends
    friends.select{ |friend| !friend.friends.include?(self) }  
  end

end
