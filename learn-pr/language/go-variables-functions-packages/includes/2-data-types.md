Go is a strongly typed language, meaning that every variable you declare is bound to a specific data type and won't accept any values that don't match with its type.

In Go, you have four different categories for data types:

1. Basic Types: numbers, strings, and booleans.
2. Aggregate Types: arrays and structs.
3. Reference Types: pointers, slices, maps, functions, and channels.
4. Interface Types: interface.

In this module, we're covering only the basic types. Don't worry if you don't know what the other types are; we'll cover them in the upcoming modules.

So, let's start by exploring the numeric data types.

## Integer numbers

In general terms, the keyword to define an integer type is `int`. However, Go also provides the `int8`, `int16`, `int32`, and `int64` types, which are ints with size of 32 or 64 bits, respectively. When you simply use `int`, the size is 32 bits on 32-bit systems and 64 on 64-bit systems (most of the time, but it might differ from one machine to another). If you need to represent a value as an unsigned number, you could use `uint`, but only use this type when you have specific reasons to do use it. And like `int`, Go also provides `uint8`, `uint16`, `uint32`, and `uint64` types.

So, here's an example of how to use the different integer types in Go:

```go
var integer8 int8 = 127
var integer16 int16 = 32767
var integer32 int32 = 2147483647
var integer64 int64 = 9223372036854775807
println(integer8, integer16, integer32, integer64)
```

Most of the time, you'll use `int`, but you must know about the different integer types because for Go, `int` is not the same as `int32`, even if the integer's natural size is 32 bits. In other words, you'll need to cast explicitly when you require it. Moreover, if you try to perform a math operation between different types, you'll get an error. For instance, suppose you have the following code:

```go
var integer16 int16 = 127
var integer32 int32 = 32767
println(integer16 + integer32)
```

When you run the program, you'll get the following error:

```output
invalid operation: integer16 + integer32 (mismatched types int16 and int32)
```

As you can see, unlike other programming languages, in Go, you need to be very explicit when converting a value from one type to another. We'll talk about how to cast types properly at the end of this module.

Additionally, as you progress in your Go learning, you might be hearing in the future something about [runes](https://www.geeksforgeeks.org/rune-in-golang/). A `rune` is simply an alias for an `int32` data type, and it's used to represent a Unicode character (or a Unicode code point). For instance, let's say that you have the following code:

```go
rune := 'G'
println(rune)
```

When you run the above code snippet, you might expect to see the program prints `G` in the command prompt. However, what you see it's the number `71`, which represents the Unicode character for `G`. We'll talk more about runes in the upcoming modules.

You can learn about the different ranges for each type by looking at the [Go's source code](https://golang.org/src/builtin/builtin.go). Knowing the ranges of each type will help you choose the proper data type, and you'll also avoid wasting bits in memory.

### Challenge 1:

Set another variable of type `int` and use either the value from the `integer32` or `integer64` variables to confirm the natural size of the variable in your system. If you're on a 32-bit system and use a value higher than 2147483647, you'll get an overflow error like `constant 9223372036854775807 overflows int`.

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

Declare an unsigned variable like `uint`, and initialize it with a negative value like `-10`. When you try to run the program, you should get an error like `constant -10 overflows uint`.

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

When you need to store high numbers, and they don't fit in any of the previous integer types, Go provides you with two sizes of floating-point numbers, `float32` and `float64`. The difference between these two types is the maximum size of bits they can hold. Look at the following lines to learn how to use these two types:

```go
var float32 float32 = 2147483647
var float64 float64 = 9223372036854775807
println(float32, float64)
```

You can find the limits of these two types in the `math` package using the `math.MaxFloat32` and `math.MaxFloat64` constants. Use the following code to print in the command prompt the maximum floating-point values:

```go
package main

import "math"

func main() {
    println(math.MaxFloat32, math.MaxFloat64)
}
```

Besides the size, floating-point numbers are useful when you need to use decimal numbers. For instance, you could write something like this:

```go
const e = 2.71828
const Avogadro = 6.02214129e23
const Planck = 6.62606957e-34
```

Notice that with the previous code, Go infers the data types from the values used.

## Booleans

A boolean type has only two possible values, `true` or `false`, and you declare a boolean type using the keyword `bool`. Unlike other programming languages, in Go, you **can't convert implicitly** a boolean type to either 0 or 1; you'll have to do it explicitly.

So to declare a boolean variable, you can do it like this:

```go
var featureFlag bool = true
```

We'll use boolean data types in the upcoming module when we talk about control flow statements in Go and in further modules.

## Strings

Lastly, let's look at the most common data type in any programming language, strings. In Go, the keyword `string` is used to represent a string data type. To initialize a string variable, you need to define its value within double quotes (`" `). Otherwise, single quotes (`'`) are used for single characters (or runes, as we saw in a previous section)

For instance, the following code shows you two ways of declaring and initializing a string variable:

```go
var firstName string = "John"
lastName := "Doe"
println(firstName, lastName)
```

Additionally, there are going to be times where you need to escape characters. To do so, in Go, you use a backslash (`\`) before the character. For instance, the most common examples are the following ones:

- `\n` for new lines
- `\r` for carriage returns
- `\t` for tabs
- `\" for single quotes
- `\"` for double quotes
- `\\` for backslash

Use the following code snippet to test escaping characters:

```go
fullName := "John Doe \t(alias \"Foo\")\n"
println(fullName)
```

You should see the following output (including the new line):

```output
John Doe        (alias "Foo")

```

## Default values

At this point, almost every time we declare a variable, we initialize it with a value. However, unlike other programming languages, **all data types have a default value** when you don't initialize a variable. This feature comes in handy as you don't have to check if a variable has been initialized before using it.

Here's a list of a few default values for the types we've explored so far:

- `0` for `int` types (and all its subtypes like `int64`)
- `+0.000000e+000` for `float32` and `float64` types
- `false` for `bool` types
- A string type has an empty value

Run the following code snippet to confirm the above default values list:

```output
var defaultInt int
var defaultFloat32 float32
var defaultFloat64 float64
var defaultBool bool
var defaultString string
println(defaultInt, defaultBool, defaultFloat32, defaultFloat64, defaultString)
```

You could use something like the previous code to determine the default value for a data type we didn't explore here.

## Type conversions

In a previous section, we confirmed that implicit casting doesn't work in Go. And the reason for that it's because, in Go, casting needs to be done explicitly (as we've said a few times already). Go offers some native ways for converting one data type to a different data type. For instance, one way is by simply using the built-in function for each type, like this:

```go
var integer16 int16 = 127
var integer32 int32 = 32767
println(int32(integer16) + integer32)
```

Another approach for casting in Go is by using the [strconv package](https://golang.org/pkg/strconv/). For instance, to convert a `string` to an `int`, and vice-versa, you could do it like this:

```go
package main

import "strconv"

func main() {
    i, _ := strconv.Atoi("-42")
    s := strconv.Itoa(-42)
    println(i, s)
}
```

Run the above code, confirm that it runs, and prints `-42` two times.

Notice that there's a `_` as the name of a variable from the above code. In Go, that means that we're not going to use that variable's value, and we want to ignore it. Otherwise, the program won't compile as we need to use all variables we declare. We'll come back to this topic, and you'll learn what the typically `_` represents in the upcoming modules.
