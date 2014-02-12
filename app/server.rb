require 'sinatra'
require 'data_mapper'

require './lib/link' # this needs to be done after datamapper is initialized
require './lib/tag'
require './lib/user'

require_relative 'helpers/application'
require_relative 'data_mapper'

enable :sessions
set :session_secret, 'super secret'

get '/' do
	@links = Link.all
	erb :index
end

post '/links' do
	url = params['url']
	title = params['title']
		# this will either find this tag or create
		# it if it doesn't exist already
	tags = params['tags'].split(" ").map do |tag| 
		Tag.first_or_create(:text => tag)
	end
	Link.create(:url => url, :title => title, :tags => tags)

	redirect to('/')
end

get '/tags/:text' do
	tag = Tag.first(:text => params[:text])
	@links = tag ? tag.links : []
	erb :index
end

post '/tags' do
	tag = Tag.first(:text => params['tags'])
	@links = tag ? tag.links : []
	erb :index
end

post '/users/new' do
	# note the view is in views/users/new.erb, we need the quotes 
	# because otherwise ruby would divide the symbol :users by the
	# variable new (which makes no sense)
	erb :"users/new"
end

post '/users' do
	user = User.create(:email => params[:email], :password => params[:password])
	session[:user_id] = user.id
	redirect to('/')
end

get '/back' do
	redirect to('/')
end







