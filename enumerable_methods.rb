module Enumerable
	def my_each
		i = 0
		until (i == self.size)
			yield(self[i])
		end
		self
	end


	def my_each_with_index

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


	def

end

