Iterations, in programming, allow coders to repeat a set of instructions until a condition is met. Think about this as being stuck in a loop that will continue until something tells you to break out.

## While loop

The while loop is one of two iteration types you'll learn about. In this loop you must specify a condition first and then include the code that you want the loop to iterate over. The loop will first check if the condition is True and if it is then it will look at the code inside the loop. When the condition becomes False, the code in the loop will be skipped over and the program will continue executing the rest of your code. If the condition in the loop is False to begin with, the code within the loop will never execute. During a single loop, the program will then go through the loop and run the code. Once the code is finished, it will look back at the condition and see if it is still True. It's essential to change the variables in your loop to eventually have a condition say that it is False, or else an infinite loop will occur.

As shown in the code below, to write a while loop you first must type "while" and then the condition you'll check before every loop. End the line with a colon and be sure to indent the next line, which will be the actual loop. The code below will print out a countdown for a rocket. As you can see, the countdown variable in the condition section decreases in every loop until it reaches -1, in which case the condition is False and the loop ends.

```python
countdown = 5

while countdown >= 0:
    print(countdown)
    countdown = countdown - 1  
print("Lift Off")
```

```Output
5  
4  
3  
2  
1  
0
Lift off
```

In the example below, the condition is never met and the loop will continue forever (if we don't stop it). In this code, the developer forgot to decrease the timer variable, so the condition is always true.

```python
# Trying to find life outside our planet
timer = 10
while  timer > 0:
    print("Hello, I am from Earth")
```

```Output
Output was trimmed for performance reasons.
To see the full output set the setting "python.dataScience.textOutputLimit" to 0.
...  
Hello, I am from Earth  
Hello, I am from Earth  
Hello, I am from Earth  
Hello, I am from Earth  
...
```

This is an infinite loop and you must either wait for Python to terminate it or click the stop button at the top of the window. It's best to avoid infinite loops - if that wasn't already apparent.

## For loop

For loops essentially perform the same task as while loops, they tend to focus on iterating a set number of times. For loops are great when you want to go through a list and look at every single element. In the code below, we make a list and then go through all the elements and print them out.

```python
planets = "Mars","Saturn", "Jupiter"

for planet in planets:
    print(planet)
```

```Output
Mars  
Saturn  
Jupiter  
```