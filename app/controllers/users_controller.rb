class UsersController < ApplicationController

	before_filter :set_year, only: [:index, :show]
	before_filter :set_user, only: [:show, :update]

	def index
		session[:show] = false
		session[:selected_user] = "not a user"
	end

	def show
		session[:show] = true
		session[:user_id] = @user.id
		session[:selected_user] = @user.name
	end

	def find
		name = params[:find][:name].downcase.capitalize
		user = User.where(name: name)[0]
		if user
			redirect_to user
		else
			flash[:errors] = ["The name you typed in does not exist"]
			redirect_to root_path
		end
	end

	# make this work for all updates
	def update
		if @user.update_attributes({no_can_do_day: params[:user][:no_can_do_day].to_date})
			flash[:notice] = "successfully updated"
		else
			flash[:errors] = @user.errors.values
		end

		redirect_to @user
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def set_year
		session[:year] = Date.today.year unless session[:year]
	end

end












