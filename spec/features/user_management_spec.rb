require 'spec_helper'

feature 'User signs up'  do
	
	# the tests that checks the UI
	# (have_content, etc.) should be separate form the tests
	# that checks what we have in the DB. The reason is that
	# you should test one thing at a time, wheras by mixing 
	# the two we're testing both the business login and the views.

	# However, lwt's not worry about this yet
	# to keep the example simple.

	scenario 'when being logged out'  do
		lambda { sign_up }.should change(User, :count).by(1)
		expect(page).to have_content('Welcome, alice@example.com')
		expect(User.first.email).to eq('alice@example.com')
	end

	def sign_up(email = 'alice@example.com', password = 'orange')
		visit '/users/new'
		fill_in :email, :with => email
		fill_in :password, :with => password
		click_button 'Sign up'
	end
end