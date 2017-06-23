class TweetsController < ApplicationController

  # GET /tweets
  def index
    unless @bearer_token
      get_bearer_token
    end

    @results = HTTParty::get("https://api.twitter.com/1.1/search/tweets.json?q=%23AmazingTheStore", headers: {"Authorization": "Bearer #{@bearer_token}"})
  end

  private

  def get_bearer_token
    authorization = Base64.strict_encode64("#{URI::encode(ENV["CONSUMER_KEY"])}:#{URI::encode(ENV["CONSUMER_SECRET"])}".force_encoding("UTF-8"))
    response = HTTParty::post("https://api.twitter.com/oauth2/token",
      headers: {"Authorization": "Basic #{authorization}", "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"},
      body: "grant_type=client_credentials")
    if response["token_type"] == "bearer"
      @bearer_token = response["access_token"]
    end
  end

end
