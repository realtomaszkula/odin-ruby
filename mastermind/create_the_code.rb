class MasterMind
	attr_reader :win
	def initialize(name, code)
		@player = Player.new(name, code)
		@computer = AI.new
		@turn = 1
		@win = false
		game_play
	end

	Player = Struct.new(:name, :code)

	class AI
		attr_reader :name, :guess, :guess_again, :memory
		def initialize
			@name = "NUM_WANG_#{rand(3000)}"
			@guess = [rand(1..6),rand(1..6),rand(1..6),rand(1..6)]
			@memory = nil
		end

		def guess_again
			new_guess = []
			blacks = @memory[:blacks]
			whites = @memory[:whites]
			new_num = 4 - blacks - whites

			for i in 0..blacks-1
				new_guess << @guess[i]
			end

			for i in 0..new_num-1
				new_guess << rand(1..6)
			end	

			for i in 0..whites-1
				new_guess << @guess[blacks]
			end	

			@guess = new_guess
		end

		def commit_to_memory(clues)
			@memory = clues
		end
	end

	def eval_blacks(temp_plr_code, temp_ai_guess)
			indx = []
			for i in 0..3
				indx << i if temp_plr_code[i] == temp_ai_guess[i]
			end
			indx.each_with_index {|x, i| temp_plr_code.delete_at(x-i)}
			indx.each_with_index {|x, i| temp_ai_guess.delete_at(x-i)}
			return results = [temp_plr_code, temp_ai_guess]
	end

	def eval_whites(temp_plr_code, temp_ai_guess)
			counter = 0
			alr_chkd = []
			for i in 0..temp_plr_code.size-1
				for k in 0..temp_plr_code.size-1
					if temp_ai_guess[i] == temp_plr_code[k] && !alr_chkd.include?(k)
							counter += 1
							alr_chkd << k
							next
					end	
				end
			end
			counter
	end

	def eval (ai_guess, plr_code)
			victory(ai_guess) if ai_guess == plr_code

			@clues = {
				blacks: 0,
				whites: 0
			}

			temp_plr_code = plr_code.dup
			temp_ai_guess = ai_guess.dup
			
			temp_plr_code, temp_ai_guess = eval_blacks(temp_plr_code, temp_ai_guess)

			@clues[:blacks] = 4 - temp_plr_code.size
			@clues[:whites] = eval_whites(temp_plr_code, temp_ai_guess)

			@clues
	end

	def victory(ai_guess)
		puts "\n *** THAAAATS NUMBERWANG!!! ***\n\tWinning number:\n\t#{ai_guess}\n*************************************"
		@win = true
	end

	def defeat
		puts " *** Times Up, see you next week on NUMBERWANG! ***\n This weeks Numberwang was ... * #{@player.code} *"
	end

	def change_turn
		@turn += 1
	end


	def game_play
		puts "#{@player.name} vs #{@computer.name}"
		
		while @turn < 11 && !@win
		 
		  clues = eval(@computer.guess, @player.code)	
		  @computer.commit_to_memory(clues)

		  unless @win
		  	p @computer.guess
		  	p @computer.memory
		  end

		  @computer.guess_again
		  change_turn
		end
		defeat unless @win
	end

end


puts "Enter name:"
name = gets.chomp

puts "Enter secret code:"
code = gets.chomp.to_i

until code.between?(1111,6666)
	puts "Incorrect input, try again"
	code = gets.chomp.to_i
end

code = code.to_s.split("").map(&:to_i)
MasterMind.new(name, code)

# ### UNCOMMENT TO TEST THE WINRATE
# ### 8,68% winrate after 1 000 000 runs
# ### test for 100 000 or you will have to wait for 2min
# ### You also need to remove some p and puts to clean up the wintest or you will have to deal with console output spam while the test is running
# wins = 0
#  100_000.times do 
# 	single_game = MasterMind.new(name, code)
# 	wins += 1 if single_game.win 
# end 

# puts "\t#{wins} out of 100_000\n\t AI winrate = #{wins.to_f / 100000.to_f * 100}%"



