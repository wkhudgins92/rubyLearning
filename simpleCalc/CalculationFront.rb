# William Hudgins
# 06/24/15
# CalculationFront.rb
#
# Handles input and output for SimpleCalc
# Requires CalculationEngine.rb

require_relative 'CalculationEngine'

class CalculationFront
  def initialize
    @calcEngine = CalculationEngine.new()
    printf("\t\t\t  Welcome to SimpleCalc:\n\t\t\t  the simple 4 function calculator!\n")
    printf("\t\t\t*************************************\n")
    printf("\t\t\t*         SimpleCalc Menu           *\n")
    printf("\t\t\t* 'add'      Add n numbers          *\n")
	printf("\t\t\t* 'minus'    Substract n numbers    *\n")
    printf("\t\t\t* 'multiply' Multiply n numbers     *\n")
    printf("\t\t\t* 'divide'   Divide n numbers       *\n")
    printf("\t\t\t* 'quit'     Quit SimpleCalc        *\n")
    printf("\t\t\t*************************************\n")
    printf("\n");
    calculation_loop()
  end

  def calculation_loop()
    loop do
      printf("Please enter one of the options: ")
      mode = $stdin.readline
      mode.delete!("\n")
      printf("\n")

      case mode
        when "add", "minus", "multiply", "divide"
          printf("Please enter desired operands seperated by a space: ")
          input = $stdin.readline()
          input.delete!("\n")
          printf("\n")
          
          if (input =~ /(\d*\s)*/)
            operands = input.split(" ")
            operands = operands.map(&:to_f)
            execute_calculation(mode, operands)
          else
            printf("Invalid operand format. Please try again.\n")
          end
        when "quit"
          printf("Thank you, goodbye!\n")
	    else
          printf("Invalid option.\n")
      end
    break if mode == "quit"
    end
  end

  def execute_calculation(mode, operands)
    engine = CalculationEngine.new()
    result = engine.calc(mode, operands)
    last_operand = operands.pop()

    # Output results here
    case mode
      when "add"
        operands.each{|a| print a, " + "}
      when "minus"
        operands.each{|a| print a, " - "}
      when "multiply"
        operands.each{|a| print a, " * "}
      when "divide"
        operands.each{|a| print a, " / "}
    end
    
    printf("%s = %s\n\n", last_operand, result);
  end
end 
