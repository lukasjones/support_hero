class UsersController < ApplicationController
	def index
		@errors = []
		session[:selected_user] = "not a user"
	end

	def show
		@user = User.find(params[:id])
		session[:selected_user] = @user.name
	end

	def find
		user = User.where(name: params[:find][:name])[0]

		if user
			redirect_to user
		else
			@todays_hero = DayAssignment.where(date: DateTime.now.to_date)[0].user
			@errors = ["The name you typed in does not exist"]
			render "index"
		end
	end

	


end












