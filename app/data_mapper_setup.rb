require 'data_mapper'
require './app/data_mapper_setup'
require './lib/post'
require './lib/user'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

DataMapper.finalize
DataMapper.auto_upgrade!