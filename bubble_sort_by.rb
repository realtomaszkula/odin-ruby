def bubble_sort_by(arr)

num_of_runs = arr.length - 2
  while num_of_runs > 0

  (0..num_of_runs).each do |i|
    result = yield(arr[i], arr[i+1])
      if result > 0
  		arr[i], arr[i+1] = arr[i+1], arr[i]
  	  end
  	end
  num_of_runs -= 1
  end

arr
end

p bubble_sort_by([4,3,78,2,0,2]) { |one, two| two - one }



