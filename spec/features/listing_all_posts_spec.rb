require 'spec_helper'

feature "User browses the list of posts" do

  before(:each) {
    Post.create(user_name: "@alex",
                post: "This is a sample post of less than 140 characters")
  }

  scenario "when visiting the home page" do
    visit '/'
    save_and_open_page
    expect(page.status_code).to eq 200
    expect(page).to have_content("This is a sample post of less than 140 characters")
  end
end

