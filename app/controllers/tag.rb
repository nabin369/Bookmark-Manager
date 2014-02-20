
get '/tags/:text' do
	tag = Tag.first(:text => params[:text])
	@links = tag ? tag.id : []
	erb :index
end