file = File.open("dictionary.txt",'r') do |fname|
	file = fname.read.split(/\n/)
end

secret_word = file.sample
letters = secret_word.split("")
bool_letters = []

letters.each { |letter| bool_letters << [letter,false] }

p bool_letters


puts "type a letter or try to guess a word"
input = gets.chomp

if input.size > 1
	check_word(input)
else
	check_letter(input)
end

def check_word(word)
	 secret_word == word
end

def check_letter(letter)
end
	




