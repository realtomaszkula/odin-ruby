class Hangman

	def initialize(name)
		@name = name
		@secret_word = get_secret
		@letters = @secret_word.split("")
		@bool_pairs = get_pairs
		@hangman = prototype
		@mistake = 0
		@turn = 0
	end

	def play
		loop do
			input = get_input

			temp_bool = @bool_pairs.dup
			if input.size > 1
				missd = check_word?(input)
			else
				missd = check_letter?(input)
			end

			unless missd
				@mistake += 1
			end

			draw_clues

			break if game_over?
		end
	end

	private

	def draw_clues
		@bool_pairs.each do |pair|
			if pair[1] == true
				print pair[1]
			else
				print "_"
			end
			" "
		end
	end


	def draw_hangman
		puts @hangman
	end

	def prototype
		line = []
		line[0]="___________"
		line[1]="|         |"
		line[2]="|         0 "
		line[3]="|        /|\\  "
		line[4]="|        / \\ "

		len = @secret_word.length - 1
		for i in 5..len
			line[i] = "|            "
		end
		line.join("\n")
	end


	def get_secret
		file = File.open("dictionary.txt",'r') do |fname|
			fname.read.split(/\n/).select {|word| word.size > 5}
		end
		file.sample
	end	

	def get_pairs
		@bool_pairs = @letters.map { |letter| [letter,false] }
	end
	
	def get_input
		puts "type a letter or try to guess a word"
		input = gets.chomp
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
		changed
	end

	def check_word?(word)
		@secret_word != word
	end

	def game_over?
		@mistake == @secret_word.size
	end



end

puts "Enter name to play Hangman"
name = gets.chomp
game = Hangman.new(name)
game.play





