class TwitController < ApplicationController

  def search
    friends = Twit.get_friends( params['screen_name'] )

    return_array = Twit.format_friends_array( friends )

    render json: { array: return_array }
  end

end
