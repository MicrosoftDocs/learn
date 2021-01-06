Let's start this module by looking at how to declare and use variables in Go. There are various ways to declare a variable. We'll look at each of them, and you'll choose the one that best suits your needs or style. We'll note some things specific to Go that you don't typically find in other programming languages as we explore the core concepts for variables.

We're including code snippets in this section that you can run in Visual Studio Code or in the Go Playground.

## Declaring variables

To declare a variable, you need to use the `var` keyword:

```go
var firstName string
```

The previous statement declares a variable named `firstName` of type `string`. (We'll talk about data types in the upcoming section.) This example shows the most basic way to declare a variable. If you want to declare another variable, you simply add a similar statement to the previous one. But you can declare more than one variable in a single line if they're the same type:

```go
var firstName, lastName string
```

By adding a comma (`,`) after a variable name, you're saying that you're about to declare another variable. In this case, the previous statement declares two variables named `firstName` and `lastName` of type `string`. If you want to add a third variable of type `int`, the code will look like this:

```go
var firstName, lastName string
var age int
```

Another way to write the previous statement is by using parenthesis after the `var` keyword, as if you had a dedicated block to declare variables, like this:

```go
var (
    firstName, lastName string
    age int
)
```

## Initializing variables

You've only declared variables at this point, but there will be times when you need them to have an initial value. In Go, you can initialize variables in various ways. For instance, continuing with the same example from earlier, you could initialize each variable by using this code:

```go
var (
    firstName string = "John"
    lastName  string = "Doe"
    age       int    = 32
)
```

If you decide to initialize a variable, you don't need to specify its type because Go will infer the type when you initialize the variable with a value. For example, you could declare and initialize variables like this:

```go
var (
    firstName = "John"
    lastName  = "Doe"
    age       = 32
)
```

Go will infer that the `firstName` and `lastName` variables are of `string` type and that the `age` variable is an `int` type.

## Various ways to initialize variables

In Go, you can declare and initialize variables in a single line. You separate each variable name with a comma and do the same for every value (in the same order), like this:

```go
var (
    firstName, lastName, age = "John", "Doe", 32
)
```

There's another way you can declare and initialize variables. This method is the most common way to do so in Go. The same example we've been using could look like this:

```go
func main() {
    firstName, lastName := "John", "Doe"
    age := 32
    println(firstName, lastName, age)
}
```

Run the preceding code to confirm that this way of declaring and initializing variables works.

Notice that here you need to include a colon equal sign (`:=`) and its corresponding value right after you define the variable name. When you use the colon equal sign, *the variable you're declaring has to be a new one*. If you use a colon equal sign and the variable has been declared already, the program won't compile. Go ahead and give it a try.

Finally, *you can use the colon equal sign only inside a function*. When you declare variables outside of a function, you must do it by using the `var` keyword. Don't worry if you're not familiar with functions. We'll introduce functions in a later unit.

## Declaring constants

There will be times when you need to have static values in your code, known as *constants*. Go supports the use of constants. The keyword to declare one is `const`.

For example, you can declare a constant like this:

```go
const HTTPSatusOK = 200
```

As with variables, the type of a constant is inferred from the value assigned to it. In Go, constant names are typically written in MixedCased or all uppercase letters.

If you need to declare multiple constants in one block, you can do it like this:

```go
const (
    StatusOK              = 0
    StatusConnectionReset = 1
    StatusOtherError      = 2
)
```

> [!NOTE]
> Go has an interesting concept related to constants that's called *iota*, which we're not covering in this module. But you can learn more about it by looking at the [Go wiki on GitHub](https://github.com/golang/go/wiki/Iota). Just keep in mind that `iota` is a keyword that Go uses to simplify constant definitions when the values are sequential.

Although there are similarities between constants and variables, there are some key differences. For example, you can declare constants without using them. You won't get an error message. And you can't use the colon equal sign to declare constants. Go will complain if you do.

## Go throws an error if you declare variables and don't use them

Something fundamental you need to keep in mind in Go is that when you declare a variable and don't use it, Go throws an error, not a warning as in some other programming languages.

For example, let's go back to one of our previous examples and remove the `println` call:

```go
func main() {
    firstName, lastName := "John", "Doe"
    age := 32
}
```

When you run this code in Visual Studio Code or the Go Playground, you'll see that there's an error in the lines where you're declaring the variables. You'll see these error messages:

```output
./main.go:4:2: firstName declared but not used
./main.go:4:13: lastName declared but not used
./main.go:5:2: age declared but not used
```

 Keep in mind that for every variable you declare in Go, you must use it somewhere.
