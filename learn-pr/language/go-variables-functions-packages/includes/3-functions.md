In Go, functions allow you to group together a set of statements that you can call from other parts of your application. Instead of creating a program with many statements, you can use functions to organize the code and make it more readable. More readable code is also more maintainable.

Up to this point, we've been calling the `fmt.Println()` function, and we've been writing code in the `main()` function. In this section, we'll explore how you can create custom functions. We'll also look at some other techniques you can use with functions in Go.

## Main function

The function you've been interacting with is the `main()` function. All executable programs in Go have this function because it's the program's starting point. You can only have one `main()` function in your program. If you're creating a Go package, you don't need to write a `main()` function. We'll look at how to create packages in an upcoming module.

Before we jump into the basics of creating custom functions in Go, let's look at one crucial aspect of the `main()` function. As you might have noticed, the `main()` function doesn't have any parameters and returns nothing. But that doesn't mean it can't read values from the user, like command-line arguments. If you need to access command-line arguments in Go, you can do it with the [os package](https://golang.org/pkg/os/?azure-portal=true) and the `os.Args` variable, which holds all the arguments passed to the program.

The following code reads two numbers from the command line and sums them up:

```go
package main

import (
    "fmt"
    "os"
    "strconv"
)

func main() {
    number1, _ := strconv.Atoi(os.Args[1])
    number2, _ := strconv.Atoi(os.Args[2])
    fmt.Println("Sum:", number1+number2)
}
```

The `os.Args` variable holds every command-line argument passed to the program. Because these values are of type `string`, you need to convert them to `int` to sum them up.

To run the program, use this command:

```go
go run main.go 3 5
```

Here's the output:

```output
Sum: 8
```

Let's see how we can refactor the above code and create our first custom function.

## Custom functions

Here's the syntax for creating a function:

```go
func name(parameters) (results) {
    body-content
}
```

Notice that you use the `func` keyword to define a function and then assign a name to it. After the name, you specify the list of parameters for the function. There can be zero or more parameters. You can also define the return types of the function, of which there can also be zero or more. (We'll talk about returning multiple values in the next section.) And after you define all of those values, you write the body content of the function.

To practice this technique, let's refactor the previous section's code to sum the numbers in a custom function. We'll use this code:

```go
package main

import (
    "fmt"
    "os"
    "strconv"
)

func main() {
    sum := sum(os.Args[1], os.Args[2])
    fmt.Println("Sum:", sum)
}

func sum(number1 string, number2 string) int {
    int1, _ := strconv.Atoi(number1)
    int2, _ := strconv.Atoi(number2)
    return int1 + int2
}
```

This code creates a function called `sum` that takes two `string` arguments, casts them to `int`, and then returns the result of summing them up. When you define a return type, your function needs to return a value of that type.

In Go, you can also set a name to the return value of a function, as though it were a variable. For example, you could refactor the `sum` function like this:

```go
func sum(number1 string, number2 string) (result int) {
    int1, _ := strconv.Atoi(number1)
    int2, _ := strconv.Atoi(number2)
    result = int1 + int2
    return
}
```

Notice that now you need to enclose the result value of the function in parenthesis. You can also use the variable inside the function, and just add a `return` line at the end. Go will return the current values of those return variables. The simplicity of writing the `return` keyword at the end of the function is appealing (especially when there's more than one return value). We don't recommend this approach. It can be unclear what the function is returning.

## Return multiple values

In Go, a function can return more than one value. You can define these values in a way that's similar to how you define the function's parameters. In other words, you specify a type and a name, but the name is optional.

For example, say you want to create a function that sums two numbers but also multiplies them. The function code would look like this:

```go
func calc(number1 string, number2 string) (sum int, mul int) {
    int1, _ := strconv.Atoi(number1)
    int2, _ := strconv.Atoi(number2)
    sum = int1 + int2
    mul = int1 * int2
    return
}
```

You now need two variables to store the results of the function. (It won't compile otherwise.) Here's what it looks like:

```go
package main

import (
    "fmt"
    "os"
    "strconv"
)

func main() {
    sum, mul := calc(os.Args[1], os.Args[2])
    fmt.Println("Sum:", sum)
    fmt.Println("Mul:", mul)
}
```

Another interesting feature in Go is that if you don't need one of the return values from a function, you can discard it by assigning the returning value to the `_` variable. The `_` variable is the idiomatic way for Go to ignore return values. It allows the program to compile. So, if you only want the sum value, you could use this code:

```go
package main

import (
    "fmt"
    "os"
    "strconv"
)

func main() {
    sum, _ := calc(os.Args[1], os.Args[2])
    fmt.Println("Sum:", sum)
}
```

We'll look more at ignoring return values from functions when we explore error handling in an upcoming module.

## Change function parameter values (pointers)

When you pass a value to a function, every change in that function won't affect the caller. Go is a "pass by value" programming language. Whenever you pass a value to a function, Go takes that value and creates a local copy (a new variable in memory). Changes you make to that variable in the function don't affect the one you sent to the function.

For example, say you create a function to update a person's name. Notice what happens when you run this code:

```go
package main

import "fmt"

func main() {
    firstName := "John"
    updateName(firstName)
    fmt.Println(firstName)
}

func updateName(name string) {
    name = "David"
}
```

Even though you changed the name to "David" in the function, the output is still "John." The output hasn't changed because the change in the `updateName` function modifies only the local copy. Go passed the value of the variable, not the variable itself.

If you want the change you make in the `updateName` function to affect the `firstName` variable in the `main` function, you need to use a pointer. A *pointer* is a variable that contains the memory address of another variable. When you send a pointer to a function, you're not passing a value, you're passing a memory address. So every change you make to that variable affects the caller.

In Go, there are two operators for working with pointers:

- The `&` operator takes the address of the object that follows it.
- The `*` operator dereferences a pointer. It gives you access to the object at the address contained in the pointer.

Let's modify our previous example to clarify how pointers work:

```go
package main

import "fmt"

func main() {
    firstName := "John"
    updateName(&firstName)
    fmt.Println(firstName)
}

func updateName(name *string) {
    *name = "David"
}
```

Run the preceding code. Notice that the output now shows `David` instead of `John`.

The first thing you have to do is modify the function's signature to indicate that you want to receive a pointer. To do so, change the parameter type from `string` to `*string`. (The latter is still a string, but now it's a *pointer to a string*.) Then, when you assign a new value to that variable, you need to add the star (`*`) on the left side of the variable to yield that variable's value. When you call the `updateName` function, you don't send the value but the memory address of the variable. The `&` symbol on the left side of the variable indicates the address of the variable.
