class Fixnum
	def to_comma
		to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
	end
end
