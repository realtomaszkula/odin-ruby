def substrings(text, dictionary)
results = Hash.new(0)
words = text.downcase.split(" ")

	words.each do |word|
 	  dictionary.each do |dic_word|
 	  	results[dic_word] += 1 if word.include? dic_word 
 	  end
	end

results
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("Howdy partner, sit down! How's it going?", dictionary)