require 'yaml'

class Hangman

	def initialize
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
			puts "\e[H\e[2J"
			draw_interface
			input = get_input
			temp_bool = @bool_pairs.dup
			hit = input.size > 1 ?  check_word?(input) : check_letter?(input)

			@mistake += 1 unless hit
				
			break if game_over? || @win
		end
		@win ? won : lost
	end

	private

	def save_the_game
		yaml_string = serialize		
		File.open("./saves/save.txt", "w") do |f|
			f.puts yaml_string
		end

		print "\n\t\t\t*  Game saved!  *\n\t\t\t"
	end


	def serialize
		YAML::dump(self)
	end

	def draw_hangman
		puts "\n\n"
		puts @hangman[0..@mistake].join("\n")
		puts "\n\n"
	end

	def prototype
		line = []
		line[0]="\t\t\t___________"
		line[1]="\t\t\t|         |"
		line[2]="\t\t\t|         0 "
		line[3]="\t\t\t|        /|\\  "
		line[4]="\t\t\t|        / \\ "

		finish_the_hangman = @letters.size - 5
		(finish_the_hangman).times {line << "\t\t\t|            "} 

		line
	end


	def draw_clues
		print "\n\n\t\t\t"
		@bool_pairs.each do |pair|
			print pair[1] ? " #{pair[0]}" : " _"
		end
		print "\n\n"
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
		input = gets.downcase.chomp
		until input.size > 0 || input == "save" || input == "exit"
			puts "\t\t\t\tIncorrect input, try again"
			print "\t\t\t"
			input = gets.downcase.chomp
		end	

		case input 
		when "save"
			save_the_game
			get_input
		when "exit"
			puts "\e[H\e[2J"
			Kernel.exit
		end

		input
	end

	def draw_interface
		draw_hangman if @mistake > 0 
		puts "\t\tSAVE to save the game \t EXIT to ragequit".center(50)
		puts "\t\tTurns left: #{turns_left}"
		puts "\t\tmissed letters/words:"
		puts "\t\t#{@missd_letters.inspect}"
		draw_clues
		print "\t\t\t\t"
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

		@win = true if @bool_pairs.all? {|pair| pair[1] }
		@missd_letters << letter unless changed
		changed
	end

	def check_word?(word)
		@win = true if @secret_word == word 
		@secret_word == word
	end

	def game_over?
		@mistake == @secret_word.size
	end

	def lost
		puts %{
\t\t******************************
\t\t\tHANGED
\t\t******************************
\t\t\tword: #{@secret_word}
\t\t******************************
		}
	end

	def won
		puts %{\n\t\t**  CONGRATULATIONS! YOU WON! **}
	end
end

######################

def load_the_game
	last_file = Dir.glob("./*/*").sort_by { |fname| File.ctime(fname) }.last
	yaml_string = File.open("#{last_file}","r") {|fname| fname.read}
	x = YAML::load(yaml_string)
end


puts "Do you want to load previously saved game? Y/N"
input = gets.chomp
until input == "y" || input == "n"
	"Incorrect, try again"
	input = gets.chomp.downcase
end

case input
when  "n"
	game = Hangman.new
when "y"
	game = load_the_game
end

game.play









