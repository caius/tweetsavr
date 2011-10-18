require "rubygems"
require "bundler/setup"
require "pathname"

Bundler.require :default

class ViewTweets
  def self.root
    Pathname.new File.dirname(__FILE__)
  end
end

%w(app grabber).each do |file|
  require "#{ViewTweets.root}/view_tweets/#{file}"
end
