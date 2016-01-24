def cipher(input, step)
  text = input.split(//)

  text.collect! do |letter|
  	val = letter.ord
  	overflow = 0
  	if val.between?(65,90)
  	  val += step
      if val > 90
  	  	overflow = val - 90
  	    val = 64 + overflow
      end
  	  letter = val.chr
  	elsif val.between?(97,122)
  	  val += step
      if val > 122
  	    overflow = val - 122
  	    val = 96 + overflow
      end
  	  letter = val.chr
  	else letter = letter
  	end
  end.join("")

end


