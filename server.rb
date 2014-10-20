require 'data_mapper'
require 'sinatra'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './lib/post'
require './lib/user'

DataMapper.finalize
DataMapper.auto_upgrade!

set :views, Proc.new { File.join(root, "views") }
enable :sessions
set :session_secret, 'super secret'

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
	erb :"users/new"
end

post '/users' do
  user = User.create(email: params[:email],
  						user_name: params[:user_name],
              password: params[:password])
  sessions[:user_id] = user.id
  redirect to('/')
end
