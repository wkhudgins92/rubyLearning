# William Hudgins
# 06/24/15
# CalculationEngine.rb
#
# Calculation engine for SimpleCalc

class CalculationEngine
  def initialize; end

  def calc(mode, operands)
    case mode
      when "add"
        result = add(operands)
      when "minus"
        result = minus(operands)
      when "multiply"
        result = multiply(operands)
      when "divide"
        result = divide(operands)
      else
        result = nil
    end
    return result
  end

  private def add(operands)
    return operands.reduce(:+)
  end

  private def minus(operands)
    return operands.reduce(:-)
  end

  private def multiply(operands)
    return operands.reduce(1, :*)
  end

  private def divide(operands)
    # Take this approach instead of reduce(1, :/) because all fractions, except 1/2, that
    # result in a value of .5 would fail

    # Remove first value of array
    operands = operands.reverse()
    quotient = operands.pop()
    operands = operands.reverse()

    operands.each{ |a| quotient/=a }
    return quotient
  end
end
