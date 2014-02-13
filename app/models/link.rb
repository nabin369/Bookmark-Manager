# This class corresponds to a table in the database
# We can use it to manipulat the data
class Link

	# this makes the instance of this class Datamapper resources
	include DataMapper::Resource

	has n, :tags, :through => Resource
	# this block describes what resources our model will have
	property :id, 	Serial # Serial means that it wil be auto-incremented for every record
	property :title, String
	property :url, String

end