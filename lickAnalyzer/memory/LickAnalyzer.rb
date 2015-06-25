# William Hudgins
# 06/25/15
# LickAnalyzer.rb
#
# A version of the LickAnalyzer not optimized for memory

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

# Check input
if (ARGV[0] == nil)
  raise ArgumentError.new("Usage: ruby LickAnalyzer.rb filename")
end

# Read in data, remove newlines, and convert to floats
dataset = Array.new

begin
  File.foreach(ARGV[0]) { |x| dataset.push(x)}
  rescue => error  
    fail Errno::ENOENT, 'Could not open specified file for reading' 
end

dataset.map { |a| a.delete!("\n") }
dataset = dataset.map { |a| a.to_f }

# Calculate and output data
dataset.extend(LickTrial)
printf("mean,median,mode,sum,top10\n")
printf("%.2f,%.2f,%.2f,%.2f,%s\n", dataset.mean, dataset.median,
  dataset.mode, dataset.sum, dataset.top_ten) 
