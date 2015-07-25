class UsersController < ApplicationController
	def index
		@todays_hero = DayAssignment.where(date: DateTime.now.to_date)[0].user
	end

	def show
	end


end
