# -*- mode:ruby; coding:utf-8 -*-

require 'rubygems'
require 'sinatra'
require 'haml'

require_relative 'model'
require_relative 'crowler'

set :haml, :format => :html5
set :views, File.dirname(__FILE__) + '/views'
set :public, File.dirname(__FILE__) + '/public'
get '/' do
   haml :index
end

get '/search' do
  @institutions = Crowler.new.find_by_date params[:year],params[:month], params[:day]
  haml :search
end
