Functions in Go allows you to group together a set of statements that you can call from other parts of your application. Instead of having a program with many statements, you can use functions to organize the code and make it more readable. Thus the code becomes more maintainable.

At this point, we've been calling the `println()` function, and we've been writing code within the `main()` function. In this section, we'll explore in more detail how you can create custom functions along with other peculiarities that Go has to offer in regards to functions.

## Main function

The first function you've been interacting with is the `main()` function. All executable programs in Go have to have this function as it's the program's starting point. Therefore, you can only have one `main()` function in your program. If you're creating a Go package, you don't need to write a `main()` function–we'll see how to create packages in an upcoming module.

Before we jump into the basics of creating custom functions in Go, let's highlight one crucial aspect of the `main()` function. As you might have noticed, the `main()` function doesn't have any parameters and returns nothing. But that doesn't mean that it can't read values from the user, like command-line arguments. If you need to access command-line arguments, you can do it with the [os package in Go](https://golang.org/pkg/os/), and the `os.Args` variable, which holds all the arguments passed to the program.

Let's use the following code that read two numbers from the command-line, and then sum them up:

```go
package main

import (
    "os"
    "strconv"
)

func main() {
    number1, _ := strconv.Atoi(os.Args[1])
    number2, _ := strconv.Atoi(os.Args[2])
    println("Sum:", number1+number2)
}
```

The `os.Args` variable holds every command-line argument passed to the program, and because these values are of type `string`, you need to convert them to `int` to sum them up.

To run the program, use the following command:

```go
go run main.go 3 5
```

And the output is going to be:

```output
Sum: 5
```

Let's see how we can refactor the above code and create our first custom function.

## Custom functions

To create a function, the syntax is the following one:

```go
func name(parameters) (results) {
    body-content
}
```

Notice that you use the `func` keyword to define a function, then assign a name to it. After the name, you'll specify the list of parameters for the function, which could be zero or more. You can also define the return types of the function, which could be zero or more as well–we'll talk about this in the next section. And after you've defined all of that, you write the body content of the function.

To practice this a little bit, let's refactor the previous section's code to sum the numbers in a custom function. Let's use the following code:

```go
package main

import (
    "os"
    "strconv"
)

func main() {
    sum := sum(os.Args[1], os.Args[2])
    println("Sum:", sum)
}

func sum(number1 string, number2 string) int {
    int1, _ := strconv.Atoi(os.Args[1])
    int2, _ := strconv.Atoi(os.Args[2])
    return int1 + int2
}
```

The above code creates a function called `sum` that takes two `string` arguments, cast them to `int`, and then returns the result of sum them up. When you define a return type, it's required that your function returns a value of that type.

In Go, you can also set a name to the return value of a function, as if it was a variable. For instance, you could refactor the `sum` function like this:

```go
func sum(number1 string, number2 string) (result int) {
    int1, _ := strconv.Atoi(os.Args[1])
    int2, _ := strconv.Atoi(os.Args[2])
    result = int1 + int2
    return
}
```

Notice that now you need to enclose in parenthesis the result value of the function. Moreover, you can use the variable inside the function, and you can simply add a `return` line at the end. Go will return the current values of those return variables. Although the simplicity of writing the `return` keyword at the end of the function is appealing (especially when you have more than one return value), we wouldn't recommend this approach as it's not very cleared what the function is returning.

## Returning multiple values

In Go, functions can return more than one value, and you can similarly define them as you define its parameters. In other words, you need to specify a type and a name, but the name it's optional.

For instance, let's say that you want to create a function that sums two numbers but also multiply them. The function code would look like this:

```go
func calc(number1 string, number2 string) (sum int, mul int) {
    int1, _ := strconv.Atoi(os.Args[1])
    int2, _ := strconv.Atoi(os.Args[2])
    sum = int1 + int2
    mul = int1 * int2
    return
}
```

Now, in the `main()` function, you need two variables to store the results of the function (it won't compile otherwise), like this:

```go
func main() {
    sum, mul := calc(os.Args[1], os.Args[2])
    println("Sum:", sum)
    println("Mul:", mul)
}
```

Another interesting feature in Go is that if you don't need one of the return values from a function, you can discard it by assigning the returning value to the `_` variable. **The `_` variable is the idiomatic way of Go to ignore return values and allows the program to compile**. So, if you only want the sum value, you could use the following code:

```go
func main() {
    sum, _ := calc(os.Args[1], os.Args[2])
    println("Sum:", sum)
}
```

We'll continue looking at the pattern of ignoring return values from functions when we talk about error handling in an upcoming module.

## Changing function parameter values (pointers)

When you pass a value to a function, every change in that function won't affect the caller. Go is a "pass by value" programming language, meaning that whenever you pass a value to a function, Go takes that value and creates a local copy (a new variable in memory). Every change you do to that variable in the function doesn't affect the one you sent to the function.

For instance, let's say that you create a function to update a person's name. Use the following code, and notice what happens when you run it:

```go
package main

func main() {
    firstName := "John"
    updateName(firstName)
    println(firstName)
}

func updateName(name string) {
    name = "David"
}
```

Even though you changed the name to "David" in the function, the output is still "John" because the change in the `updateName` function only modifies the local copy. Go simply passed the value of the variable, not the variable itself.

If you want the change you do in the `updateName` function to affect the `firstName` variable in the `main` function, you have to use pointers. A **pointer** is a variable that contains the memory address of another variable. When you send a pointer to a function, you're not passing the value but an address memory. Therefore, every change you make to that variable affects the caller.

In Go, there are two operators for dealing with pointers:

- The `&` operator takes the address of the object that follows it
- The `*` operator dereferences a pointer; that is, it gives you access to the object at the address contained in the pointer

Let's modify our previous example to understand how pointers work:

```go
package main

func main() {
    firstName := "John"
    updateName(&firstName)
    println(firstName)
}

func updateName(name *string) {
    *name = "David"
}
```

Run the above code, and notice that the output now shows `David` instead of `John`.

The first thing you have to do is modify the function's signature to indicate that you'd like to receive a pointer. To do so, change the parameter type from `string` to `*string` (pointer to string). Then, when you assign a new value to that variable, you need to add the star on the left-hand side of the variable to yield that variable's value. When you call the `updateName` function, you don't send the value but the memory address of the variable; that's why the above code has the `&` symbol on the left-hand side of the variable.