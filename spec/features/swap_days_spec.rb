require 'rails_helper'

describe "The swap day feature", :type => :feature, :js => true do

	before(:each) do
		
		@user1 = User.create(name: Faker::Name.first_name)
		@user2 = User.create(name: Faker::Name.first_name)

		[@user1, @user2].each do |user|
			current_day = Date.today
			day = Day.new(user: user, date: current_day)
			while !day.valid?
				current_day = current_day.tomorrow
				day = Day.new(user: user, date: current_day)
			end
			day.save
		end

		ScheduledMonth.create_month_and_days(Date.today.month, Date.today.year)

		user2_date = @user2.days.first.date
		data_date = user2_date.strftime("%d-%m-20%y").split("-").map {|num| num.to_i}.join("-")
		query = "td[data-date=" + "'#{data_date}']"

		visit "/users/#{@user1.id}"
		sleep(2)
		find(query).hover
		option = first('#day_swap_request option').text
		select option, from: 'day_swap_request'
		find(query).find("input[type='submit']").click
	end

	

	it "should not swap users when user denys request" do
		user1_date = @user1.days.first.date
		visit "/users/#{@user2.id}"
		sleep(1)
		find("input[value='No']").click
		sleep(0.5)
		expect(@user1.days.first.date).to eq(user1_date)
	end

	it "should swap users when one user confirms" do
		user1_date = @user1.days.first.date

		visit "/users/#{@user2.id}"
		sleep(1)
		find("input[value='Yes']").click
		sleep(0.5)
		expect(@user2.days.first.date).to eq(user1_date)
	end


end