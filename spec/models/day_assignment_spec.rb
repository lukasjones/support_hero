require 'rails_helper.rb'

describe "Day Assignment Model" do

	let(:user) { User.create(name: "John Doe", email: "john@doe.com", password: "johndoe123") }



	it "should save a day assignment if all the fields are filled in correctly" do 
		day_assignment = DayAssignment.new(user: user, date: DateTime.now.to_date)
		expect(day_assignment.save).to eq(true)
	end

	it "should not save a day assignment if the user is missing" do
		day_assignment = DayAssignment.new(date: DateTime.now.to_date)
		expect(day_assignment.save).to eq(false)
	end

	it "should not save a day assignment if the email is missing" do
		day_assignment = DayAssignment.new(user: user)
		expect(day_assignment.save).to eq(false)
	end

	it "should not save a day assigment if the date has already been assigned" do
		day_assignment = DayAssignment.create(user: user, date: DateTime.now.to_date)
		day_assignment2 = DayAssignment.new(user: user, date: DateTime.now.to_date)
		expect(day_assignment2.save).to eq(false)
	end

	
end