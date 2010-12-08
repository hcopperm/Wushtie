#!usr/local/bin/ruby -w
module Sim
	class Game

		def initialize
			@points = 0
			@lexicon = {
				"i" => UserCommand.new("you fed the cat") {},
				"p" => UserCommand.new("she likes petting but still wants food") {@petting_times += 1; get_angry},
				"f" => UserCommand.new("Good job, you have successfully fed the cat") {@points += 1}, 
				"s" => UserCommand.new("You have this many points") {puts @points},
				"q" => UserCommand.new("bye!") {throw :break_out}
			}
			@petting_times = 0

		end

		def start
			puts "There is a wushtie."
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
		def get_angry
			if @petting_times == 2
				puts "wushtie is getting tired of the petting"
			elsif @petting_times >= 3
				puts "wushtie has had enough of the petting. you lose a point"
				@points -= 1 
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

