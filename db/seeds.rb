# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


starting_line_up = ["Sherry", "Boris", "Vicente", "Matte", "Jack", "Sherry",
 "Matte", "Kevin", "Kevin", "Vicente", "Zoe", "Kevin",
 "Matte", "Zoe", "Jay", "Boris", "Eadon", "Sherry",
 "Franky", "Sherry", "Matte", "Franky", "Franky", "Kevin",
 "Boris", "Franky", "Vicente", "Luis", "Eadon", "Boris",
 "Kevin", "Matte", "Jay", "James", "Kevin", "Sherry",
 "Sherry", "Jack", "Sherry", "Jack"]

starting_users = starting_line_up.uniq

# Creating Users

starting_users.each do |name|
 	User.create(name: name)
end


# Creating Day Assignments
date = DateTime.now.to_date
starting_line_up.each do |name|
	user = User.where(name: name)[0]

	assignment = Day.new(user: user, date: date)
	if assignment.valid?
		assignment.save
		date = date.tomorrow
	else
		while !assignment.valid?
			date = date.tomorrow
			assignment = Day.new(user: user, date: date)
		end
		assignment.save
	end
end

