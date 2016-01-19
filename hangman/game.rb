class Hangman
	@@turn = 0
	def initialize(name)
		@name = name
		@secret_word = get_secret
		@letters = @secret_word.split("")
		@bool_pairs = get_pairs
		play
	end

	def play
		loop do
			input = get_input
			check_letter(input) if input.size > 1
			break if game_over? || victory?(input)
			draw_clues
			draw_hangman
		end
	end

	def draw_clues
		@letters.size.times {print "_ "} 
		puts "\n"
	end

	def draw_hangman		
	end

	def get_secret
		file = File.open("dictionary.txt",'r') do |fname|
			file = fname.read.split(/\n/)
		end
		file.sample
	end	

	def get_pairs
		@bool_pairs = []
		@letters.each { |letter| @bool_pairs << [letter,false] }
	end
	
	def get_input
		puts "type a letter or try to guess a word"
		input = gets.chomp
	end
	

	
	def check_letter(letter)
		@bool_pairs.each { |bool_pair| bool_pair[1] = true if bool_pair[0] == letter }
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




