def cesears_cipher(input, step)
  text = input.split(//)

  text.collect! do |letter|
  	val = letter.ord
  	overflow = 0
  	if val.between?(65,90)
  	  val += step
  	  	overflow = val - 90 if val > 90
  	    val = 65 + overflow
  	  letter = val.chr
  	elsif val.between?(97,122)
  	  val += step
  	    overflow = val - 122 if val > 122
  	    val = 97 + overflow
  	  letter = val.chr
  	else letter = letter
  	end
  end.join("")

end

cesears_cipher("In cryptography, a Caesar cipher, also known as Caesar's cipher, the shift cipher, Caesar's code or Caesar shift, is one of the simplest and most widely known encryption techniques.", 3)

