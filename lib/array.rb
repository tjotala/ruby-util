class Array
	unless defined?(numbers)
		# Extract all numbers
		def numbers
			find_all { |item| Float(item) rescue false }
		end
	end

	unless defined?(middle)
		# Extract middle element(s)
		def middle
			mid, rem = length.divmod(2)
			return [ at(mid) ] unless rem == 0
			slice(mid - 1, 2) || [ ]
		end
	end

	unless defined?(column)
		# Extract column N of a two (or more) dimensional array
		def column(col)
			map { |item| item.respond_to?(:[]) ? item[col] : nil }
		end
	end

	unless defined?(sum)
		# Compute sum of all numerical elements
		def sum
			numbers.reduce(0, :+)
		end
	end

	unless defined?(mean)
		# Compute mean (average) of all numerical elements
		def mean
			return 0 if empty?
			sum.fdiv(numbers.length)
		end
	end

	unless defined?(median)
		# Find the median (middle value) of all elements
		def median
			return 0 if empty?
			numbers.sort.middle.mean
		end
	end

	unless defined?(histogram)
		# Compute a histogram of all elements
		def histogram
			reduce(Hash.new(0)) { |h, v| h[v] += 1; h }
		end
	end

	unless defined?(top)
		# Generate a hash of top values: key is the count, value is an array of values having that count
		def top
			histogram.reduce(Hash.new { |h, k| h[k] = Array.new }) { |h, kv| h[kv.last] << kv.first; h }
		end
	end

	unless defined?(mode)
		# Find the mode (most common) of all items in the array
		def mode
			return nil if empty?
			counts = top
			count = counts.keys.max
			mode = counts[count]
			return nil if count == 1 and mode.length > 1
			mode
		end
	end

	unless defined?(stringify)
		# Convert all elements into strings
		def stringify
			map { |item| (item.nil? || !item.respond_to?(:to_s)) ? nil : item.to_s }
		end
	end

	unless defined?(symbolify)
		# Convert all elements into symbols
		def symbolify
			map { |item| (item.nil? || !item.respond_to?(:to_sym)) ? nil : item.to_sym }
		end
	end

	unless defined?(join_sentence)
		def join_sentence(sep = ", ", two_sep = " and ", final_sep = ", and ")
			case length
			when 0
				""
			when 1
				first.to_s
			when 2
				join(two_sep)
			else
				"#{self[0..-2].join(sep)}#{final_sep}#{last.to_s}"
			end
		end
	end
end
