require 'rails_helper'

describe "The no can do day feature", :type => :feature, :js => true do
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

	end

	it "should remove user from selected day" do

		
		visit "/users/#{@user1.id}"
		selected_tds = page.all(".selected")
		selected_tds[0].hover
		selected_tds[0].find(".submit_undoable").click
		expect(page.all(".selected").length).to eq(0)

	end



end