		name = Time.now.to_i.to_s << ".txt"
		
		File.open("./saves/#{name}", "w") do |f|
			f.puts "test"
		end