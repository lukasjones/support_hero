require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ScheduledMonthsHelper. For example:
#
# describe ScheduledMonthsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ScheduledMonthsHelper, type: :helper do

  describe "month_integer_to_string" do
  	it "should return the month name given a month integer" do
  		expect(helper.month_integer_to_string(1)).to eq("January")
  	end
  end

  describe "pretty_date" do
  	it "should return the date in a format of 'Month_name day_number, year' " do
  		date = "8-8-2015".to_date
  		expect(pretty_date(date)).to eq("August 8, 2015")
  	end
  end

  
end
