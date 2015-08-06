require 'rails_helper'

RSpec.describe CalendarController, type: :controller do

	describe "PUT #change_month" do
		before(:each) do
			params = {num: "5"}
			put :change_month, params
		end

		it "should respond with status code 200" do
			expect(response).to be_success
      expect(response).to have_http_status(200)
		end

		it "should render a partial" do 
			should render_template(:partial => 'shared/_calendar') 
		end

	end

end
