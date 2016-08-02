module NumberFormatter
	def to_comma
		(negative?? '-' : '') + abs.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
	end

	def negative?
		self < 0
	end
end
