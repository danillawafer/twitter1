get '/' do
  erb :index
end

post '/' do
  @username = params[:username]
  @user = TwitterUser.find_by_name(@username)
  if  @user.nil? || @user.tweets.empty?  
    @user = TwitterUser.create(name: params[:username])
    @user.fetch_tweets!

  elsif @user.tweets_stale?
    Tweet.where(twitter_user_id: @user.id).destroy_all
    @user.fetch_tweets!
  end

  @tweets = @user.tweets.limit(10)
  erb :show_tweets
end

get '/:username' do 
  @tweets = get_tweets(params[:username])
  erb :show_tweets
end


get '/:username/followers' do
  user = TwitterUser.find_by_name(params[:username])
  @followers = user.fetch_followers!
  erb :followers
end
