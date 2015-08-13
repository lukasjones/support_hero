require 'rails_helper'

RSpec.describe Day, type: :model do

	let(:user) { User.create(name: "John", no_can_do_day: '12-12-2015'.to_date) }



	it "should save a day if all the fields are filled in correctly" do 
		day = Day.new(user: user, date: DateTime.now.to_date)
		expect(day.save).to eq(true)
	end


	it "should not save a day if the date is missing" do
		day = Day.new(user: user)
		expect(day.save).to eq(false)
	end

	it "should not save a day if the date has already been assigned" do
		day = Day.create(user: user, date: DateTime.now.to_date)
		day2 = Day.new(user: user, date: DateTime.now.to_date)
		expect(day2.save).to eq(false)
	end

	it "should not save a day on the weekend" do
		# Saturday August 1st 2015
		weekend_date = '1-8-2015'.to_date
		day = Day.new(user: user, date: weekend_date)
		expect(day.save).to eq(false)
	end

	it "should not save a day on a California Holiday" do
		holidays = ["01/01/2015", "19/01/2015", "16/02/2015", "31/03/2015", "25/05/2015", "04/07/2015", "07/09/2015", "11/11/2015", "26/11/2015", "27/11/2015", "25/12/2015"]
		day = Day.new(user: user, date: holidays.sample.to_date)
		expect(day.save).to eq(false)
	end

	it "should not save a day on a user's no_can_do_day" do
		day = Day.new(user: user, date: '12-12-2015'.to_date)
		expect(day.save).to eq(false)
	end

  
end
