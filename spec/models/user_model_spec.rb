require 'rails_helper.rb'

describe "User Model" do

	it "should save a user if all the fields are filled in correctly" do 

		user = User.new(name: "John Doe", email: "john@doe.com", password: "johndoe123")
		expect(user.save).to eq(true)
	end

	it "should not save a user if the name is missing" do
		user = User.new(email: "john@doe.com", password: "johndoe123")

		expect(user.save).to eq(false)
	end

	it "should not save a user if the email is missing" do
		user = User.new(name: "john", password: "johndoe123")

		expect(user.save).to eq(false)
	end




	
end