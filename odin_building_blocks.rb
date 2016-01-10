def cesears_cipher(input, step)
  text = input.split(//)
  text.collect! do |letter|
  	val = letter.ord
  	if val.between?(65,90) || val.between?(97,122)
  	  val += step
  	  letter = val.chr
  	else letter = letter
  	end
  end.join("")
end

cesears_cipher("In cryptography, a Caesar cipher, also known as Caesar's cipher, the shift cipher, Caesar's code or Caesar shift, is one of the simplest and most widely known encryption techniques.", 3)

"In cryptography, a Caesar cipher, also known as Caesar's cipher, the shift cipher, Caesar's code or Caesar shift, is one of the simplest and most widely known encryption techniques."