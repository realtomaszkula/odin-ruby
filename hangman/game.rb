class Hangman
	@@turn = 0
	@@mistake = 0
	def initialize(name)
		@name = name
		@secret_word = get_secret
		@letters = @secret_word.split("")
		@bool_pairs = get_pairs
		@hangman = prototype
		play
	end

	def play
		loop do
			draw_clues
			input = get_input
			input.size > 1 ? victory?(input) : check_letter(input)
			p @bool_pairs
			break if game_over? || victory?(input)

			draw_hangman
		end
	end

	def draw_clues
		@letters.size.times {print "_ "} 
		puts "\n"
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
		@bool_pairs = []
		@letters.each { |letter| @bool_pairs << [letter,false] }
		@bool_pairs
	end
	
	def get_input
		puts "type a letter or try to guess a word"
		input = gets.chomp
	end
	

	
	def check_letter(letter)
		@bool_pairs.map! do |bool_pair| 
			if bool_pair[0] == letter
				bool_pair[0], bool_pair[1] = true, bool_pair[0]
			else 
				bool_pair[0], bool_pair[1] = false, bool_pair[0]
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

puts "Enter name to play HangMaaaan"
name = gets.chomp
Hangman.new(name)





