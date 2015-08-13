require 'rails_helper'

describe "The no can do day feature", :type => :feature, :js => true do
	before(:each) do

		today = Date.today
		
		@user1 = User.create(name: Faker::Name.first_name)
		@user2 = User.create(name: Faker::Name.first_name)

		Day.create(date: Date.today, user: @user1)
		Day.create(date: Date.tomorrow, user: @user2)
		
		ScheduledMonth.create_month_and_days(today.month, today.year)
	end

	it "should remove user from selected day" do
		visit "/users/#{@user1.id}"
		sleep(2)
		selected_tds = page.all(".selected")
		selected_tds[0].hover
		selected_tds[0].find(".submit_undoable").click
		expect(page.all(".selected").length).to eq(0)
	end



end