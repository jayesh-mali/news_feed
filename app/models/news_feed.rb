class NewsFeed < ApplicationRecord
    belongs_to :postable, polymorphic: true, dependent: :destroy
    belongs_to :created_by, class_name: 'User'

    def self.list_news_feeds(current_user)
        admin_ids = Role.find_by_name('admin').users.pluck(:id)
        friend_ids = current_user.active_friends
        ids = [*admin_ids,current_user.id,*friend_ids]
        NewsFeed.preload(:postable).includes(:created_by).where(created_by_id:ids).order(created_at: :desc)
    end

end
