require 'spec_helper'
require 'post'


describe Post do

	context "Checking datamapper is working" do

		it "should be created and retrieved from the database" do
			expect(Post.count).to eq(0)

			Post.create(	email: "a@a.com",
										name: "ALEX",
										user_name: "@alex",
										post: "this is a sample post of less than 140 characters")

			expect(Post.count).to eq(1)

			post = Post.first

			expect(post.email).to eq("a@a.com")
			expect(post.name).to eq("ALEX")
			expect(post.user_name).to eq("@alex")
			expect(post.post).to eq("this is a sample post of less than 140 characters")
			post.destroy
			expect(Post.count).to eq(0)

		end	
	end
end

