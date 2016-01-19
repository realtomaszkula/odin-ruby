class Hangman
	def initialize(name)
		@name = name
		@secret_word = get_secret
		@letters = @secret_word.split("")
		@bool_pairs = get_pairs
	end

	def play
		input = get_input
		input.size > 1 ? check_word(input) : check_letter(input)
	end

	def get_secret
		file = File.open("dictionary.txt",'r') do |fname|
			file = fname.read.split(/\n/)
		end
		secret_word = file.sample
	end	

	def get_pairs
		@bool_pairs = []
		@letters.each { |letter| @bool_pairs << [letter,false] }
	end
	
	def get_input
		puts "type a letter or try to guess a word"
		input = gets.chomp
	end
	
	def check_word(word)
		 secret_word == word
	end
	
	def check_letter(letter)
		bool_letters.each do |bool_pair|
			@bool_pair[1] = true if @bool_pair[0] == letter
		end
	end
end

puts "Enter name to play HangMaaaan"
name = gets.chomp
Hangman.new(name)




