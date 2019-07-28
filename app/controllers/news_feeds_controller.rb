class NewsFeedsController < ApplicationController

    def index
        @news_feeds = NewsFeed.list_news_feeds(current_user)
        render json: @news_feeds
    end

end
