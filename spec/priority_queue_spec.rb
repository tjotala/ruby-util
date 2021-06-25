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
			expect(@empty.size).to be == 0
			expect(@empty.empty?).to be == true
		end

		it "should initialize to a non-empty array" do
			expect(@sample.size).to be == @numbers.size
			expect(@sample.empty?).to be == false
			expect(@sample).to include(@numbers.sample)
		end
	end

	describe "size/count" do
		it "should return 0 for an empty queue" do
			expect(@empty.size).to be == 0
			expect(@empty.count).to be == 0
		end

		it "should return non-zero for non-empty queue" do
			expect(@sample.size).to be == @numbers.size
			expect(@sample.count).to be == @numbers.size
		end
	end

	describe "empty?" do
		it "should return true for an empty queue" do
			expect(@empty.empty?).to be == true
		end

		it "should return false for non-empty queue" do
			expect(@sample.empty?).to be == false
		end
	end

	describe "reset!" do
		it "should reset to an empty queue" do
			@sample.reset!
			expect(@sample.size).to be == 0
		end

		it "should reset to a non-empty array" do
			@empty.reset!(@numbers)
			expect(@empty.size).to be == @numbers.size
			@empty.include?(@numbers.sample)
		end
	end

	describe "merge!" do
		it "should merge two empty queues" do
			@empty.merge!(@empty.dup)
			expect(@empty.size).to be == 0
		end

		it "should merge non-empty queue with empty queue" do
			@sample.merge!(@empty.dup)
			expect(@sample.size).to be == @numbers.size
			expect(@sample.top).to be == @numbers.max
			expect(@sample.to_a).to be == @numbers.sort.reverse
		end

		it "should merge two non-empty queues" do
			other = [ 150, 200, 50 ]
			@sample.merge!(PriorityQueue.new(other))
			expect(@sample.size).to be == @numbers.size + other.size
			expect(@sample.top).to be == (@numbers + other).max
			expect(@sample.to_a).to be == (@numbers + other).sort.reverse
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
			expect(@empty.to_a).to be_empty
		end

		it "should return elements in descending order" do
			expect(@sample.to_a).to be == @numbers.sort.reverse
		end
	end

	describe "to_s" do
		it "should return an empty string for an empty queue" do
			expect(@empty.to_s).to be_empty
		end

		it "should return elements in descending order with default separator" do
			expect(@sample.to_s).to be == @numbers.sort.reverse.join(',')
		end

		it "should return elements in descending order with different separator" do
			expect(@sample.to_s('|')).to be == @numbers.sort.reverse.join('|')
		end
	end

	describe "first/top" do
		it "should return nil with empty queue" do
			expect(@empty.first).to be == nil
			expect(@empty.top).to be == nil
		end

		it "should return top item without removing it" do
			expect(@sample.first).to be == @numbers.max
			expect(@sample.top).to be == @numbers.max
			expect(@sample.size).to be == @numbers.size
		end
	end

	describe "last/bottom" do
		it "should return nil with empty queue" do
			expect(@empty.last).to be == nil
			expect(@empty.bottom).to be == nil
		end

		it "should return last item without removing it" do
			expect(@numbers).to include(@sample.last)
			expect(@numbers).to include(@sample.bottom)
			expect(@sample.size).to be == @numbers.size
		end
	end

	describe "pop" do
		it "should throw with empty queue" do
			expect(@empty.pop).to be == nil
		end

		it "should return top item" do
			expect(@sample.pop).to be == @numbers.max
			expect(@sample.size).to be == @numbers.size - 1
		end
	end

	describe "push" do
		it "should insert new element to top of empty queue" do
			sample = @numbers.sample
			@empty.push(sample)
			expect(@empty.size).to be == 1
			expect(@empty.top).to be == sample
		end

		it "should insert and re-balance new elements" do
			@numbers.each do |n|
				@empty.push(n)
			end
			expect(@empty.size).to be == @numbers.size
			expect(@empty.top).to be == @numbers.max
		end
	end

	describe "<<" do
		it "should insert new element to top of empty queue" do
			sample = @numbers.sample
			@empty << sample
			expect(@empty.size).to be == 1
			expect(@empty.top).to be == sample
		end

		it "should insert and re-balance new elements" do
			@numbers.each do |n|
				@empty << n
			end
			expect(@empty.size).to be == @numbers.size
			expect(@empty.top).to be == @numbers.max
		end
	end
end
