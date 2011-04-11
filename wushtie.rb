#!usr/local/bin/ruby -w
module Sim
	class Game

		ACTIONWORDS = ["feed", "pet", "ignore", "brush"]

		THINGS = ["wushtie"]


		def initialize
			@points = 0
			@lexicon = {
				"i" => UserCommand.new("You ignored the wushtie.") {@not_feeding_times += 1; @make_her_mad[@not_feeding_times].execute},
				"p" => UserCommand.new("You pet the wushtie.") {@not_feeding_times += 1; @make_her_mad[@not_feeding_times].execute},
				"feed" => UserCommand.new("Good job, you have successfully fed the cat.") {@not_feeding_times -= 1;if @not_feeding_times < 0; @not_feeding_times = 0;end}, 
				"s" => UserCommand.new("You are bleeding this much:") {puts @bleeding},
				"r" => UserCommand.new("There is a wushtie. You can feed her, [p]et her, [i]gnore her, or press [s] to see how much you are bleeding. After you've fed her, you can [q]uit. Press [r] to see this message again.") {},
				"q" => UserCommand.new("bye!") {throw :break_out}
			}

			@make_her_mad = {
				1 => UserCommand.new("But she is still hungry.") {},
				2 => UserCommand.new("Wushtie is getting tired of that.") {},
				3 => UserCommand.new("Wushtie has had enough of this no foods business. You get a warning pat.") {},
				4 => UserCommand.new("Not enough feeding. You get whacked.") {@bleeding += 1;@not_feeding_times = 0}
			}

			@not_feeding_times = 0
			@bleeding = 0
		end

		def start
			puts @lexicon["r"].execute 
			catch :break_out do
				loop{
					reply = usr_input 
					if !@lexicon[reply].nil?
						@lexicon[reply].execute 
					else
						puts "I'm sorry, I don't know what that means."
					end
				} 
			end
		end
		def parse_user_input(input)
				parts = input.split(" ")
				
				if ACTIONWORDS.include?(parts[0]) 
					puts "hallo"
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

	#compy's response + appropriate code to execute	
	class UserCommand	
		def initialize(response, &block)
			@response = response
			@action = block
		end

		def execute
			puts @response
			@action.call
		end


	end


end

Sim::Game.new.start

