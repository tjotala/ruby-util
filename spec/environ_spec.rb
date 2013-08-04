require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), '..', 'lib', 'environ.rb')

describe Kernel do
	describe "big_endian?" do
		it "should return false on an x86 machine" do
			case RUBY_PLATFORM
			when /(i\d86|x86|darwin)/
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
			when /(i\d86|x86|darwin)/
				little_endian?.should be_true
			when /java/
				raise "Unknown endianness on #{RUBY_PLATFORM}"
			else
				raise "Unknown platform #{RUBY_PLATFORM}"
			end
		end
	end
end
