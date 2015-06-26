# William Hudgins
# 06/26/15
# LinearSystem.rb
#
# A program to solve linear systems of equations using either
# Gaussian elimination or Jacobi iteration

# An extension of Matrix used for linear systems of equations
class LinearSystem < Array
  
  # Public method for solving the system analytically using Gaussian elimination
  def gaussian
    reduced_matrix = 
  end

  # Public method for approximating the system iteratively via Jacobi Iteration
  def jacobi
  end

  # Private helper method for Gaussian elimination, performs forward elimination
  # Returns a reduced version of the matrix
  private def forward_elimination
  end

  # Private helper method for Gaussian elimination, performs back substitution
  # Returns the solution vector for the system of linear equations
  private def back_substituion
  end
end
