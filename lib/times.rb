require "csv"

def strip_number(time)
	fixed_date = time[/\d{1,2}/]
	if fixed_date.length == 1
		fixed_date = "0" + fixed_date.to_s
	end
	fixed_date
end

def largest_in_hash(hash)
	hash.max_by{|key, value| value}
end

puts "Hour and Day with most registrations"

file = File.join("C:", "odin_project", "event_manager", "event_attendees.csv")
contents = CSV.open(file, headers: true)
list_dates = Hash.new(0)
list_hours = Hash.new(0)

contents.each do |row|
	year = row["RegDate"][/\/\d{1,2} /]
	year = ("20" + strip_number(year)).to_i
	month = row["RegDate"][/^\d{1,2}/]
	month = strip_number(month).to_i
	day = row["RegDate"][/\/\d{1,2}\//]
	day = strip_number(day).to_i
	date = Date.new(year, month, day)
	list_dates[date.wday] += 1
	
	hour = row["RegDate"][/\d{1,2}:/]
	hour = strip_number(hour).to_i
	list_hours[hour] += 1
	
end

#get first value in array of top key/value based on value
top_weekday = largest_in_hash(list_dates)[0]
top_hour = largest_in_hash(list_hours)[0]

puts "The most common day for people to sign up is #{Date::DAYNAMES[top_weekday]}"
puts "The most common time is between #{top_hour}:00 and #{top_hour}:59"
