require 'spec_helper'

feature 'User signs up' do

	scenario 'when being logged out' do
		expect{ sign_up }.to change(User, :count).by(1)
		expect(page).to have_content("Welcome, @alex")
		expect(User.first.user_name).to eq("@alex")
		expect(User.first.email).to eq("alex@alex.com")
	end


	def sign_up(email = "alex@alex.com",
							user_name = "@alex",
							password = "nuts!")
		visit '/users/new'
		expect(page.status_code).to eq(200)
		fill_in :email, with: email
		fill_in :user_name, with: user_name
		fill_in :password, with: password
		click_button "Sign up"
	end

end