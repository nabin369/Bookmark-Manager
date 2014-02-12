# bcrypt will generate the password hash
require 'bcrypt'

class User

	include DataMapper::Resource

	property :id, Serial
	property :email, String
	# It's text and not string cause it's not enough to store hash and salt
	property :password_digest, Text
	# we assigned the password digest provided by bcrypt, which has hash and salt, 
	# in the database for security reasons, instead of plain password
	def password=(password)
		self.password_digest = BCrypt::Password.create(password)
	end

end