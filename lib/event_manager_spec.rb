require "event_manager"

describe "fix_name" do
	it "Returns the name capitalized properly" do
		fix_name("jOHn").should == "John"
	end
end

describe "check_phone" do
	it "Returns nothing if phone number bad" do
		check_phone("4343").should == ""
	end
end

describe "It can return phone numbers" do
	describe "fix_phone" do
		it "Sets phone_number to '' if number is poor" do
			fix_phone("12345678").should == ""
		end
		
		it "Omits a leading 1 if the phone number is otherwise proper" do
			fix_phone("12223334444").should == "2223334444"
		end
	end

	describe "format_phone" do
		it "Returns a format in the form of (###) ###-####" do
			format_phone("1234567890").should == "(123) 456-7890"
		end
	end
	
	describe "check_phone" do
		it "Returns empty string if phone number bad" do
			check_phone("4343").should == ""
		end
		it "Returns a formatted number if the phone number is valid" do
			check_phone("1112223333").should == "(111) 222-3333"
		end
		it "Returns the formatted number even if country code included" do
			check_phone("19998887777").should == "(999) 888-7777"
		end
		it "Returns the formatted number even if number formatted oddly" do
			check_phone("+1 222 333/4444").should == "(222) 333-4444"
		end
	end

end

describe "It can make sure zip codes are accurate" do
	describe "check_zipcode" do
		it "Returns zipcode if it is correct" do
			check_zipcode("34543").should == "34543"
		end
		
		it "Appends zeroes if zipcode is less than five" do
			check_zipcode("454").should == "00454"
		end
	end
end