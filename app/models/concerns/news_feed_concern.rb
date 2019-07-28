module NewsFeedConcern
    extend ActiveSupport::Concern

    class_methods do
        def create_news_feed(associated_object)
            NewsFeed.create(postable:associated_object,created_at:associated_object.created_at,updated_at:associated_object.updated_at,created_by_id:associated_object.created_by_id)
        end
    end
end