def bubble_sort(arr)
	
num_of_runs = arr.length - 2
	while num_of_runs > 0
		(0..num_of_runs).each do |i|
			if arr[i] > arr[i+1]
				arr[i], arr[i+1] = arr[i+1], arr[i]
			end
		end
		num_of_runs -= 1
	end
arr
end

p bubble_sort([4,3,78,2,0,2])


