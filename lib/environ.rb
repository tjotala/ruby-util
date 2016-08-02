module Kernel
	unless defined?(big_endian?)
		def big_endian?()
			[ 1 ].pack('S') == [ 1 ].pack('n')
		end
	end

	unless defined?(little_endian?)
		def little_endian?()
			!big_endian?()
		end
	end
end
