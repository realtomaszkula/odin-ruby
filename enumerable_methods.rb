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

	def my_map
	results = []
		i = 0
		until i == self.size
			results << yield(self[i])
		i += 1
		end
	results
	end

	def my_map!
		i = 0
		until i == self.size
			self[i] = yield(self[i])
		i += 1
		end
	self
	end

	def my_inject ( p = (no_arg_passed = true, nil) )																	
		 sum = 0
		 if block_given? && no_arg_passed
			i = 1
			sum = self[i-1]
			until i == self.size
			 	sum = yield(sum, self[i])
			 	i += 1
			end
			return sum
		elsif block_given?
			i = 0
			sum = p
			until i == self.size
			 	sum = yield(sum, self[i])
			 	i += 1
			end
			return sum
		end
	end

	def my_inject_symbol(sym, para = (no_arg_passed = true, nil))
		if no_arg_passed
			i = 1
			sum = self[i-1]
			until i == self.size
				sum = sum.send sym, self[i]
				i += 1
			end
		else
			i = 0
			sum = para
			until i == self.size
				sum = sum.send sym, self[i]
				i += 1
			end
			
		end
		return sum
	end

	def my_map_proc(proc)
	results = []
		i = 0
		until i == self.size
			results << proc.call(self[i])
		i += 1
		end
	results
	end


# load "./enumerable_methods.rb"
end

