class HomeController < ApplicationController
  def index
    oauth_retrieve
  end

  private
  require 'json'
  require 'oauth2'
  def oauth_retrieve
    user = current_user
    unless user.blank?
      authorization = user.authorizations.first
      unless authorization.blank?
        access_token = authorization.access_token
        access_token_secret = authorization.access_token_secret
        consumer = OAuth::Consumer.new('1862998813','c55101921f5cef89cfe55ce102c68626',{:site =>'http://api.t.sina.com.cn'})
        accesstoken = OAuth::AccessToken.new(consumer, access_token, access_token_secret)
        response = accesstoken.get("http://api.t.sina.com.cn/account/verify_credentials.json")
        @weibo_user = JSON.parse(response.body)
      end
    end
  end
end
