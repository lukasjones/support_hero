require 'rails_helper'

describe "The Find Form", :type => :feature do

  before :each do
    @user = User.create(name: "Rah")
    @day = DayAssignment.create(user: @user, date: Date.today)
  end

  it "redirects to show page on find form submit with correct credentials" do
    visit '/'
    within("form") do
      fill_in 'find[name]', :with => 'Rah'
      click_button 'submit'
    end
    expect(page).to have_content 'Instructions'
  end

  it "does not redirect to show page on find form submit with bad credentials" do
    visit '/'
    within("form") do
      fill_in 'find[name]', :with => 'not a user'
      click_button 'submit'
    end
    expect(page).to have_content "The name you typed in does not exist"
  end


end