require 'sinatra'
require 'yaml'
require 'open-uri'
require 'json'

configure :production do
  set :bind, 'alx.endofambrosia.net'
  set :port, 8080
end

API_KEYS = YAML::load(File.open(File.dirname(__FILE__) + "/keys.yaml", "r"))

get '/' do
  "hello and welcome"
end

get '/np' do
  "you forgot your last.fm username, what are you even doing here"
end

get '/np/' do
  "you forgot your last.fm username, what are you even doing here"
end

get '/np/:user' do
  begin
    resp = JSON[open("http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=#{params[:user]}&api_key=#{API_KEYS[:API_KEY]}&format=json").read]["recenttracks"]["track"][0]
    "#{resp["artist"]["#text"]} - #{resp["name"]}"
  rescue
    "something happened and it was not good"
  end
end
