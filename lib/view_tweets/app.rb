class ViewTweets
  class App < Sinatra::Base
    set :root, ViewTweets.root

    get "/" do
      if params[:tweet]
        redirect to("/#{params[:tweet]}")
      end
      erb :index
    end

    get "/:status_id" do |status_id|
      @tweets = Grabber.new(status_id).ordered_tweets
      erb :tweets
    end

  end
end
