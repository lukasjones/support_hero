require 'rails_helper'

RSpec.describe UsersController, type: :controller do



	describe "GET #index" do

		before(:each) do
			user = User.create(name: "John")
			assignment = DayAssignment.create(user: user, date: Date.today)
			get :index
		end

		it "should respond with status code 200" do
			expect(response).to be_success
      expect(response).to have_http_status(200)
		end

		it "should render the index template" do
      expect(response).to render_template("index")
		end

	

	end



	describe "GET #show" do

		before(:each) do
			user = User.create(name: "Rah")
			get :show, id: user.id
		end

		it "should respond with a status code of 200" do
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end



		it "should set session[:user_id] to id of show page user" do
			user = User.last
			expect(session[:user_id]).to eq(user.id)
		end

	end


	describe "POST #find" do

		

		it "should redirect to the show page of user name is in database" do

			user = User.create(name: "Lah")
			params={}
			params[:find] = {}
			params[:find][:name] = "Lah"

			post :find, params

			expect(response).to redirect_to("/users/#{user.id}")

		end

		it "should not redirect and stay on home page if name provided is not in database" do
			params={}
			params[:find] = {}
			params[:find][:name] = "Not a user"

			post :find, params

			expect(response).to redirect_to("/")	
		end

	end

	describe "PUT #update" do

		it "should update a user's no_can_do_day to the date specified" do
			user = User.create(name: "John")

			params={}
			params[:id]   = user.id
			params[:user] = {}
			params[:user][:no_can_do_day] = Date.today

			put :update, params

			expect(user.reload.no_can_do_day).to eq(Date.today)

		end


	end



end
