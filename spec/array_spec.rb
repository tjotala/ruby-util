require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), '..', 'lib', File.basename(__FILE__).gsub(/_spec/, ''))

describe Array do
	describe "numbers" do
		it "should handle empty array" do
			expect([ ].numbers).to be_empty
			expect([ nil ].numbers).to be_empty
		end

		it "should extract only numbers" do
			expect([ 0, 1, 2, 3, :foo, 4, 'bar', 5 ].numbers).to be == [ 0, 1, 2, 3, 4, 5 ]
		end
	end

	describe "middle" do
		it "should handle empty array" do
			expect([ ].middle).to be_empty
			expect([ nil ].middle).to be == [ nil ]
		end

		it "should extract middle item of a 1-item array" do
			expect([ 1 ].middle).to be == [ 1 ]
		end

		it "should extract middle items of a 2-item array" do
			expect([ 1, 2 ].middle).to be == [ 1, 2 ]
		end

		it "should extract middle item of an odd numbered array" do
			expect([ 1, 2, 3 ].middle).to be == [ 2 ]
		end

		it "should extract middle item of an even numbered array with more than 2 elements" do
			expect([ 1, 2, 3, 4 ].middle).to be == [ 2, 3 ]
		end
	end

	describe "column" do
		it "should handle empty array" do
			expect([ ].column(1)).to be_empty
			expect([ nil ].column(1)).to be == [ nil ]
		end

		it "should extract column 1" do
			expect([ [ 1, 2 ], [ 3, 4 ], [ 5 ] ].column(1)).to be == [ 2, 4, nil ]
		end
	end
	
	describe "sum" do
		it "should handle empty array" do
			expect([ ].sum).to be == 0
		end

		it "should compute sum of all elements" do
			expect([ 0, 1, 2, 'foo', 3, :bar, 4, 5 ].sum).to be == (0 + 1 + 2 + 0 + 3 + 0 + 4 + 5)
		end
	end

	describe "mean" do
		it "should handle empty array" do
			expect([ ].mean).to be == 0
		end

		it "should compute mean of all elements" do
			expect([ 0, 1, 2, 'foo', 3, :bar, 4, 5 ].mean).to be == (0 + 1 + 2 + 0 + 3 + 0 + 4 + 5) / 6.0
		end
	end

	describe "median" do
		it "should handle empty array" do
			expect([ ].median).to be == 0
		end

		it "should find median of all elements" do
			expect([ 4, 3, 2, 1, 0 ].median).to be == 2 # middle number
			expect([ 0, 1, 2, 3, 4, 5 ].median).to be == 2.5 # mean of two middle numbers
			expect([ 0, 1, 2, :foo, 'bar', 5 ].median).to be == 1.5 # mean of two middle numbers
		end
	end

	describe "histogram" do
		it "should handle empty array" do
			expect([ ].histogram).to be_empty
		end

		it "should compute histogram of all elements" do
			expect([ 0, 1, 2, 3, 2, 3, 3, 'foo', 5, :bar, 5, 4, 4, 4, 4, 5, 5, 5 ].histogram).to be == { 0 => 1, 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 'foo' => 1, :bar => 1 }
		end
	end

	describe "mode" do
		it "should handle empty array" do
			expect([ ].mode).to be_nil
		end

		it "should not find mode if there is none" do
			expect([ 0, 1, 2, 4 ].mode).to be_nil
		end

		it "should find mode of all elements" do
			expect([ 1 ].mode).to be == [ 1 ]
			expect([ 0, 1, 2, 3, 2, 3 ].mode).to be == [ 2, 3 ]
			expect([ 0, 1, 2, 3, 2, 3, 3, 5, 5, 'foo', 4, 4, 4, :bar, 4, 5, 5, 5 ].mode).to be == [ 5 ]
		end
	end

	describe "stringify" do
		it "should handle empty array" do
			expect([ ].stringify).to be_empty
		end

		it "should create strings of all elements" do
			expect([ :foo, :bar, 1, 'already_string', nil ].stringify).to be == [ 'foo', 'bar', '1', 'already_string', nil ]
		end
	end

	describe "symbolify" do
		it "should handle empty array" do
			expect([ ].symbolify).to be_empty
		end

		it "should create symbols of all elements" do
			expect([ :foo, 1, 'string', nil ].symbolify).to be == [ :foo, nil, :string, nil ]
		end
	end

	describe "join_sentence" do
		it "should handle empty array" do
			expect([ ].join_sentence).to be_empty
		end

		it "should handle an array with one item" do
			expect([ "foo" ].join_sentence).to be == "foo"
		end

		it "should handle an array with two items" do
			expect([ "foo", "bar" ].join_sentence).to be == "foo and bar"
		end

		it "should handle an array with three or more items" do
			expect([ "foo", "bar", "goo" ].join_sentence).to be == "foo, bar, and goo"
			expect([ "foo", "bar", "goo", "ber" ].join_sentence).to be == "foo, bar, goo, and ber"
		end
	end
end
