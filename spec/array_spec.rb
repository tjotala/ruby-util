require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), '..', 'lib', File.basename(__FILE__).gsub(/_spec/, ''))

describe Array do
	before(:all) do
		@empty = [ ]
		@nil = [ nil ]
	end

	describe "numbers" do
		it "should handle empty array" do
			@empty.numbers.should == @empty
			@nil.numbers.should == @empty
		end

		it "should extract only numbers" do
			[ 0, 1, 2, 3, :foo, 4, 'bar', 5 ].numbers.should == [ 0, 1, 2, 3, 4, 5 ]
		end
	end

	describe "middle" do
		it "should handle empty array" do
			@empty.middle.should == @empty
			@nil.middle.should == @nil
		end

		it "should extract middle item of a 1-item array" do
			[ 1 ].middle.should == [ 1 ]
		end

		it "should extract middle items of a 2-item array" do
			[ 1, 2 ].middle.should == [ 1, 2 ]
		end

		it "should extract middle item of an odd numbered array" do
			[ 1, 2, 3 ].middle.should == [ 2 ]
		end

		it "should extract middle item of an even numbered array with more than 2 elements" do
			[ 1, 2, 3, 4 ].middle.should == [ 2, 3 ]
		end
	end

	describe "column" do
		it "should handle empty array" do
			@empty.column(1).should == @empty
			@nil.column(1).should == @nil
		end

		it "should extract column 1" do
			[ [ 1, 2 ], [ 3, 4 ], [ 5 ] ].column(1).should == [ 2, 4, nil ]
		end
	end
	
	describe "sum" do
		it "should handle empty array" do
			@empty.sum.should == 0
		end

		it "should compute sum of all elements" do
			[ 0, 1, 2, 'foo', 3, :bar, 4, 5 ].sum.should == (0 + 1 + 2 + 0 + 3 + 0 + 4 + 5)
		end
	end

	describe "mean" do
		it "should handle empty array" do
			@empty.mean.should == 0
		end

		it "should compute mean of all elements" do
			[ 0, 1, 2, 'foo', 3, :bar, 4, 5 ].mean.should == (0 + 1 + 2 + 0 + 3 + 0 + 4 + 5) / 6.0
		end
	end

	describe "median" do
		it "should handle empty array" do
			@empty.median.should == 0
		end

		it "should find median of all elements" do
			[ 4, 3, 2, 1, 0 ].median.should == 2 # middle number
			[ 0, 1, 2, 3, 4, 5 ].median.should == 2.5 # mean of two middle numbers
			[ 0, 1, 2, :foo, 'bar', 5 ].median.should == 1.5 # mean of two middle numbers
		end
	end

	describe "histogram" do
		it "should handle empty array" do
			@empty.histogram.should be_empty
		end

		it "should compute histogram of all elements" do
			[ 0, 1, 2, 3, 2, 3, 3, 'foo', 5, :bar, 5, 4, 4, 4, 4, 5, 5, 5 ].histogram.should == { 0 => 1, 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 'foo' => 1, :bar => 1 }
		end
	end

	describe "mode" do
		it "should handle empty array" do
			@empty.mode.should == nil
		end

		it "should not find mode if there is none" do
			[ 0, 1, 2, 4 ].mode.should == nil
		end

		it "should find mode of all elements" do
			[ 1 ].mode.should == [ 1 ]
			[ 0, 1, 2, 3, 2, 3 ].mode.should == [ 2, 3 ]
			[ 0, 1, 2, 3, 2, 3, 3, 5, 5, 'foo', 4, 4, 4, :bar, 4, 5, 5, 5 ].mode.should == [ 5 ]
		end
	end

	describe "stringify" do
		it "should handle empty array" do
			@empty.stringify.should be_empty
		end

		it "should create strings of all elements" do
			[ :foo, :bar, 1, 'already_string', nil ].stringify.should == [ 'foo', 'bar', '1', 'already_string', nil ]
		end
	end

	describe "symbolify" do
		it "should handle empty array" do
			@empty.symbolify.should be_empty
		end

		it "should create symbols of all elements" do
			[ :foo, 1, 'string', nil ].symbolify.should == [ :foo, nil, :string, nil ]
		end
	end

	describe "join_sentence" do
		it "should handle empty array" do
			@empty.join_sentence.should be_empty
		end

		it "should handle an array with one item" do
			[ "foo" ].join_sentence.should == "foo"
		end

		it "should handle an array with two items" do
			[ "foo", "bar" ].join_sentence.should == "foo and bar"
		end

		it "should handle an array with three or more items" do
			[ "foo", "bar", "goo" ].join_sentence.should == "foo, bar, and goo"
			[ "foo", "bar", "goo", "ber" ].join_sentence.should == "foo, bar, goo, and ber"
		end
	end
end
