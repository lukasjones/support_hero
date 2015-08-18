class User < ActiveRecord::Base


	validates :name, presence: true

	has_many :days

	validate :wait_one_month_to_get_new_undoable_day

	after_commit :reschedule, on: :update

	

	def wait_one_month_to_get_new_undoable_day
		if self.no_can_do_day_was == nil
			true
		elsif self.no_can_do_day != nil && self.updated_at.month == Date.today.month
			errors.add(:wait_a_month, "You need to wait until next month to mark another day as undoable")
		end
	end


  protected

  # take off swap request
  # find day where swap requested and remove
  # take off has requested swap
  # put back on swap request

	def reschedule
		unschedule_day(self.no_can_do_day)
		
		# no can do day => 8-28-2015


		# remove any swap request undoable day has made 
		swap_day = Day.where(swap_request: self.no_can_do_day)[0]
		swap_day.update_attributes(swap_request: nil) if swap_day

		# remove swap_request on day being rescheduled and just remove has_requested_swap alltogether from undoable day
		undoable_day = Day.where(date: self.no_can_do_day)[0]
		swap_request = undoable_day.swap_request

		# set swap if swap_request isn't nil
		swap_request = swap_request.dup if swap_request

		# remove has_requested_swap from day requesting to swap with undoable day (put it back on in the end)
		day_requesting_swap = Day.where(date: swap_request)[0]
		day_requesting_swap.update_attributes(has_requested_swap: false)

		undoable_day.update_attributes(has_requested_swap: false, swap_request: nil)
		
		# get user who is scheduled least and assign them the day
		sorted_scheduled_user_count_arr = get_sorted_amount_scheduled_for_each_user
		sorted_scheduled_user_count_arr.each do |name, number|
			user = User.where(name: name)[0]
			undoable_day.update_attributes(user: user)
			if undoable_day.valid?
				undoable_day.save
				break
			end
		end

		# reset requests 
		undoable_day.update_attributes(swap_request: swap_request)
		day_requesting_swap.update_attributes(has_requested_swap: true)
	end


	def get_sorted_amount_scheduled_for_each_user
		users_day_count_hash = Hash.new
		User.all.each do |user|
			users_day_count_hash[user.name] = user.days.length
		end
		users_day_count_hash.sort_by{ |k,v| v }
	end


	def unschedule_day(date)
		Day.where(date: date)[0].update_attributes(user: nil);
	end



	
	

end
