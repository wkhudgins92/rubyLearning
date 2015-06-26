# William Hudgins
# 06/25/15
# Stack.rb
#
# A stack implemented using an array in Ruby
# This is kind of pointless because by default, Ruby arrays contain most stack methods

class Stack
  def initialize
    @stack = Array.new
  end

  def pop
    return @stack.pop()
  end

  def push(newElement)
    @stack = @stack.push(newElement)
  end

  def peek
    return @stack.last
  end

  def size
    return @stack.size
  end

  def isEmpty
    return @stack.empty?
  end

  def toString
    return "[" + @stack.reverse.join(',') + "]"
  end
end

printf("Test Stack class\n\n")
stack = Stack.new

printf("Created new stack, should be empty\n")
printf("Current stack: %s\n", stack.toString)
printf("Adding 3, 4, 2 to stack\n")
stack.push(3)
stack.push(4)
stack.push(2)
printf("Current stack: %s\n", stack.toString)
printf("Stack has 3 elements\n")
printf("Stack.size returned %s\n", stack.size)
printf("Stack is not empty\n")
printf("Stack.isEmpty returned %s\n", stack.isEmpty)
printf("Stack.peek should return 2\n")
printf("Stack.peek returned %s\n", stack.peek)
printf("Stack.pop should remove and return 2\n")
printf("Stack.pop returned %s\n", stack.pop)
printf("Current stack: %s\n", stack.toString)
printf("Stack.pop should remove and return 4\n")
printf("Stack.pop returned %s\n", stack.pop)
printf("Current stack: %s\n", stack.toString)
printf("Stack.pop should remove and return 3\n")
printf("Stack.pop returned %s\n", stack.pop)
printf("Current stack: %s\n", stack.toString)
printf("Stack has 0 elements\n")
printf("Stack.size returned %s\n", stack.size)
printf("Stack is empty\n")
printf("Stack.isEmpty returned %s\n", stack.isEmpty)
