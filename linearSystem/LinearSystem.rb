# William Hudgins
# 06/26/15
# LinearSystem.rb
#
# A program to solve linear systems of equations using either
# Gaussian elimination or Jacobi iteration

require 'matrix'

# An extension of Array used for linear systems of equations
# Originally wanted to do this as an extension of the Matrix class
# but the immutability of the Matrix class made Array a better choice
class LinearSystem < Array
  
  # Public method for solving the system analytically using Gaussian elimination
  def gaussian
    reduced_matrix = forward_elimination(self)
#puts reduced_matrix.inspect
    #return back_substitution(reduced_matrix) 
  end

  # Public method for approximating the system iteratively via Jacobi Iteration
  def jacobi
  end

  # Private helper method for Gaussian elimination, performs forward elimination
  # Partial pivoting is used in this step
  # Returns a reduced version of the matrix
  private def forward_elimination(matrix)
    return matrix if matrix.length == 1
puts "Start"
puts matrix.inspect

    pivot_index = find_pivot(matrix)
    temp_row = matrix[pivot_index]
    matrix[pivot_index] = matrix[0]
    matrix[0] = temp_row
    multiplied_pivot_rows = Array.new

    for i in 1..(matrix.length - 1)
        multiplier = matrix[i][0] / matrix[0][0].to_f
        multiplied_pivot_rows[i] = matrix[0].map { |e| e *= multiplier}
    end

    for i in 1..(matrix.length - 1) 
      matrix[i].each_index do |j| 
        matrix[i][j] -= multiplied_pivot_rows[i][j]
      end
    end
puts "rat"
puts matrix.inspect
    sub_matrix = matrix[1..matrix.length].map { |row| row = row.drop(1) }
    sub_matrix = forward_elimination sub_matrix
    puts sub_matrix.inspect
puts matrix.length - 1
    for i in 1..(matrix.length - 1)
      for j in 1..(matrix.length) # Not -1 because there is one more column than rows
        matrix[i][j] = sub_matrix[i][j]
      end
    end
#puts "End"
#puts matrix.inspect
    return matrix
  end

  # Private helper method for Gaussian elimination, performs back substitution
  # Returns the solution vector for the system of linear equations
  private def back_substituion
  end

  # Private helper method to find the pivot for an iteration of elimination
  private def find_pivot(matrix)
    column_to_eliminate = matrix.transpose[0]
    return column_to_eliminate.find_index(column_to_eliminate.max)	
  end
end

rat = LinearSystem[[6, -2, 2, 4, 16],
             [12, -8, 6, 10, 26],
             [3, -13, 9, 3, -19],
             [-6, 4, 1, -18, -34]]
rat.gaussian
