class DaysController < ApplicationController

	def swap_day

		day = Day.find(params[:day][:day_id])

		day.update_attributes(swap_request: params[:day][:swap_request].to_date)
		Day.where(date: params[:day][:swap_request].to_date)[0].update_attributes(has_requested_swap: true)
		if day.errors
			flash[:errors] = day.errors
		end
		redirect_to "/users/#{session[:user_id]}"
	end



	def confirm_swap
		day1 = Day.find(params[:day][:first_day_id])
		day2 = Day.find(params[:day][:second_day_id])

		user1 = day1.user
		user2 = day2.user

		if day1.swap_request == day2.date && day2.swap_request == day1.date
			day1.update_attributes(swap_request: nil, has_requested_swap: false, user: user2)
			day2.update_attributes(swap_request: nil, has_requested_swap: false, user: user1)
		else
			day1.update_attributes(user: user2, swap_request: nil)
			day2.update_attributes(user: user1, has_requested_swap: false)
		end

		redirect_to "/users/#{session[:user_id]}"
	end

	def reject_swap
		day1 = Day.find(params[:day][:first_day_id])
		day2 = Day.find(params[:day][:second_day_id])
		day1.update_attributes(swap_request: nil)
		day2.update_attributes(has_requested_swap: false)


		redirect_to "/users/#{session[:user_id]}"
	end

end
