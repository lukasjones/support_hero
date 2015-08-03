class DayAssignmentsController < ApplicationController

	def swap_day
		day = DayAssignment.find(params[:day_assignment][:day_id])
		day.update_attributes(swap_request: params[:day_assignment][:swap_request])
		redirect_to "/users/#{session[:user_id]}"
	end

end


{"utf8"=>"✓", "authenticity_token"=>"RovsNbmduilbwMkZ+IborMf1/NueYDWu2NmvLbNOTi6EH8gXJV2oLRSxIa5jf2Sazy+VRYDvmOlY4dFkOvY/zQ==", "day_assignment"=>{"swap_request"=>"August 12, 2015", "day_id"=>"49"}, "commit"=>"ask to swap!"}