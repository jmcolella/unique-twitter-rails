class Twit < ApplicationRecord
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  end

  def self.get_friends( screen_name )
    cursor = -1
    friends = []

    while cursor != 0
      obj = @client.friends( screen_name, { cursor: cursor, count: 200 } )
      obj.attrs[:users].each do | user |
        friends.push( user )
      end
      cursor = obj.attrs[:next_cursor]
    end

    return friends
  end

  def self.format_friends_array( friends )
    return friends.map do | friend |
      friend[:screen_name]
    end
  end
end
