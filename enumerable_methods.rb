module Enumerable
	def my_each
		i = 0
		until (i == self.size)
			yield(self[i])
			i += 1
		end
		self
	end


	def my_each_with_index
		i = 0
		until (i == self.size)
			yield(self[i], i)
			i += 1
		end
		self
	end


	def my_select
		results = []
		i = 0
		until (i == self.size)
			results << self[i] if yield(self[i])
		i += 1
		end
		results
	end

	def my_all?
		i = 0
		until (i == self.size)
			return false unless yield(self[i])
		i += 1
		end
		true
	end

end

