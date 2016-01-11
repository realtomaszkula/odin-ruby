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

		def my_none?
		i = 0
		until (i == self.size)
			return false if yield(self[i])
		i += 1
		end
		true
	end

	def my_count(p1 = (no_arg_passed = true; nil), &block)
	result = 0
	if no_arg_passed && block_given? == false then return self.size; end
	
	if block_given? 
		i = 0
		until (i == self.size)
			if yield(self[i]) then result += 1;	end
		i += 1
		end
	else
		i = 0
		until (i == self.size)
			if self[i] == p1 then result += 1; end
		i += 1
		end
	end
	result
	end
end

