class ViewTweets
  class App < Sinatra::Base
    set :root, ViewTweets.root

    get "/" do
      @title = "TweetSavr"
      @header = "View Tweets in a Conversation"
      erb :index
    end

    get %r{/(.*)$} do |status_id|
      if status_id.to_i.to_s != status_id
        extracted_id = status_id[%r{/(\d+)/?}, 1]
        redirect to("/#{extracted_id}")
      end
      @tweets = Grabber.new(status_id).ordered_tweets
      @users = @tweets.map {|x| x["user"]["screen_name"] }.uniq
      @title = "#{@users.map {|n| "@#{n}" }.to_sentence} in conversation"
      @header = "Conversation between #{@users.map {|u| %{<a href="#{profile_url(u)}">@#{u}</a>} }.to_sentence}"
      erb :tweets
    end

    helpers do
      def profile_url screen_name
        "https://twitter.com/#!/#{screen_name}"
      end

      def status_url screen_name, status_id
        "#{profile_url(screen_name)}/status/#{status_id}"
      end

      def display_date time
        # todo: make this say x minutes/hours ago up to the next day, then display "day month"
        str = if time.year < Time.now.year
          "%d %b '%y"
        else
          "%d %b"
        end

        time.strftime str
      end
    end

  end
end
