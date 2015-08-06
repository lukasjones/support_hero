class User < ActiveRecord::Base


	validates :name, presence: true

	has_many :day_assignments

	validate :wait_one_month_to_get_new_undoable_day

	after_commit :reschedule, on: :update

	

	def wait_one_month_to_get_new_undoable_day
		if self.no_can_do_day_was == nil
			true
		elsif self.no_can_do_day_was.month == Date.today.month
			errors.add(:wait_a_month, "You need to wait until next month to mark another day as undoable")
			p errors
		end
	end


  protected

	def reschedule
		sorted_scheduled_user_count_arr = get_sorted_amount_scheduled_for_each_user
		unschedule_day(self.no_can_do_day)
		sorted_scheduled_user_count_arr.each do |name, number|
			user = User.where(name: name)[0]
			day = DayAssignment.new(user: user, date: self.no_can_do_day)
			if day.valid?
				day.save
				break
			else
				next
			end
		end
	end


	def get_sorted_amount_scheduled_for_each_user
		list_of_users_working_arr = DayAssignment.all.map{ |day| day.user.name }
		count_hash = Hash.new(0)
		list_of_users_working_arr.each do |user_name|
			count_hash[user_name] += 1
		end
		count_hash.sort_by{ |k,v| v }
	end


	def unschedule_day(date)
		DayAssignment.where(date: date)[0].destroy
	end



	
	

end
