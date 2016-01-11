module Enumerable
	def my_each
		i = 0
		until (i == self.size)
			yield(self[i])
		i += 1
		end
		return self
	end
end

