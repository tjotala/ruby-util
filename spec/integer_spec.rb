require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), '..', 'lib', File.basename(__FILE__).gsub(/_spec/, ''))

describe Integer do
	describe "to_comma" do
		it "should handle zero" do
			expect(0.to_comma).to be == "0"
		end

		it "should handle one to three digits" do
			expect(1.to_comma).to be == "1"
			expect(12.to_comma).to be == "12"
			expect(123.to_comma).to be == "123"
			expect(-123.to_comma).to be == "-123"
		end

		it "should handle four or more digits" do
			expect(1234.to_comma).to be == "1,234"
			expect(1234567.to_comma).to be == "1,234,567"
			expect(-1234567.to_comma).to be == "-1,234,567"
		end
	end
end
