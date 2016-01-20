class Hangman

	def initialize(name)
		@name = name.upcase
		@secret_word = get_secret
		@letters = @secret_word.split("")
		@bool_pairs = get_pairs
		@hangman = prototype
		@mistake = 0
		@turn = 0
		@win = false
		@missd_letters = []
	end

	def play
		loop do
			puts @secret_word
			draw_clues
			input = get_input
			temp_bool = @bool_pairs.dup
			if input.size > 1
				hit = check_word?(input)
			else
				hit = check_letter?(input)
			end

			unless hit
				@mistake += 1
				@punish = true
			end

			if @punish
				draw_hangman
				@punish = false
			end

			break if game_over? || @win
		end

		@win ? won : lost
	end

	private

	def draw_clues
		print "\n\n"
		@bool_pairs.each do |pair|
			print pair[1] ? " #{pair[0]}" : " _"
		end
		print "\n\n"
	end


	def draw_hangman
		puts "\n\n"
		puts @hangman[0..@mistake].join("\n")
		puts "\n\n"
	end

	def prototype
		line = []
		line[0]="\t___________"
		line[1]="\t|         |"
		line[2]="\t|         0 "
		line[3]="\t|        /|\\  "
		line[4]="\t|        / \\ "

		finish_the_hangman = @letters.size - 5
		(finish_the_hangman).times {line << "\t|            "} 

		line
	end


	def get_secret
		file = File.open("dictionary.txt",'r') do |fname|
			fname.read.split(/\n/).select {|word| word.size > 5}
		end
		file.sample.downcase
	end	

	def get_pairs
		@bool_pairs = @letters.map { |letter| [letter,false] }
	end
	
	def get_input
		puts "#{@name}, type a letter or try to guess a word"
		puts "Turns left: #{turns_left}, missed letters/words: #{@missd_letters.inspect}"

		input = gets.downcase.chomp
		until input.size > 0
			puts "Incorrect input, try again"
			input = gets.downcase.chomp
		end	
		input
	end

	def turns_left
		@turns_left = @letters.size - @mistake
	end
	
	def check_letter?(letter)
		changed = false
			@bool_pairs.map! do |bool_pair| 
			if bool_pair[0] == letter || bool_pair[1] == true
					changed = true if bool_pair[1] == false 
				bool_pair[0] = bool_pair[0], bool_pair[1] = true
			else 
				bool_pair[0] = bool_pair[0], bool_pair[1] = false
			end
		end
		@missd_letters << letter unless changed
		changed
	end

	def check_word?(word)
		@win = true if @secret_word == word 
		@secret_word != word
	end

	def game_over?
		@mistake == @secret_word.size
	end

	def lost
		puts %{
\t******************************
\t\tHANGED
\t******************************
\t\tword: #{@secret_word}
\t******************************
		}
	end

	def won
		puts %{CONGRATULATIONS! YOU WON!}
		puts %{WINNING WORD: #{@secret_word}}
	end



end

puts "Enter name to play Hangman"
name = gets.chomp
game = Hangman.new(name)
game.play





