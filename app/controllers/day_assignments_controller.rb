class DayAssignmentsController < ApplicationController

	def swap_day

		day = DayAssignment.find(params[:day_assignment][:day_id])

		day.update_attributes(swap_request: params[:day_assignment][:swap_request].to_date)
		DayAssignment.where(date: params[:day_assignment][:swap_request].to_date)[0].update_attributes(has_requested_swap: true)
		if day.errors
			flash[:errors] = day.errors
		end
		redirect_to "/users/#{session[:user_id]}"
	end



	def confirm_swap
		day1 = DayAssignment.find(params[:day_assignment][:first_day_id])
		day2 = DayAssignment.find(params[:day_assignment][:second_day_id])

		user1 = day1.user
		user2 = day2.user

		day1.update_attributes(user: user2, swap_request: nil)
		day2.update_attributes(user: user1, has_requested_swap: false)

		redirect_to "/users/#{session[:user_id]}"
	end

	def reject_swap
		day1 = DayAssignment.find(params[:day_assignment][:first_day_id])
		day2 = DayAssignment.find(params[:day_assignment][:second_day_id])
		day1.update_attributes(swap_request: nil)
		day2.update_attributes(has_requested_swap: false)


		redirect_to "/users/#{session[:user_id]}"
	end

end


