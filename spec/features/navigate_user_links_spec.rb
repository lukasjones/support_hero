require 'rails_helper'
describe "The User Links on index page", :type => :feature, :js => true do

	before :each do
	  @user = User.create(name: "Rah")
	  current_month = Date.today.month
	  current_year = Date.today.year
	  date = "1-#{current_month}-#{current_year}".to_date

	  @day = Day.new(user: @user, date: Date.today)
	  while !@day.valid?
	  	date = date.tomorrow
	  	@day = Day.new(user: @user, date: date)
	  end
	  @day.save

	  ScheduledMonth.create_month_and_days(current_month, current_year)
	end



	it "redirects to show page when you click on your name link" do
	  visit '/'
	  sleep(2)
	  click_link("Rah")
	  expect(page).to have_content "Instructions"
	end

end