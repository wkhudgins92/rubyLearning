# William Hudgins
# 06/26/15
# LinearSystem.rb
#
# A program to solve linear systems of equations using either
# Gaussian elimination or Jacobi iteration

# An extension of Array used for linear systems of equations
# Originally wanted to do this as an extension of the Matrix class
# but the immutability of the Matrix class made Array a better choice
class LinearSystem < Array
  
  # Public method for solving the system analytically using Gaussian elimination
  def gaussian
    reduced_matrix = forward_elimination(self)
    return back_substitution(reduced_matrix) 
  end

  # Public method for approximating the system iteratively via Jacobi Iteration
  def jacobi
    # These variables are helpful throughout method
    last_row_index = self.length - 1  
    last_col_index = last_row_index + 1 # One more column than row
    
    tolerance = 0.00000000000001 # Tolerance within which two values are considered ==
    estimate = Array.new(last_col_index, 0) # Initialize estimate vec to 0
    old_estimate = Array.new(last_col_index, 1) # Initialize old_est to 1
    equations = generate_jacobi_equations(self)

    # Until the estiamte converge
    until (estimate.reduce(:+) - old_estimate.reduce(:+)).abs <= tolerance
      old_estimate = estimate.clone # Copy old estimate by value, not reference
      equations.each_index do |i| # For each row
        sum = 0
        # Plug the previous estimate's values into the equations generated earlier
        equations[i].each_index do |j| # For each column
          if j != last_col_index # If it is not the right hand side of the matrix (b)
            sum += equations[i][j] * estimate[j] 
          else
            sum += equations[i][j]
          end
        end
        estimate[i] = sum # Update the estimate vector for this row
      end
    end
    return estimate
  end

  # Private helper method for Jacobi
  # Generates the equations used in Jacobi iteration
  private def generate_jacobi_equations(matrix)
    # These variables are helpful throughout method
    last_row_index = matrix.length - 1  
    last_col_index = last_row_index + 1 # One more column than row

    equation = Array.new
    for i in 0..last_row_index
      sum = 0
      diagonal = matrix[i][i]
      equation[i] = Array.new
      for j in 0..last_col_index
        if j == last_col_index
          equation[i][j] = matrix[i][j] / diagonal.to_f #.to_f avoid int div 
        elsif j != i 
          equation[i][j] = -1.0 * matrix[i][j] / diagonal + 0 # +0 to avoid -0s
        elsif j == i # Could use an else here, but elsif is more readable
          equation[i][j] = 0
        end 
      end
    end

    return equation
  end

  # Private helper method for Gaussian elimination, performs forward elimination
  # Partial pivoting is used in this step
  # Returns a reduced version of the matrix
  private def forward_elimination(matrix)
    # These variables are helpful throughout method
    last_row_index = matrix.length - 1  
    last_col_index = last_row_index + 1 # One more column than row

    # Select pivot row and swap it with the first row
    pivot_index = find_pivot(matrix)
    temp_row = matrix[pivot_index]
    matrix[pivot_index] = matrix[0]
    matrix[0] = temp_row
    
    # An array of the rows to be subtacted from each non-pivot rows
    # The work in this loop could be moved into the next loop, but that
    # might be less readable
    multiplied_pivot_rows = Array.new 
    for i in 1..(last_row_index)
        # multiplier is the number needed to make [i][0] equal to 0
        multiplier = matrix[i][0] / matrix[0][0].to_f # .to_f to avoid int div
        multiplied_pivot_rows[i] = matrix[0].map { |e| e *= multiplier}
    end

    # Subtract a multiple of the pivot row from each other row
    for i in 1..(last_row_index) 
      matrix[i].each_index do |j| 
        matrix[i][j] -= multiplied_pivot_rows[i][j]
      end
    end

    # If more rows need to be eliminated, recursively call forward_elimination
    # on submatrices omitting top row and first column
    if matrix.length > 2
      sub_matrix = matrix[1..last_col_index].map { |row| row = row.drop(1) }
      sub_matrix = forward_elimination sub_matrix
    else
      return matrix # Base case
    end

    # Places the submatrix and parent matrix back together
    for i in 1..(last_row_index)
      for j in 1..(last_col_index) 
        # Submatrix -1 because it is smaller
        matrix[i][j] = sub_matrix[i - 1][j - 1] 
      end
    end

    return matrix
  end

  # Private helper method for Gaussian elimination, performs back substitution
  # Returns the solution vector for the system of linear equations
  private def back_substitution(matrix)
    matrix = matrix.reverse # Start at bottom, work our way up
    solution = Array.new
    last_row_index = matrix.length - 1  
    last_col_index = last_row_index + 1 # One more column than row

    # Perform the back substitution algorithm for reach row
    # Could place the body of this loop into its own method but
    # I don't think that helps readability enough to justify method overhead
    for i in 0..last_row_index
      row_sum = 0
      # last_col_index - 1 because the last column represents solutions
      for j in (0..(last_col_index - 1)).to_a.reverse 
        if (solution[j].nil?)
          solution[j] = (matrix[i][last_col_index] - row_sum) / matrix[i][j]
          break
        else
          row_sum += matrix[i][j] * solution[j]
        end
      end
    end

   return solution
  end

  # Private helper method to find the pivot for an iteration of elimination
  private def find_pivot(matrix)
    column_to_eliminate = matrix.transpose[0]
    return column_to_eliminate.find_index(column_to_eliminate.max)	
  end
end
elote = LinearSystem[[3, -13, 9, 3, -19],
             [-6, 4, 1, -18, -34],
             [6, -2, 2, 4, 16],
             [12, -8, 6, 10, 26]]

torito = LinearSystem[[2, -1, 0, 1],
                      [-1, 3, -1, 8],
                      [0, -1, 2, -5]]

puts "Testing Gaussian elimination:"
puts "Original compound matrix ([A|b]):"
puts elote.inspect
puts "Solution for that matrix:"
puts elote.gaussian.inspect

puts ""
puts "Testing Jacobi iteration:"
puts "Original compound matrix ([A|b]):"
puts torito.inspect
puts "Estimate solution vector for that matrix:"
puts torito.jacobi.inspect
