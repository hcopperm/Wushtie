#!usr/local/bin/ruby -w
module Bing
	class Wushtie
		def initialize
			@name = "Yonder Wudge"
			@fuds = [] 
			@litterbox = []
		end

		def say_mew
			puts "mew mew mew"
		end
		
		def foods_time?
			if near_enough?(Time.now.hour, 17, 7)
				true
			end
		end

		def alert
			if foods_time? and @fuds.empty?
				say_mew
			elsif !@litterbox.empty? 
				say_mew
			end 
		end

		#are we within 3 hours of a time?
		def near_enough?(time1, time2, time3)
			if (time1-time2).abs <= 3 || (time1-time3).abs <= 3
				true
 			end
		end

		def poop
			@litterbox << "poop" 
		end

	end

	class Person
		def initialize
			@name="d00d"
		end
		
		def feed_wushtie(wushtie, foods)
			wushtie.fuds << foods
		end

	end

end

wushtie = Bing::Wushtie.new

wushtie.alert
