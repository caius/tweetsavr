require "time"
require "yaml"

class ViewTweets
  class Grabber
    attr_accessor :tweet_ids, :tweets

    def initialize ids
      self.tweet_ids = Array(ids)
      get_tweets
    end

    def tweets
      @tweets ||= []
    end

    def get_tweets
      self.tweets = tweet_ids.map {|id| GrabReplyChain.for(id) }.flatten.sort_by {|t| t["created_at"] }
    end
  end
end
