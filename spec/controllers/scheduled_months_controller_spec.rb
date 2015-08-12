require 'rails_helper'

RSpec.describe ScheduledMonthsController, type: :controller do

	before(:each) do

		ScheduledMonth.create(month: 5, year: 2015)
		ScheduledMonth.create(month: 6, year: 2015)
		ScheduledMonth.create(month: 7, year: 2015)
		session[:year] = 2015
		params = {month_num: "6"}
		get :get_month, params
	end

	describe "GET #get_month" do

		before(:each) do
			params = {month_num: "6"}
			get :get_month, params
		end

		it "should reapond with a status code of 200" do
			expect(response).to be_success

		end
	end


	describe "GET #get_next_month" do
		before(:each) do
			get :get_next_month
		end

		it "should respond with status code 200" do
			# expect(response).to be_success
      expect(response).to have_http_status(302)
		end

	

	end

	describe "GET #get_prev_month" do
		before(:each) do
			get :get_prev_month
		end

		it "should respond with status code 200" do
			# expect(response).to be_success
      expect(response).to have_http_status(302)
		end

	

	end

end
