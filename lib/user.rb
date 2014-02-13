# bcrypt will generate the password hash
require 'bcrypt'

class User

	include DataMapper::Resource

	attr_reader :password
	attr_accessor :password_confirmation

	property :id, Serial
	property :email, String, :unique => true
	# It's text and not string cause it's not enough to store hash and salt
	property :password_digest, Text

	# this is datamapper's method of validating the model, and will not be saved
	# unless both password and password_confirmation are same.
	validates_confirmation_of :password
	validates_uniqueness_of :email

		# we assigned the password digest provided by bcrypt, which has hash and salt, 
	# in the database for security reasons, instead of plain password
	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		# user trying to sign in
		user = first(:email => email)

		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else
			nil
		end
	end

end


