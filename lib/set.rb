class Set
	unless defined?(numbers)
		def toggle(value, flag)
			flag ? add(value) : delete(value)
		end
	end
end
