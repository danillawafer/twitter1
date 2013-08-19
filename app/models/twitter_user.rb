class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!
    @tweets = Twitter.user_timeline(self.name, count: 10)
    @tweets.each do |tweet|
      Tweet.create(content: tweet.full_text, twitter_user_id: self.id, tweet_date: tweet.created_at)
    end
  end

  def tweets_stale?
    last_tweet = Tweet.where(twitter_user_id: self.id).last
    tweets_stale = last_tweet.created_at
    stale =  Time.now - tweets_stale 
    return (stale/60 > 15)
  end


  def fetch_followers!
    followers = Twitter.followers(self.name)
    followers.map{ |follower| follower.attr[:name] }
  end
end
