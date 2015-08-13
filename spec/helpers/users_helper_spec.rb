require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  describe "get_header_phrase" do

		it "should give you the weekend phrase if it's the weekend" do
			weekend_date = '8-8-2015'.to_date
			phrase = helper.get_header_phrase(weekend_date)
			expect(phrase).to eq("It's the weekend. No support today!")
		end

		it "should give you the current_user when it's not a weekend or California Holiday" do
			user = User.create(name: "John")
			working_date = "8-10-2015".to_date
			Day.create(user: user, date: working_date)
			phrase = helper.get_header_phrase(working_date)
			expect(phrase).to eq("Today's Support Hero is #{user.name}")
		end

		it "should give you the holiday phrase if it's a California holiday" do 		
			holiday_date = "1-1-2015".to_date
			phrase = helper.get_header_phrase(holiday_date)
			expect(phrase).to eq("It's a holiday! Go celebrate!")
		end
	end
end
