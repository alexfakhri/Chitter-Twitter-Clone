require 'data_mapper'
require 'sinatra'
require 'rack-flash'
require_relative 'helpers/application'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './lib/post'
require './lib/user'

DataMapper.finalize
DataMapper.auto_upgrade!

set :views, Proc.new { File.join(root, "views") }
enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do
  @posts = Post.all
  erb :index
end

post '/posts' do
  post = params["post"]
  Post.create(post: post)
  redirect to('/')
end

get '/users/new' do
  @user = User.new
	erb :"users/new"
end

post '/users' do
  @user = User.create(email: params[:email],
  						user_name: params[:user_name],
              password: params[:password],
              password_confirmation: params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect to('/')
  else 
    flash[:notice] = "Sorry, your passwords don't match"
    erb :"users/new"
  end
end
