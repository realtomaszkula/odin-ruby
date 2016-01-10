def cesears_cipher(input, step)
  text = input.split(//)
  text.collect! do |letter|
  	val = letter.ord
  	if val.between?(65,90) || val.between?(97,122)
  	  val += step
  	  	case val
  	  	  when 91 then val = 65
  	  	  when 92 then val = 66
  	  	  when 93 then val = 67
  	  	  when 123 then val = 97
  	  	  when 124 then val = 98
  	  	  when 125 then val = 99
  	  	end
  	  letter = val.chr
  	else letter = letter
  	end
  end.join("")
end

cesears_cipher("In cryptography, a Caesar cipher, also known as Caesar's cipher, the shift cipher, Caesar's code or Caesar shift, is one of the simplest and most widely known encryption techniques.", 3)

