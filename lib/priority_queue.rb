#!/usr/bin/ruby

class PriorityQueue
	def initialize(arr = [ ])
		reset!(arr)
	end

	def size
		@queue.size
	end

	alias_method :count, :size

	def empty?
		@queue.size <= 0
	end

	def include?(v)
		@queue.include?(v)
	end

	def reset!(arr = [ ])
		@queue = arr.dup
		heapify!
	end

	def merge!(other)
		@queue = @queue + other.queue
		heapify!
	end

	def top
		@queue[first_index]
	end

	alias_method :first, :top

	def bottom
		@queue[last_index]
	end

	alias_method :last, :bottom

	def push(item)
		@queue << item
		bubble_up!(last_index)
	end

	alias_method :<<, :push

	def pop
		return nil if empty?
		swap!(first_index, last_index)
		max = @queue.pop
		bubble_down!(first_index)
		max
	end

	def each(&block)
		t = dup
		yield t.pop until t.empty?
		self
	end

	def to_a
		out = [ ]
		each { |item| out << item }
		out
	end

	def to_s(sep = ',')
		to_a.join(sep)
	end

	#=======================================
	protected
	#=======================================

	attr_reader :queue

	#=======================================
	private
	#=======================================

	def first_index
		0
	end

	def last_index
		@queue.size - 1
	end

	def bubble_up!(i)
		while i > first_index
			pi = (i - 1) / 2
			break if @queue[pi] >= @queue[i]
			swap!(i, pi)
			i = pi
		end
		self
	end

	def bubble_down!(i)
		while true
			ci = i * 2 + 1
			break if ci > last_index
			ci += 1 if ci < last_index && @queue[ci] < @queue[ci + 1]
			break if @queue[i] >= @queue[ci]
			swap!(i, ci)
			i = ci
		end
		self
	end

	def swap!(i, k)
		@queue[i], @queue[k] = @queue[k], @queue[i]
	end

	def heapify!
		last_index.downto(first_index + 1).each { |i| bubble_up!(i) }
		self
	end
end
