require 'sinatra/base'
require 'data_mapper'
require_relative './models/link'
require './app/data_mapper_setup'


class AppWeb < Sinatra::Base

  run! if app_file == $0

  set :views, proc { File.join(root, '..', 'views') }

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    tags = params[:tags].split
    tags.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'

  end


  get '/links' do
    @links = Link.all
    erb :'links/index'
  end




end
