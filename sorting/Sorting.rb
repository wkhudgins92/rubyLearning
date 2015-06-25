# William Hudgins
# 06/25/15
# Sorting.rb
#
# Contains Ruby implementations of selection and merge sorts

module ClassicSort
  def selection_sort
    self.size.times do |i| # For each item in the array
      current_min = i # Current minimun value in unsorted segment of array
      i.upto(self.size - 1) do |j| # For all the remaning, unsorted, elements in array
        current_min = j if self[j] < self[current_min] # If some value is less than current min, save index
      end
      self[i], self[current_min] = self[current_min], self[i] # Swap values
      end
   self
  end
  
  # Feel like taking a list and returning a list is kind of dumb
  def mergesort(list)
    return list if list.size <= 1
    mid_point = list.size / 2
    left = list[0, mid_point]
    right = list[mid_point, list.size - 1]
    merge(mergesort(left), mergesort(right)) # Recursively breaks up left and right
                                               # then sends to merge for merging
  end

  def merge(left, right)
    sorted = Array.new()
    until left.empty? or right.empty?
      if left.first <= right.first
        sorted << left.shift
      else
        sorted << right.shift
      end
    end
    sorted.concat(left).concat(right)
  end
end

list = [3, 4, 2, 9, 8]
list2 = [34, 5, 2.3, 4, 7, 9]
list3 = [44, 2, 6.7, 6, 2, -12]
list4 = [34, 5, 2, 4, 7, 9]

list.extend(ClassicSort)
list2.extend(ClassicSort)
list3.extend(ClassicSort)
list4.extend(ClassicSort)



printf("Selection sort\n")
printf("Pre-sorting (integer):\n%s\n", list)
list.selection_sort
printf("Post-sorting:\n%s\n", list)
printf("Pre-sorting (floating):\n%s\n", list2)
list2.selection_sort
printf("Post-sorting:\n%s\n", list2)

printf("\nMerge sort\n")
printf("Pre-sorting (integer):\n%s\n", list4)
list4 = list4.mergesort(list4)
printf("Post-sorting:\n%s\n", list4)
printf("Pre-sorting (floating):\n%s\n", list3)
list3 = list3.mergesort(list3)
printf("Post-sorting:\n%s\n", list3)
