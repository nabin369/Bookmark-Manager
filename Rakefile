require 'data_mapper'
require './app/data_mapper_setup'

task :auto_upgrade do
	# auto_upgrade makes non-destructive changes. Instead of upgrading the tables
	# we will change schema.
	DataMapper.auto_upgrade!
	puts "Auto-upgrade complete (no data loss)"
end

task :auto_migrate do
	# auto_migrate for creation of all tables as descrbed in models, even if the data 
	# ma lost
	DataMapper.auto_migrate!
	puts "Auto-migrate complete (data could have been lost)"
end