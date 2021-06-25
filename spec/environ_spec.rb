require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), '..', 'lib', File.basename(__FILE__).gsub(/_spec/, ''))

describe Kernel do
	describe "big_endian?" do
		it "should return false on an x86 machine" do
			case RUBY_PLATFORM
			when /(i\d86|x86|x64|_64|darwin)/i
				expect(big_endian?).to be false
			when /java/
				raise "Unknown endianness on #{RUBY_PLATFORM}"
			else
				raise "Unknown platform #{RUBY_PLATFORM}"
			end
		end
	end

	describe "little_endian?" do
		it "should return true on an x86 machine" do
			case RUBY_PLATFORM
			when /(i\d86|x86|x64|_64|darwin)/i
				expect(little_endian?).to be true
			when /java/
				raise "Unknown endianness on #{RUBY_PLATFORM}"
			else
				raise "Unknown platform #{RUBY_PLATFORM}"
			end
		end
	end
end
