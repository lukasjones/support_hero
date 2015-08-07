require 'rails_helper'

RSpec.describe DayAssignmentsController, type: :controller do

	before(:each) do
		# Day 1 is requesting to swap days with day 2
		@user1 = User.create(name: "John")
	  @user2 = User.create(name: "Linda") 

		@day1 = DayAssignment.create(date: '6-8-2015', user: @user1)
		@day2 = DayAssignment.create(date: '7-8-2015', user: @user2)
		@date_requesting_swap = '6-8-2015'

		params = {day_assignment: {swap_request: @date_requesting_swap, day_id: @day2.id}}

		put :swap_day, params
	end

	describe "PUT #swap_day" do
		

		it "should give the day being requested to swap a new swap_request value" do
			expect(@day2.reload.swap_request).to eq(@date_requesting_swap.to_date)
			@day1.reload
		end

		it "should give the day requesting to swap a new swap_request value" do
			expect(@day1.reload.has_requested_swap).to eq(true)
		end

	end


	describe "PUT #confirm_swap" do

		before(:each) do
			@day1.reload
			@day2.reload
			params = {day_assignment: {first_day_id: @day2.id, second_day_id: @day1.id}}
			put :confirm_swap, params

			@day1.reload
			@day2.reload
		end

		it "should swap the users of the two dates" do
			expect(@day1.user.name).to eq(@user2.name)
			expect(@day2.user.name).to eq(@user1.name)
		end

		it "should remove swap_request day2" do
			expect(@day2.swap_request).to eq(nil)
		end

		it "should remove has_requested_swap from day1" do
			expect(@day1.has_requested_swap).to eq(false)
		end
	end


	describe "PUT #reject_swap" do

		before(:each) do 

			@day1.reload
			@day2.reload
			params = {day_assignment: {first_day_id: @day2.id, second_day_id: @day1.id}}
			put :reject_swap, params
			@day1.reload
			@day2.reload

		end

		it "should not swap the users of days" do
			expect(@day1.user.name).to eq(@user1.name)
		end

		it "should remove swap_request day2" do
			expect(@day2.swap_request).to eq(nil)
		end

		it "should remove has_requested_swap from day1" do
			expect(@day1.has_requested_swap).to eq(false)
		end

	end




end
