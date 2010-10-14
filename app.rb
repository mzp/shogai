# -*- mode:ruby; coding:utf-8 -*-

require 'rubygems'
require 'sinatra'
require 'haml'

unless defined? require_relative
  def require_relative(*args)
    require(*args)
  end
end
require_relative 'model'
require_relative 'crowler'

set :haml, :format => :html5
set :views, File.dirname(__FILE__) + '/views'
set :public, File.dirname(__FILE__) + '/public'
get '/' do
   haml :index
end

get '/search' do
  @date = Date.new(*params[:date].split("/",3).map{|x| x.to_i})
  @title = @date.strftime("%Y/%m/%dの空き状況")
  haml :search
end

get '/result' do
  @date = Date.new(*params[:date].split("/",3).map{|x| x.to_i})
  @institutions = Crowler.new.find_by_date @date
  haml :result, :layout=>false
end
