task :environment do
  require File.expand_path("./lib/view_tweets", File.dirname(__FILE__))
end

namespace :tweets do

  desc "Refreshes the cached tweets from twitter"
  task :refresh_cache => :environment do

    Dir[(ViewTweets.root + "cache/*.yml")].each do |path|
      begin
        id = path[%r{([^/.]+)\.yml\z}, 1]
        print "Refreshing #{id.inspect}"
        tweet = Twitter.status(id, :include_entities => true).to_hash
        File.open(path, "w+") do |f|
          f.print tweet.to_yaml
        end
        print "\t..done"
      rescue => ex
        puts "!!!!! ERROR: #{ex.inspect}"
      ensure
        puts
      end
    end

  end

end
