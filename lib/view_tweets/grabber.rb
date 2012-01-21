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

    # def tweets= t
      # ids = t.map(&:tweet_id)
    # end

    def get_tweets
      self.tweets = tweet_ids.map {|id| GrabReplyChain.for(id) }.flatten.reduce({}) {|h, t|
        t_id = t["id"]
        h[t_id] = t unless h.has_key?(t_id)
        h
      }.values.sort_by {|t| t["created_at"] }
    end
  end
end
