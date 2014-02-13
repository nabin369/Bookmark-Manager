require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

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
			expect(page).to have_content("Sorry, Password does not match the confirmation")
	end

	scenario "with an email that is already registered" do
		lambda { sign_up }.should change(User, :count).by(1)
		lambda { sign_up }.should change(User, :count).by(0)
		expect(page).to have_content("Email is already taken")
	end
end

feature 'User signs in' do

	before(:each) do
		User.create(:email => 'test@test.com', :password => 'test', :password_confirmation => 'test')
	end

	scenario 'with correct credentials' do
		visit '/'
		expect(page).not_to have_content('Welcome, test@test.com')
		sign_in('test@test.com', 'test')
		expect(page).to have_content('Welcome, test@test.com')
	end

	scenario 'with incorrect credentials' do
		visit '/'
		expect(page).not_to have_content('Welcome, test@test.com')
		sign_in('test@test.com', 'wrong')
		expect(page).not_to have_content('Welcome, test@test.com')
	end
end

feature 'User signs out' do

	before(:each) do
		User.create(:email => 'test@test.com', :password => 'test', :password_confirmation => 'test')
	end

	scenario 'while being signed in' do
		sign_in('test@test.com', 'test')
		click_button 'Sign out'
		expect(page).to have_content("Good bye!")
		expect(page).not_to have_content("Welcome, test@test.com")
	end
end







