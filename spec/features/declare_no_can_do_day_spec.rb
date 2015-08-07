require 'rails_helper'

describe "The no can do day feature" do
	before(:each) do
		user_array = []
		5.times do 
			user = User.create(name: Faker::Name.first_name)
			user_array.push(user)
		end

		current_day = Date.today
		2.times do 
			user_array.each do |user|
				day = DayAssignment.new(user: user, date: current_day)
				while !day.valid?
					current_day = current_day.tomorrow
					day = DayAssignment.new(user: user, date: current_day)
				end
				day.save
				current_day = current_day.tomorrow
			end
		end

		@user = user_array[0]


	end

	it "should let a user mark his day as undoable" do
		visit "/users/#{@user.id}"
		within ""
	end

end