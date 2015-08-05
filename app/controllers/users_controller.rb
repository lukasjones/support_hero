class UsersController < ApplicationController
	def index
		session[:show] = false
		@errors = []
		session[:year] = Date.today.year unless session[:year]
		session[:selected_user] = "not a user"
	end

	def show
		session[:show] = true
		@user = User.find(params[:id])
		session[:user_id] = @user.id
		session[:year] = Date.today.year unless session[:year]
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

	# make this work for all updates
	def update
		user = User.find(params[:id])
		if user.update_attributes({no_can_do_day: params[:user][:no_can_do_day].to_date})
			flash[:notice] = "successfully updated"
		else
			flash[:errors] = user.errors.values
		end

		redirect_to user
	end


end












