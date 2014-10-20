require 'spec_helper.rb'

feature 'Users adds a new post' do
	
	scenario 'when browsing the homepage' do
		expect(Post.count).to eq(0)
		visit '/'
		add_post('This is a sample post of less than 140 characters')
		expect(Post.count).to eq(1)
		post = Post.first
		expect(post.post).to eq('This is a sample post of less than 140 characters')
	end

	def add_post(post)
		within('#new-post') do
			fill_in 'post', with: post
			click_button 'Post'
		end
	end

end