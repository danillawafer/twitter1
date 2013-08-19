helpers do

  def make_the_tweet
    env_config = YAML.load_file(APP_ROOT.join('config', 'twitter.yaml'))

    env_config.each do |key, value|
      ENV[key] = value
    end

    client = Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.oauth_token = ENV['OAUTH_TOKEN']
      config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
    end
    client.update(@tweet)
  end

end
