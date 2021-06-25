require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), '..', 'lib', File.basename(__FILE__).gsub(/_spec/, ''))

describe Set do
	before(:all) do
		@empty = [ ].to_set
		@not_empty = [ "foo", "bar" ].to_set
	end

	describe "toggle" do
		it "should not modify from empty set" do
			expect(@empty.toggle("foo", false)).to be == [ ].to_set
		end

		it "should modify an empty set" do
			expect(@empty.toggle("foo", true)).to be == [ "foo" ].to_set
		end

		it "should not modify non-empty set" do
			expect(@not_empty.toggle("foo", true)).to be == [ "foo", "bar" ].to_set
		end

		it "should modify non-empty set" do
			expect(@not_empty.toggle("foo", false)).to be == [ "bar" ].to_set
		end
	end
end
