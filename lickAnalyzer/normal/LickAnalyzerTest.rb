# William Hudgins
# 06/25/15
# LickAnalyzer.rb
#
# A version of the LickAnalyzer not optimized for memory
# Test code for the mathematical functions

# This module contains the mathematical operations necessary to Analyze trial data
module LickTrial
  def sum
    return self.reduce(:+)
  end
  
  def mean
    return sum/self.size
  end

  # In case of multi-modal distribution, returns largest modal value
  def mode 
    frequency_count = reduce(Hash.new(0)) { |freq, value| freq[value] += 1; freq}
    mode_count = frequency_count.values.max
    mode = frequency_count.select { |key, value| value == mode_count } # Select mode pairs
    return mode.keys.max # In case of multi-modes, return largest
  end

  def median
    sorted_data = self.sort
    mid_point = self.length / 2    

    # If the length of the data set 
    if self.length % 2 == 0
      median = (sorted_data[mid_point] + sorted_data[mid_point - 1]) / 2.0
    else # Length is odd
      median = sorted_data[mid_point]
    end

    return median
  end
 
  # Returns the 10 largest values in the array 
  def top_ten
    reverse_sort = self.sort.reverse
    return reverse_sort[0, 10]
  end
end

bandaLaTrakalosaDeMonterrey = [1, 1, 1, 1, 1, 2, 2, 2, 70, 80, 90, 3, 4, 5, 4, 12, 15] # Solo exitos
bandaLaTrakalosaDeMonterrey.extend(LickTrial)

puerco = [3, 4, 5, 4] # This distribution is normal and even-sized
puerco.extend(LickTrial)

tigre = [3, 4, 5, 4, 5] # This distribution is bimodal and odd-sized
tigre.extend(LickTrial)

elPerdedor = [2, 4, 9, 8, 5] # This distribution is odd-sized
elPerdedor.extend(LickTrial)

puts "This tests the LickTrial module"
puts ""

puts "Testing mean"
puts "Input array:"
printf("%s\n", puerco)
printf("Mean should be 4, LickTrial.mean returned %s\n\n", puerco.mean)

puts "Testing mode"
puts "Input array:"
printf("%s\n", tigre)
printf("Mode should be 5, LickTrial.mode returned %s\n\n", tigre.mode)

puts "Testing median"
puts "Even number of elements"
puts "Input array:"
printf("%s\n", puerco)
printf("Median should be 4, LickTrial.median returned %s\n", puerco.median)

puts "Odd number of elements"
puts "Input array:"
printf("%s\n", elPerdedor)
printf("Median should be 5, LickTrial.median returned %s\n\n", elPerdedor.median)

puts "Testing sum"
puts "Input array:"
printf("%s\n", puerco)
printf("Sum should be 16, LickTrial.sum returned %s\n\n", puerco.sum)

puts "Testing top-ten"
puts "Input array:"
printf("%s\n", bandaLaTrakalosaDeMonterrey)
printf("Top-ten should be [90, 80, 70, 15, 12, 5, 4, 4, 3, 2], LickTrial.top_ten returned \n%s\n\n",
  bandaLaTrakalosaDeMonterrey.top_ten)
