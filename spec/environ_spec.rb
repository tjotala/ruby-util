require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), '..', 'lib', File.basename(__FILE__).gsub(/_spec/, ''))

describe Kernel do
	describe "big_endian?" do
		it "should return false on an x86 machine" do
			case RUBY_PLATFORM
			when /(i\d86|x86|_64|darwin)/i
				big_endian?.should be_false
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
			when /(i\d86|x86|_64|darwin)/i
				little_endian?.should be_true
			when /java/
				raise "Unknown endianness on #{RUBY_PLATFORM}"
			else
				raise "Unknown platform #{RUBY_PLATFORM}"
			end
		end
	end
end
