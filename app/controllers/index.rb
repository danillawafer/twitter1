get '/' do
  erb :index
end

post '/' do
  @user = TwitterUser.find_by_name(params[:username])

  if  @user.nil? || @user.tweets.empty?
    p "from the API"
  
    @user = TwitterUser.create(name: params[:username])
    @user.fetch_tweets!

  elsif @user.tweets_stale?

    Tweet.where(twitter_user_id: @user.id).destroy_all
    @user.fetch_tweets!

    p "Destroy an fetch!!!!!!!"
  end

  p "these tweets are fresh!!!!"
  @tweets = @user.tweets.limit(10)
  erb :show_tweets
end

get '/:username' do 
  @tweets = get_tweets(params[:username])
  erb :show_tweets
end
