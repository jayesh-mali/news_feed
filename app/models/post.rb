class Post < ApplicationRecord

    include NewsFeedConcern

    has_one :news_feed, as: :postable, dependent: :destroy
    validates :title, :description, presence: true

    def self.create_post(params,current_user_id)
        post = Post.new(params)
        post.created_by_id = current_user_id
        post.save
        create_news_feed(post)
        return post
    end
end
