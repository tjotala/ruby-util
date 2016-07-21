require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), '..', 'lib', File.basename(__FILE__).gsub(/_spec/, ''))

describe PriorityQueue do
	before(:each) do
		@numbers = [ 2, 7, 17, 3, 25, 1, 100, 36, 19 ].freeze
		@empty = PriorityQueue.new
		@sample = PriorityQueue.new(@numbers)
	end

	describe "new" do
		it "should create an empty queue" do
			@empty.size.should == 0
			@empty.empty?.should == true
		end

		it "should initialize to a non-empty array" do
			@sample.size.should == @numbers.size
			@sample.empty?.should == false
			@sample.include?(@numbers.sample)
		end
	end

	describe "size/count" do
		it "should return 0 for an empty queue" do
			@empty.size.should == 0
			@empty.count.should == 0
		end

		it "should return non-zero for non-empty queue" do
			@sample.size.should == @numbers.size
			@sample.count.should == @numbers.size
		end
	end

	describe "empty?" do
		it "should return true for an empty queue" do
			@empty.empty?.should == true
		end

		it "should return false for non-empty queue" do
			@sample.empty?.should == false
		end
	end

	describe "reset!" do
		it "should reset to an empty queue" do
			@sample.reset!
			@sample.size.should == 0
		end

		it "should reset to a non-empty array" do
			@empty.reset!(@numbers)
			@empty.size.should == @numbers.size
			@empty.include?(@numbers.sample)
		end
	end

	describe "merge!" do
		it "should merge two empty queues" do
			@empty.merge!(@empty.dup)
			@empty.size.should == 0
		end

		it "should merge non-empty queue with empty queue" do
			@sample.merge!(@empty.dup)
			@sample.size.should == @numbers.size
			@sample.top.should == @numbers.max
			@sample.to_a.should == @numbers.sort.reverse
		end

		it "should merge two non-empty queues" do
			other = [ 150, 200, 50 ]
			@sample.merge!(PriorityQueue.new(other))
			@sample.size.should == @numbers.size + other.size
			@sample.top.should == (@numbers + other).max
			@sample.to_a.should == (@numbers + other).sort.reverse
		end
	end

	describe "each" do
		it "should not yield over empty queue" do
			expect { |b| @empty.each(&b) }.not_to yield_control
		end

		it "should yield elements in descending order" do
			expect { |b| @sample.each(&b) }.to yield_successive_args(*@numbers.sort.reverse)
		end
	end

	describe "to_a" do
		it "should return an empty array for an empty queue" do
			@empty.to_a.should be_empty
		end

		it "should return elements in descending order" do
			@sample.to_a.should == @numbers.sort.reverse
		end
	end

	describe "to_s" do
		it "should return an empty string for an empty queue" do
			@empty.to_s.should be_empty
		end

		it "should return elements in descending order with default separator" do
			@sample.to_s.should == @numbers.sort.reverse.join(',')
		end

		it "should return elements in descending order with different separator" do
			@sample.to_s('|').should == @numbers.sort.reverse.join('|')
		end
	end

	describe "first/top" do
		it "should return nil with empty queue" do
			@empty.first.should == nil
			@empty.top.should == nil
		end

		it "should return top item without removing it" do
			@sample.first.should == @numbers.max
			@sample.top.should == @numbers.max
			@sample.size.should == @numbers.size
		end
	end

	describe "last/bottom" do
		it "should return nil with empty queue" do
			@empty.last.should == nil
			@empty.bottom.should == nil
		end

		it "should return last item without removing it" do
			@numbers.should include(@sample.last)
			@numbers.should include(@sample.bottom)
			@sample.size.should == @numbers.size
		end
	end

	describe "pop" do
		it "should throw with empty queue" do
			@empty.pop.should == nil
		end

		it "should return top item" do
			@sample.pop.should == @numbers.max
			@sample.size.should == @numbers.size - 1
		end
	end

	describe "push" do
		it "should insert new element to top of empty queue" do
			sample = @numbers.sample
			@empty.push(sample)
			@empty.size.should == 1
			@empty.top.should == sample
		end

		it "should insert and re-balance new elements" do
			@numbers.each do |n|
				@empty.push(n)
			end
			@empty.size.should == @numbers.size
			@empty.top.should == @numbers.max
		end
	end

	describe "<<" do
		it "should insert new element to top of empty queue" do
			sample = @numbers.sample
			@empty << sample
			@empty.size.should == 1
			@empty.top.should == sample
		end

		it "should insert and re-balance new elements" do
			@numbers.each do |n|
				@empty << n
			end
			@empty.size.should == @numbers.size
			@empty.top.should == @numbers.max
		end
	end
end
