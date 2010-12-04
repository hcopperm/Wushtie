#!usr/local/bin/ruby -w
module Sim
	class Wush

		def initialize
			@lexicon = {
				"i" => "***mew mew mew***",
				"f" => "***nom***",
				"p" => "***purr***"	
			}
		end

		def start
			if foods_time?
				foods_time_prompts
			else
				puts "The kitty isn't hungry."	
			end
		end

		

		def foods_time_prompts
			puts "Wushtie wants to be fed. Would you like to feed her? Press 'i' to ignore her, 'f' to feed her, or 'p' to pet her."			
				s = usr_input
				if @lexicon[s] != nil
					puts @lexicon[s]
					if s == "i"
						puts "Wushtie is not happy about being ignored."
						start
					elsif s == "p"
						puts "Wushtie likes the petting but she is still hungry."
						start
					end
				else
					puts "That doesn't mean anything. The wushtie is still hungry!"
					start	
				end	
			


		end

### Utils ###

#		#are we within 3 hours of a time?
		def near_enough?(time1, time2, time3)
			if (time1-time2).abs <= 3 || (time1-time3).abs <= 3
				true
 			end
		end

		def foods_time?
			if near_enough?(Time.now.hour, 17, 7)
				true
			end
		end

		def usr_input
			STDIN.readline.strip!
		end
	
	end
end


