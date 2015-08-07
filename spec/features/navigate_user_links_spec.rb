require 'rails_helper'
describe "The User Links on index page" do
	before :each do
	  @user = User.create(name: "Rah")
	  @day = DayAssignment.create(user: @user, date: Date.today)
	end
	it "displays the current user" do
	  visit '/'
	  expect(page.has_content?("Today's Support Hero is Rah")).to eq(true)
	end

	it "redirects to show page when you click on your name link" do
	  visit '/'
	  click_link("Rah")
	  expect(page).to have_content "Instructions"
	end

end