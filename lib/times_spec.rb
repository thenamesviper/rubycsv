require "times.rb"

describe "strip_number" do
	it "returns numbers without backslashes" do
		strip_number("23/").should == "23"
	end
	it "adds leading zero if it's absent" do
		strip_number("3/").should == "03"
	end
	it "Works with day as well" do	
		strip_number("/12/").should == "12"
	end
	it "Works with year as well" do
		strip_number("/4").should == "04"
	end
end
