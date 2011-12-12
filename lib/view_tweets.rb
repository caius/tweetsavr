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
end

%w(core_ext/array_to_sentence app grab_reply_chain grabber).each do |file|
  require "#{ViewTweets.lib}/view_tweets/#{file}"
end
