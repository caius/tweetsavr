require "time"
require "yaml"

class ViewTweets
  class Grabber
    attr_accessor :starting_id

    def initialize starting_id
      self.starting_id = starting_id
      get_tweets
    end

    def tweets
      @tweets ||= []
    end

    def ordered_tweets
      tweets.reverse
    end

  protected

    def get_tweets
      t = if tweets.empty?
        get_tweet(starting_id)
      else
        last_id = tweets.last["in_reply_to_status_id_str"].to_i
        get_tweet(last_id) if last_id && last_id != 0
      end

      if t
        t["created_at"] = Time.parse(t["created_at"])
        self.tweets << t
        get_tweets
      end
    end

    def get_tweet id
      if cached?(id) && (( t = load_from_cache(id) ))
        t
      else
        t = Twitter.status(id).to_hash
        cache_tweet!(t)
        t
      end
    end

    def cache_path id
      ViewTweets.root + "cache/#{id}.yml"
    end

    def cached? id
      File.exists? cache_path(id)
    end

    def cache_tweet! tweet
      File.open(cache_path(tweet["id_str"]), "w+") do |f|
        f.print tweet.to_yaml
      end
    end

    def load_from_cache id
      YAML.load_file(cache_path(id))
    end

  end
end
