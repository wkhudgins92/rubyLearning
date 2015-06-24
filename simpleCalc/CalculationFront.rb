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
    printf("\t\t\t\tWelcome to SimpleCalc:\n\t\t\t\tthe simple 4 function calculator!\n")
    printf("\t\t*************************************\n")
    printf("\t\t*         SimpleCalc Menu           *\n")
    printf("\t\t* 'add'      Add n numbers          *\n")
	printf("\t\t* 'minus'    Substract n numbers    *\n")
    printf("\t\t* 'multiply' Multiply n numbers     *\n")
    printf("\t\t* 'divide'   Divide n numbers       *\n")
    printf("\t\t* 'quit'     Quit SimpleCalc        *\n")
    printf("\t\t*************************************\n")
	printf("\n");
	calculationLoop()
  end

  def calculation_loop
    loop do
      printf("Please enter one of the options: ")
	  mode = $stdin.readline
      printf("\n")
	  case mode
	    when "add", "minus", "multiply", "divide"
		  printf("Please enter desired operands seperated by a space: ")
          input = $stdin.readline()
          printf("\n")
          
          if (input === /\d*\s/)
            operands = input.split(mode, " ")
            execute_calculation(operands)
          else
            printf("Invalid operand format. Please try again.\n")
          end
	    when "quit"
          printf("Thank you, goodbye!\n")
	    else
		  printf("Please enter valid input from the menu above: ")
	      mode = $stdin.readline
          printf("\n")
	  end
    break if chosen_mode == "quit"
    end
  end

  def execute_calculation(mode, operands)
	result = CalculationEngine.calc(mode, operands)
    # Output results here
  end
    
end 
