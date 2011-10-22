require "rubygems"
require "bundler/setup"
require "pathname"

Bundler.require :default

class ViewTweets
  def self.root
    Pathname.new File.expand_path("..", File.dirname(__FILE__))
  end
  def self.lib
    root + "lib"
  end
end

%w(core_ext/array_to_sentence app grabber).each do |file|
  require "#{ViewTweets.lib}/view_tweets/#{file}"
end
