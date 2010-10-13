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
  @date = Date.new params[:year].to_i,params[:month].to_i, params[:day].to_i
  @institutions = Crowler.new.find_by_date @date
  haml :search
end
