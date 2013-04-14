require "rubygems"
require "bundler/setup"
require "pathname"

# We do don't no stinking dev here
ENV["RACK_ENV"] = "production"

Bundler.require :default

class ViewTweets
  def self.root
    Pathname.new File.expand_path("..", File.dirname(__FILE__))
  end
  def self.lib
    root + "lib"
  end
  def self.setup_twitter config
    Twitter.configure do |c|
      c.consumer_key = config["consumer_key"]
      c.consumer_secret = config["consumer_secret"]
      c.oauth_token = config["token"]
      c.oauth_token_secret = config["secret"]
    end
  end
end

# Setup twitter auth
ViewTweets.setup_twitter(YAML.load(ViewTweets.root.join("config/twitter.yml").read))

%w(core_ext/array_to_sentence app grab_reply_chain grabber).each do |file|
  require "#{ViewTweets.lib}/view_tweets/#{file}"
end
