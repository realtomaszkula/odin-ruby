class Hangman
	@@turn = 0
	@@mistake = 0

	def initialize(name)
		@name = name
		@secret_word = get_secret
		@letters = @secret_word.split("")
		@bool_pairs = get_pairs
		@hangman = prototype
	end

	def play
		loop do
			p @bool_pairs
			input = get_input
			if input.size > 1
				victory?(input)
			else
				 check_letter(input)
			end

			p @bool_pairs
			break if game_over? || victory?(input)
		end
	end

	private
	def draw_clues
		# @bool_pairs.each do |bool_pair| 
		# 	if bool_pair[1]
		# 		print bool_pair[0]
		# 	else
		# 		print " "
		# 	end
		# end
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
	
	def check_letter(letter)
			@bool_pairs.map! do |bool_pair| 
			if bool_pair[0] == letter || bool_pair[1] == true
				bool_pair[0] = bool_pair[0], bool_pair[1] = true
			else 
				bool_pair[0] = bool_pair[0], bool_pair[1] = false
			end
		end
	end


	def game_over?
		@@turn += 1
		@@turn > 10
	end

	def victory?(word)
		@secret_word == word
	end

end

puts "Enter name to play Hangman"
name = gets.chomp
game = Hangman.new(name)
game.play





