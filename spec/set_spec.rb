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
			@empty.toggle("foo", false).should == [ ].to_set
		end

		it "should modify an empty set" do
			@empty.toggle("foo", true).should == [ "foo" ].to_set
		end

		it "should not modify non-empty set" do
			@not_empty.toggle("foo", true).should == [ "foo", "bar" ].to_set
		end

		it "should modify non-empty set" do
			@not_empty.toggle("foo", false).should == [ "bar" ].to_set
		end
	end
end
