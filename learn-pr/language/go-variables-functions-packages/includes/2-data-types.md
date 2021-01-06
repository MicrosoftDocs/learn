Go is a strongly typed language. This means that every variable you declare is bound to a specific data type and will accept only values that match this type.

In Go, you have four categories of data types:

- Basic types: numbers, strings, and booleans
- Aggregate types: arrays and structs
- Reference types: pointers, slices, maps, functions, and channels
- Interface types: interface

In this module, we're covering only the basic types. Don't worry if you don't know what the other types are. We'll cover them in the upcoming modules.

Let's start by exploring the numeric data types.

## Integer numbers

In general terms, the keyword to define an integer type is `int`. But Go also provides the `int8`, `int16`, `int32`, and `int64` types, which are ints with a size of 8, 16, 32, or 64 bits, respectively. When you just use `int`, the size is 32 bits on 32-bit systems and 64 bits on 64-bit systems (most of the time, but it might differ from one computer to another). If you need to represent a value as an unsigned number, you can use `uint`, but only use this type when you have a specific reason to. Go also provides `uint8`, `uint16`, `uint32`, and `uint64` types.

Here's an example of how to use the various integer types in Go:

```go
var integer8 int8 = 127
var integer16 int16 = 32767
var integer32 int32 = 2147483647
var integer64 int64 = 9223372036854775807
println(integer8, integer16, integer32, integer64)
```

Most of the time, you'll use `int`, but you need to know about the other integer types because, in Go, `int` isn't the same as `int32`, even if the integer's natural size is 32 bits. In other words, you'll need to cast explicitly when a cast is required. And if you try to perform a math operation between different types, you'll get an error. For example, suppose you have this code:

```go
var integer16 int16 = 127
var integer32 int32 = 32767
println(integer16 + integer32)
```

When you run the program, you'll get this error:

```output
invalid operation: integer16 + integer32 (mismatched types int16 and int32)
```

As you can see, unlike in other programming languages, in Go you need to be explicit when you convert a value from one type to another. We'll talk about how to cast types properly at the end of this module.

As you progress in your Go learning, you might hear about [runes](https://www.geeksforgeeks.org/rune-in-golang/). A `rune` is simply an alias for an `int32` data type. It's used to represent a Unicode character (or a Unicode code point). For example, say you have this code:

```go
rune := 'G'
println(rune)
```

You might expect to see the program print `G` in the command prompt when you run the preceding code snippet. But you see the number `71`, which represents the Unicode character for `G`. We'll talk more about runes in the upcoming modules.

You can learn about the ranges for each type by looking at the [Go source code](https://golang.org/src/builtin/builtin.go). Knowing the ranges of each type will help you choose the proper data type, and you'll also avoid wasting bits in memory.

### Challenge 1:

Set another variable of type `int` and use the value from the `integer32` or `integer64` variable to confirm the natural size of the variable on your system. If you're on a 32-bit system and use a value higher than 2,147,483,647, you'll get an overflow error that looks like this one: `constant 9223372036854775807 overflows int`.

> **Challenge solution**:
>```go
>package main
>
>func main() {
>    var integer32 int = 2147483648
>    println(integer32)
>}
>```

### Challenge 2:

Declare an unsigned variable like `uint`, and initialize it with a negative value like `-10`. When you try to run the program, you should get an error like this one: `constant -10 overflows uint`.

> **Challenge solution**:
>```go
>package main
>
>func main() {
>    var integer uint = -10
>    println(integer)
>}
>```

## Floating-point numbers

Go provides data types for two sizes of floating-point numbers: `float32` and `float64`. You can use these types when you need to store large numbers and they don't fit in any of the previously mentioned integer types. The difference between these two types is the maximum size of bits they can hold. Look at the following lines to learn how to use these two types:

```go
var float32 float32 = 2147483647
var float64 float64 = 9223372036854775807
println(float32, float64)
```

You can find the limits of these two types by using the `math.MaxFloat32` and `math.MaxFloat64` constants, which are available in the `math` package. Use the following code to print the maximum floating-point values in the command prompt:

```go
package main

import "math"

func main() {
    println(math.MaxFloat32, math.MaxFloat64)
}
```

Floating-point types are also useful when you need to use decimal numbers. For example, you could write something like this code:

```go
const e = 2.71828
const Avogadro = 6.02214129e23
const Planck = 6.62606957e-34
```

Notice that with the previous code, Go infers the data types from the values used.

## Booleans

A boolean type has only two possible values: `true` and `false`. You declare a boolean type by using the keyword `bool`. Go is different from other programming languages in that in Go you can't implicitly convert a boolean type to either 0 or 1. You have to do it explicitly.

So you can declare a boolean variable like this:

```go
var featureFlag bool = true
```

We'll use boolean data types in the upcoming module when we talk about control flow statements in Go. We'll also use them in later modules.

## Strings

Finally, let's look at the most common data type in any programming language: string. In Go, the keyword `string` is used to represent a string data type. To initialize a string variable, you need to define its value within double quotation marks (`"`). Single quotation marks (`'`) are used for single characters (and for runes, as we saw in a previous section).

For example, the following code shows two ways to declare and initialize a string variable:

```go
var firstName string = "John"
lastName := "Doe"
println(firstName, lastName)
```

You'll sometimes need to escape characters. To do so in Go, you use a backslash (`\`) before the character. For instance, here are the most common examples of using escape characters:

- `\n` for new lines
- `\r` for carriage returns
- `\t` for tabs
- `\'` for single quotation marks
- `\"` for double quotation marks
- `\\` for backslashes

Use the following code snippet to test escape characters:

```go
fullName := "John Doe \t(alias \"Foo\")\n"
println(fullName)
```

You should see the following output (including the new line):

```output
John Doe        (alias "Foo")

```

## Default values

So far, almost every time we've declared a variable, we've initialized it with a value. But in Go, unlike in other programming languages, all data types have a default value when you don't initialize a variable. This feature comes in handy because you don't have to check if a variable has been initialized before you use it.

Here's a list of a few default values for the types we've explored so far:

- `0` for `int` types (and all of its subtypes, like `int64`)
- `+0.000000e+000` for `float32` and `float64` types
- `false` for `bool` types
- An empty value for `string` types

Run the following code snippet to confirm the default values listed previously:

```output
var defaultInt int
var defaultFloat32 float32
var defaultFloat64 float64
var defaultBool bool
var defaultString string
println(defaultInt, defaultBool, defaultFloat32, defaultFloat64, defaultString)
```

You could use code like this code to determine the default value for a data type we didn't explore here.

## Type conversions

In a previous section, we confirmed that implicit casting doesn't work in Go. In Go, casting needs to be done explicitly. Go offers some native ways for converting one data type to a different data type. For example, one way is to use the built-in function for each type, like this:

```go
var integer16 int16 = 127
var integer32 int32 = 32767
println(int32(integer16) + integer32)
```

Another approach for casting in Go is to use the [strconv package](https://golang.org/pkg/strconv/). For example, to convert a `string` to an `int`, and vice-versa, you could use this code:

```go
package main

import "strconv"

func main() {
    i, _ := strconv.Atoi("-42")
    s := strconv.Itoa(-42)
    println(i, s)
}
```

Run the preceding code, and confirm that it runs and prints `-42` two times.

Notice that there's an underscore (`_`) used as the name of a variable in the preceding code. In Go, that means we're not going to use that variable's value, and that we want to ignore it. Otherwise, the program won't compile because we need to use all variables that we declare. We'll come back to this topic, and you'll learn what the `_` typically represents in the upcoming modules.
