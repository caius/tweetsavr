class ViewTweets
  class App < Sinatra::Base

    get "/" do
      erb :index
    end

    get "/:status_id" do |status_id|
      @tweets = Grabber.new(status_id).ordered_tweets
      erb :tweets
    end

  end
end
