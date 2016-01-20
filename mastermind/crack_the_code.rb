class MasterMind
	def initialize(name)
		@player = Player.new(name)
		@board = Board.new
		@AI = AI.new
		@turn = 1
		play
	end	

	class Player
		attr_reader :name, :guess
		def initialize(name)
			@name = name
		end

		def get_guess
			puts "#{@name}, enter your guess:"
			guess = gets.chomp.to_i

			until guess.between?(1111,6666)
				puts "Incorrect input, try again"
				guess = gets.chomp.to_i
			end

			@guess = guess.to_s.split("").map(&:to_i)
		end
	end

	class AI
		attr_reader :numberwang, :clues
		def initialize
			@numberwang = [rand(1..6),rand(1..6),rand(1..6),rand(1..6)]

		end

		def eval(plr_guess)
			@clues = {
				blacks: 0,
				whites: 0
			}

			temp_wang = numberwang.dup
			temp_plr = plr_guess.dup
			
			temp_wang, temp_plr = eval_blacks(plr_guess, temp_wang, temp_plr)

			@clues[:blacks] = 4 - temp_wang.size
			@clues[:whites] = eval_whites(temp_wang, temp_plr)
		end


		def eval_blacks(plr_guess, temp_wang, temp_plr)
			indx = []
			for i in 0..3
				indx << i if temp_wang[i] == plr_guess[i]
			end
			indx.each_with_index {|x, i| temp_wang.delete_at(x-i)}
			indx.each_with_index {|x, i| temp_plr.delete_at(x-i)}
			return results = [temp_wang, temp_plr]
		end

		def eval_whites(temp_wang, temp_plr)
			counter = 0
			alr_chkd = []
			for i in 0..temp_wang.size-1
				for k in 0..temp_wang.size-1
					if temp_plr[i] == temp_wang[k] && !alr_chkd.include?(k)
							counter += 1
							alr_chkd << k
							next
					end	
				end
			end
			counter
		end

	end
	class Board
		attr_reader :board
		attr_writer :guess

		def initialize
			@board = ""
		end

		def draw_board(plr_guess, ai_clues, turn)
			@board << "#{plr_guess[0]}  - #{plr_guess[1]} - #{plr_guess[2]} - #{plr_guess[3]} \tBLACKS: #{ai_clues[:blacks]} WHITES: #{ai_clues[:whites]} Turn: #{turn}\n"
			puts @board
		end
	end

	def play
		puts "Welcome #{@player.name}\!\nComputer generated NUUUUMBERWANG, can you guess what it is?\n ? - ? - ? - ?"
		loop do
		  	@player.get_guess
		  	@AI.eval(@player.guess)
		  	@board.draw_board(@player.guess, @AI.clues, @turn)
			break if numberwang? || game_over?(@AI.numberwang)
		end
	end

	def game_over?(nwang)		
		if @turn == 10
			puts " *** Times Up, see you next week on NUMBERWANG! ***\n This weeks Numberwang was ... * #{nwang} *"
			return true
		end
		@turn += 1
		false
	end

	def numberwang?
	  if @AI.numberwang == @player.guess
	  	puts "\n *** THAAAATS NUMBERWANG!!! ***\n\tWinning number:\n\t#{@player.guess}\n*************************************"
	  	return true
	  end
	  false
	end
end

puts "Enter name:"
name = gets.chomp
MasterMind.new(name)