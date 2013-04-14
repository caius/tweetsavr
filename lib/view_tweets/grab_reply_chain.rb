class GrabReplyChain
  attr_accessor :tweets, :starting_id

  def self.for id
    new(id).tweets
  end

  def initialize id
    self.starting_id = id
    get_tweets
  end

  def tweets
    @tweets ||= []
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
      tweak_tweet(t) # Fuck yeah, pass by reference
      self.tweets << t
      get_tweets
    end
  end

  def get_tweet id
    if cached?(id) && (( t = load_from_cache(id) ))
      t
    else
      t = Twitter.status(id, :include_entities => true).to_hash.deep_stringify_keys
      cache_tweet!(t)
      t
    end
  end

  def tweak_tweet t
    t["created_at"] = Time.parse(t["created_at"])
    # Turn @foo into link to twitter.com/foo
    t["text"].gsub!(/(^|\W)@(\w+)/, %{\\1<a href="https://twitter.com/#!/\\2">@\\2</a>})
    # Turn #foo into <span class="hashtag">#foo</span>
    t["text"].gsub!(/(^|\W)(#\w+)/, %{\\1<em class="hashtag">\\2</em>})
    # todo: check for & hypertextize links
    if t["entities"] && !t["entities"]["urls"].empty?
      urls = t["entities"]["urls"]
      urls.each do |u|
        t["text"].sub! u["url"], %{<a href="#{u["url"]}">#{u["expanded_url"]}</a>}
      end
    end
    t["text"]
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
