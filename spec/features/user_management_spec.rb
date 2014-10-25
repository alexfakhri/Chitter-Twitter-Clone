require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers


feature 'User signs up' do

	scenario 'when being logged out' do
		expect{ sign_up }.to change(User, :count).by(1)
		expect(page).to have_content("Welcome, alex@alex.com")
		expect(User.first.user_name).to eq("@alex")
		expect(User.first.email).to eq("alex@alex.com")
	end

	scenario "With a password that doesn't match" do
		expect{ sign_up('alex@alex.com', 'pass', 'wrong') }.to change(User, :count).by(0)
		expect(current_path).to eq('/users')
		expect(page).to have_content("Sorry, your passwords don't match")
	end

	scenario "with an email that is already registered" do
		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up }.to change(User, :count).by(0)
		expect(page).to have_content("This email is already taken")
	end

	scenario "with a username that is already registered" do
		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up }.to change(User, :count).by(0)
		expect(page).to have_content("This username is already taken")
	end


end

feature 'User signs in' do

	before(:each) do
		User.create(email: "alex@alex.com",
					password: 'nuts!',
					password_confirmation: 'nuts!')
	end

	scenario "with correct credentials" do
    	visit '/'
    	expect(page).not_to have_content("Welcome, alex@alex.com")
    	sign_in('alex@alex.com', 'nuts!')
    	expect(page).to have_content("Welcome, alex@alex.com")
  	end

  	scenario "with incorrect credentials" do
    	visit '/'
    	expect(page).not_to have_content("Welcome, alex@alex.com")
    	sign_in('alex@alex.com', 'wrong')
    	expect(page).not_to have_content("Welcome, alex@alex.com")
  end


end

feature 'User signs out' do

  before(:each) do
    User.create(:email => "alex@alex.com",
                :password => 'nuts!',
                :password_confirmation => 'nuts!')
  end

  scenario 'while being signed in' do
    sign_in('alex@alex.com', 'nuts!')
    click_button "Sign out"
    expect(page).to have_content("Good bye!") # where does this message go?
    expect(page).not_to have_content("Welcome, alex@alex.com")
  end

end
