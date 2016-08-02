require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), '..', 'lib', File.basename(__FILE__).gsub(/_spec/, ''))

describe Bignum do
	describe "to_comma" do
		it "should handle zero" do
			0.to_comma.should == "0"
		end

		it "should handle one to three digits" do
			1.to_comma.should == "1"
			12.to_comma.should == "12"
			123.to_comma.should == "123"
			-123.to_comma.should == "-123"
		end

		it "should handle four or more digits" do
			1234.to_comma.should == "1,234"
			1234567.to_comma.should == "1,234,567"
			1234567890.to_comma.should == "1,234,567,890"
			-1234567890.to_comma.should == "-1,234,567,890"
		end
	end
end
