# William Hudgins
# MutableMatrix.rb
# 06/29/15
#
# Extends Array to provide a basic mutable matrix

require 'matrix'

class MutableMatrix < Array
  # Matrix multiplication: AB = C
  def m_mult(other)
    # Ensure proper dimensions
    if (other.num_rows != self.num_cols)
      raise "Matrix dimensions must satisfy: (n x m)(m x p) = (n x p)"
    end

    product_matrix = MutableMatrix.new
    self.each_index do |row| # For each row in A
      product_matrix[row] = Array.new # Initialize new row in C
        other[row].each_index do |col| # For each col in B
        sum = 0
        self[row].each_index do |k| # For each element in A[1]
          sum += self[row][k] * other[k][col] 
        end
          product_matrix[row][col] = sum
      end
    end

    return product_matrix
  end
  
  # Matrix addition
  # Could overload +, but the concatenating property of + could be useful
  def m_add(other)
    # Ensure proper dimensions
    if (other.num_rows != self.num_rows || other.num_cols != self.num_cols)
      raise "Matrix dimensions must match"
    end

    sum_matrix = MutableMatrix.new
    
    self.each_index do |row| # For reach row
      sum_matrix[row] = Array.new(self.num_cols, 0)
      self[row].each_index do |col| # For each col
        sum_matrix[row][col] = self[row][col] + other[row][col]
      end
    end
    return sum_matrix
  end

  # Matrix subtraction
  def m_subt(other)
    # Multiply by -1 then add
    neg = MutableMatrix.new
    other.each_index do |row| 
      neg[row] = Array.new(other.num_cols, 0)
      other[row].each_index do |col| 
        neg[row][col] = other[row][col] * -1
     end
    end
    return m_add(neg)
  end

  # Convert to an immutable matrix, useful for builtin Matrix functions
  def to_immut_matrix()
    return Matrix.rows self
  end

  # Returns number of rows for a matrix
  def num_rows()
    return self.length
  end

  # Returns number of columns for a matrix
  def num_cols()
    return self[0].length
  end
end

# Testing num_rows and num_cols
puts "Attempting to create a MutableMatrix [[3, 4, 3], [3, 4, 5]]"
josh_abbott = MutableMatrix[[3, 4, 3], [3, 4, 5]]
don_omar = MutableMatrix[[2, 3, 7], [3, 4, 1]]
intocable = MutableMatrix[[34, 50, 75, 65.3], [2.6, 3.5, 2, 4], [3, 4, 5, 6]]
puts "Created matrix:"
puts josh_abbott.inspect
puts ""
puts "Testing num_rows and num_cols"
printf("num_rows should return 2, it returned : %d\n", josh_abbott.num_rows)
printf("num_cols should return 3, it returned : %d\n", josh_abbott.num_cols)
puts ""
puts "Testing to_immut_matrix"
borracho_de_amor = josh_abbott.to_immut_matrix
puts borracho_de_amor.inspect
puts ""
puts "Testing matrix addition:"
printf("%s + %s = %s\n", josh_abbott, don_omar, josh_abbott.m_add(don_omar))
puts ""
puts "Testing matrix subtraction:"
printf("%s - %s = %s\n", josh_abbott, don_omar, josh_abbott.m_subt(don_omar))
puts""
puts "Testing matrix multiplication:"
printf("%s * %s = %s\n", josh_abbott, intocable, josh_abbott.m_mult(intocable))
