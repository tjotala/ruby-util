module ZString
	class Translation
		attr_reader :locale_id, :table

		# parse ZString format: key=value
		def self.parse(str)
			str.scan(/(\$\$\$\/[^=]+)=(.*)/.freeze).flatten
		end

		# set active translation table
		def self.select(translation)
			@@active = translation
		end

		# find translation table matching a locale
		def self.find(locale_id)
			@@translations[locale_id]
		end

		# retrieve translated term for a key
		def self.[](key)
			@@active[key]
		end

		# initialize a translation table
		def initialize(locale_id)
			@table = Hash.new(nil)
			File.read("#{locale_id}.txt").each do |term|
				key, value = self.class.parse(term)
				@table[key] = value
			end
			@@translations ||= Hash.new(nil)
			@@translations[locale_id] = self
			@@active ||= self
		end

		# retrieve translated term for a key
		def [](key)
			@table[key]
		end
	end

	# return localized (and formatted) string based on key and 0-N parameters
	def LOC(str, *params)
		key, defValue = Translation.parse(str)
		value = Translation[key] || defValue
		value.gsub(/\^\d+/.freeze) { |arg| params.at(arg[1..5].to_i - 1) }
	end
end

include ZString

en = Translation.new('en-US')
fi = Translation.new('fi-FI')
jp = Translation.new('jp-JP')

puts LOC('$$$/Test/HelloWorld=Hello, world!')

Translation.select(fi)

puts LOC('$$$/Test/HelloWorld=Hello, world!')

Translation.select(jp)

puts LOC('$$$/Test/HelloPerson=Hello, ^1 ^2!', 'Joe', 'Smith')
