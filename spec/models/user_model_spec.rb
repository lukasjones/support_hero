require 'rails_helper.rb'

describe "User Model" do

	it "should save a user if all the fields are filled in correctly" do 

		user = User.new(name: "John Doe")
		expect(user.save).to eq(true)
	end

	it "should not save a user if the name is missing" do
		user = User.new()
		expect(user.save).to eq(false)
	end

	
	it "should not let a user set another no_can_do_day until the start of the next month" do
		user = User.create(name: "Blah", no_can_do_day: '1-5-2015'.to_date)
		expect(user.update_attributes(no_can_do_day: '1-6-2015'.to_date)).to eq(false)
	end



	
end