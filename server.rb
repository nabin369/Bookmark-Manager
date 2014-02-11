require 'sinatra'
require 'data_mapper'

env = ENV["RACK_ENV"] || "development"

# we're telling datamapper to use postgress database on localhost. 
# The name will be "bookmark_manager_test" or "bookmark_manager_development" 
# depending on the environment
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link' # this needs to be done after datamapper is initialized
require './lib/tag'

# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell DataMapper to create them
DataMapper.auto_upgrade!


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


