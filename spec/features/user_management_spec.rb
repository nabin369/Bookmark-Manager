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

	scenario "with a password that doesn't match" do
		lambda { sign_up('a@a.com', 'pass', 'wrong')}.should change(User, :count).by(0)
	end

	scenario "with a password that doesn't match" do
		lambda { sign_up('a@a.com', 'pass', 'worng')}.should change(User, :count).by(0)
			expect(current_path).to eq('/users')
			expect(page).to have_content("Sorry, your passwords don't match")
	end

	scenario "with an email that is already registered" do
		lambda { sign_up }.should change(User, :count).by(1)
		lambda { sign_up }.should change(User, :count).by(0)
		expect(page).to have_content("This email is already taken")
	end

	def sign_up(email = 'alice@example.com', password = 'orange', password_confirmation = 'orange')
		visit '/users/new'
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation

		click_button 'Sign up'
	end


end