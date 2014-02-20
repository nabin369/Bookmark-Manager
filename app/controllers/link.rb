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

get '/links/new' do
	erb :'links/new'
end