require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DayAssignmentsHelper. For example:
#
# describe DayAssignmentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DayAssignmentsHelper, type: :helper do

	before(:each) do
		@user = User.create(name: "Rah")
		@date = "10-8-2015".to_date
		@day  = DayAssignment.create(user: @user, date: @date)
	end

	describe "user_from_date" do
		it "should return the user from a specific date" do
			expect(helper.user_from_date(@date)).to eq(@user)
		end
	end

	describe "assigned_day_from_date" do
		it "should return the assigned day from a date" do
			expect(helper.assigned_day_from_date(@date)).to eq(@day)
		end
	end
  
end
