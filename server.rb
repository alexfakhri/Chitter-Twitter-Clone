require 'data_mapper'
require 'sinatra'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './lib/post'

DataMapper.finalize
DataMapper.auto_upgrade!

set :views, Proc.new { File.join(root, "views") }

get '/' do
  @posts = Post.all
  erb :index
end

post '/posts' do
  post = params["post"]
  Post.create(post: post)
  
  redirect to('/')
end