class Image < ApplicationRecord

    include NewsFeedConcern

    has_one :news_feed, as: :postable, dependent: :destroy
    has_one_attached :image_post

    validates :title, :image_post, presence: true

    def self.create_image(params,current_user_id)
        image = Image.new(params)
        image.created_by_id = current_user_id
        image.save
        create_news_feed(image)
        return image
    end
end
