require "csv"
require "sunlight/congress"
require "erb"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def fix_name(name)
	name.downcase.capitalize!
end

def check_phone(phone_number)
	#get only digits in string
	number = phone_number.scan(/\d+/).join
	if number.length != 10
		number = fix_phone(number)
	end
	
	if number != ""
		number = format_phone(number)
	end
	
	number
end

def fix_phone(phone_number)
	fixed_phone = ""
	if phone_number.length == 11
		if phone_number[0] == "1"
			fixed_phone = phone_number[1..10]
		end
	end
	fixed_phone
end

def format_phone(phone_number) 
	formatted_number = "(#{phone_number[0..2]}) #{phone_number[3..5]}-#{phone_number[6..9]}"
end

def check_zipcode(zipcode)
	while zipcode.to_s.length < 5
		zipcode = "0" + zipcode.to_s
	end
	zipcode[0..4]
end

def legislators_by_zipcode(zipcode)
	Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_form(id, form_letter) 
	filename = "output/thanks_#{id}.html"
	
	File.open(filename, "w") do |file|
		file.puts form_letter
	end
end
=begin
puts "EventManager Initialized!"
Dir.mkdir("output") unless Dir.exists? "output"

file = File.join("C:", "odin_project", "event_manager", "event_attendees.csv")
template_letter_file = File.join("C:", "odin_project", "event_manager", "form_letter.erb")
template_letter = File.read(template_letter_file)
erb_template = ERB.new template_letter

contents = CSV.open(file, headers: true, header_converters: :symbol)


contents.each do |row|
	id = row[0]
	first_name = row[:first_name]
	first_name = fix_name(first_name)
	last_name = row[:last_name]
	last_name = fix_name(last_name)
	
	street = row[:street]
	city = row[:city]
	state = row[:state]
	phone_number = row[:homephone]
	phone_number = check_phone(phone_number)
	
	zipcode = row[:zipcode]
	zipcode = check_zipcode(zipcode)
	legislators = legislators_by_zipcode(zipcode)
	form_letter = erb_template.result(binding)
	save_form(id, form_letter)	
end

=end

	
