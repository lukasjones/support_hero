require 'rails_helper'

RSpec.describe UsersController, type: :controller do


	before(:each) do
		user = User.create(name: "John", email: "john@john.com", password: "john123")
		assignment = DayAssignment.create(user: user, date: DateTime.now.to_date)
	end

	describe "GET #index" do
		it "should respond with status code 200" do
			get :index

			expect(response).to be_success
      expect(response).to have_http_status(200)
      
		end

		it "should render the index template" do
			get :index
      expect(response).to render_template("index")
		end

		it "should assign @errors to an empty array" do
			get :index
			expect(assigns(:errors)).to eq([])
		end

		it "should assign todays_hero to user for current day assignment" do
			user = User.last
			get :index
			expect(assigns(:todays_hero).name).to eq(user.name)
		end

	end



end
