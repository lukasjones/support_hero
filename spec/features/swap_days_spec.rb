require 'rails_helper'

describe "The swap day feature", :type => :feature, :js => true do

	before(:each) do
		
		@user1 = User.create(name: Faker::Name.first_name)
		@user2 = User.create(name: Faker::Name.first_name)

		[@user1, @user2].each do |user|
			current_day = Date.today
			day = DayAssignment.new(user: user, date: current_day)
			while !day.valid?
				current_day = current_day.tomorrow
				day = DayAssignment.new(user: user, date: current_day)
			end
			day.save
		end

		user2_date = @user2.day_assignments.first.date
		data_date = user2_date.strftime("%d-%m-20%y").split("-").map {|num| num.to_i}.join("-")
		query = "td[data-date=" + "'#{data_date}']"

		visit "/users/#{@user1.id}"

		find(query).hover
		option = first('#day_assignment_swap_request option').text
		select option, from: 'day_assignment_swap_request'
		find(query).find("input[type='submit']").click
	end

	it "should ask to swap users when you submit form" do
		expect(@user2.day_assignments.first.swap_request).to eq(@user1.day_assignments.first.date)
	end

	it "should swap users when one user confirms" do
		user1_date = @user1.day_assignments.first.date

		visit "/users/#{@user2.id}"
		find("input[value='Yes']").click
		expect(@user2.day_assignments.first.date).to eq(user1_date)
	end

end