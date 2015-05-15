# File Name: 150507_Calculator_Exercise.rb
# Developer: catchingash

# Establish synonyms for math functions. NOTE: All text in the arrays needs to be lowercase.
subtract = ["substraction", "sub", "subtract", "-"]
add = ["addition", "add", "+"]
multiply = ["multiplication", "multiply", "x", "*"]
divide = ["division", "div", "/"]
exponent = ["exponential", "exponents", "exponent", "exp", "power", "^", "**"]
sqrt = ["squareroot", "square root", "sqrt", "^1/2", "\u221A"]
mod = ["remainders", "remainder", "modulo", "modulus", "%"]
operations = subtract + add + multiply + divide + exponent + sqrt + mod
UNACCEPTED_OPERATION_MEMO = "I'm sorry. I'm confused. I know it's probably obvious to a human, but could you try again and dumb it down for me? (You'll need to restart me. Sorry!)"
UNEXPECTED_ERROR_MEMO = "I'm not sure what happened. I unencountered an unexpected error and had to close. I'm sorry!"

# Get user input: operation selection
username = `id -u -n`.chomp
puts "Hello, #{username}. Can I call you that? I hope it's okay. Anyway, let's do some math!\nWhat kind of math would you like to do? [If you need a hint, type 'HELP'.]"
operator = gets.chomp.downcase.strip

while operator == "help"
  puts "Thanks for asking. I do lots of math! Your options are:\naddition, subtraction, multiplication, division, exponents, square root, remainder."
  operator = gets.chomp.downcase.strip
end

abort(UNACCEPTED_OPERATION_MEMO) unless operations.include?(operator)

# Get user input: number selection
puts "Exciting! Pick the first number."
num1 = gets.chomp.delete(",")

if num1.to_f == 0 && num1 != "0"
  puts "You're funny. That's not a number! I'll just pretend you picked 0." #Words as numbers are not understood. # A number followed by a string will be accepted, and will cut the rest of the string off. I have not built in anything to catch that if the user does that. However, a number in the middle of a string will not be accepted, and will use 0 instead. #TODO: add loop to re-prompt?
end
num1 = num1.to_f

# Get user input: 2nd number (if needed)
unless sqrt.include?(operator)
  puts "I can work with that. What's the second number?"
  num2 = gets.chomp.delete(",")
  if num2 == "0"
  elsif num2.to_f == 0
    puts "You're funny. That's not a number! I'll just pretend you picked 0."
  end
  num2 = num2.to_f
end

# Math time!
if subtract.include?(operator)
  num_calculated = num1 - num2
  operator = "-"
elsif add.include?(operator)
  num_calculated = num1 + num2
  operator = "+"
elsif multiply.include?(operator)
  num_calculated = num1 * num2
  operator = "*"
elsif divide.include?(operator)
  num_calculated = num1 / num2
  operator = "/"
elsif exponent.include?(operator) # TODO: Didn't realize we should have it print out the full thing. e.g. 2 ^ 2 = 2 * 2 * 2.
  num_calculated = num1 ** num2
  operator = "^"
elsif sqrt.include?(operator) ## sqrt will always be reported as a float.
  num_calculated = Math.sqrt(num1.abs)
  operator = "\u221A"
  abort("#{operator}#{num1} = #{num_calculated}\nI'm so awesome! Run me again to do more math!")
elsif mod.include?(operator)
  num_calculated = num1 % num2
  operator = "%"
end

# Remove *.0 from the numbers (if exists); Provide output to the user
num1 = num1.to_i if (num1 % 1) == 0
num2 = num2.to_i if (num2 % 1) == 0

if (num_calculated % 1) == 0
  puts "#{num1} #{operator} #{num2} = #{num_calculated.to_i}\nI'm so awesome! Run me again to do more math!" # TODO: re-prompt instead of ending?
elsif (num_calculated % 1) != 0
  puts "#{num1} #{operator} #{num2} = #{num_calculated}\nI'm so awesome! Run me again to do more math!" # TODO: Add functionality to round? User-selected rounding?
else
  abort(UNEXPECTED_ERROR_MEMO)
end

## PLATINUM
## Missing the ability to do multiple operations / handle parenthesis. Of course, there's always `p eval("<user)input>")`.... ;)
