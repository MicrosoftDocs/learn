A method in Go is a special type of function with a simple difference: you have to include an extra parameter before the function name. This additional parameter is known as the *receiver*. Methods are useful when you want to group functions and tied them to a custom type. This approach looks similar to creating a class (as in other programming languages) that allows you to implement certain features from the object-oriented programming (OOP) model like embedding, overloading, and encapsulation.

To understand why methods are important in Go, let's start with how you declare one.

## Declare methods

At this point, you've used structs only as another custom type you can create in Go. But in this module, you'll learn that you can add behavior to the structs you create by adding methods.

The syntax to declare a method is something like this:

```go
func (variable type) MethodName(parameters ...) {
    // method functionality
}
```

However, before you declare a method, you have to create a struct. So, let's say that you'd like to make a geometry package, and as part of that package, you decide to create a triangle struct called `triangle`. Then, you'd like to have a method to calculate the perimeter of that triangle. You could represent it in Go like this:

```go
type triangle struct {
    size int
}

func (t triangle) perimeter() int {
    return t.size * 3
}
```

Notice that the struct looks like a normal struct. However, the `perimeter()` function has an extra parameter of type `triangle` before the function name. This means that when you use the struct, you can call the function with the dotted notation, like this:

```go
func main() {
    t := triangle{3}
    fmt.Println("Perimeter:", t.perimeter())
}
```

If you try to call the `perimeter()` function as you'd typically do with a function, it won't work because that function's signature says that it needs a receiver. That's why the only way to call that method is by declaring a struct first, and then you have access to the method. This means that you could even have the same name for a method as long as it belongs to a different struct. For instance, you could declare a `square` struct with a `perimeter()` function, like this:

```go
package main

import "fmt"

type triangle struct {
    size int
}

type square struct {
    size int
}

func (t triangle) perimeter() int {
    return t.size * 3
}

func (s square) perimeter() int {
    return s.size * 4
}

func main() {
    t := triangle{3}
    s := square{4}
    fmt.Println("Perimeter (triangle):", t.perimeter())
    fmt.Println("Perimeter (square):", s.perimeter())
}
```

When you run the preceding code, notice that there's no error, and you see the following output:

```output
Perimeter (triangle): 9
Perimeter (square): 16
```

From the two calls to the `perimeter()` function, the compiler determines which function to call based on the receiver type. This helps keep consistency and short names in functions among packages and avoid including the package name as a prefix. We'll talk about why this might be important when we cover interfaces in the next module.

## Pointers in methods

There will be times when a method needs to update a variable, or if the argument is too big, you might want to avoid copying it. Therefore, you need to use pointers to pass the address of a variable. Remember, in a previous module, when we talked about pointers, we said that every time you call a function in Go, Go makes a copy of each argument value to use it.

The same behavior is present when you need to update the receiver variable in a method. For instance, let's say that you'd like to create a new method to double the triangle size. You'll have to use a pointer in the receiver variable, like this:

```go
func (t *triangle) doubleSize() {
    t.size *= 2
}
```

Then, you can prove that the method works, like this:

```go
func main() {
    t := triangle{3}
    t.doubleSize()
    fmt.Println("Size:", t.size)
    fmt.Println("Perimeter:", s.perimeter())
}
```

When you run the preceding code, you should see the following output:

```output
Size: 6
Perimeter: 18
```

You don't need a pointer in the receiver variable when the method is merely accessing the receiver's information. **However, Go's convention dictates that if any method of a struct has a pointer receiver, then all methods of that struct should have a pointer receiver, even if there are methods that don't need it**.

## Declare methods for other types

One crucial aspect of methods is defining methods for any type, not just for custom types like structs. However, you can't define a struct from a type that belongs to another package. Therefore, you can't create a method on a basic type like a `string`.

Nonetheless, there's a hack where you create a custom type from a basic type and use it as if it was the basic type. Let's see how this works with an example. For instance, you'd like to create a method to transform a string to upper case. You could write something like this:

```go
package main

import (
    "fmt"
    "strings"
)

type upperstring string

func (s upperstring) Upper() string {
    return strings.ToUpper(string(s))
}

func main() {
    s := upperstring("Learning Go!")
    fmt.Println(s)
    fmt.Println(s.Upper())
}
```

When you run the above code, you see the following output:

```output
Learning Go!
LEARNING GO!
```

Notice how the string you can continue using the new object as if it was a string by the first time you print out its value. Then, when you call the `Upper` method, the string changes.

## Embed methods

When you learned about structs in a previous module, you learned that you con embed properties from one struct to another. That is, you can reuse properties from one struct to avoid repetition and keep consistency in your codebase. Something similar applies to methods too, where you can call methods of the embedded struct even if the receiver is different.

For instance, let's say that you'd like to create a new triangle struct with logic to include color the triangle. Additionally, you'd like to continue using the triangle struct we declared before. So, the colored triangle struct should look like this:

```go
type coloredTriangle struct {
    triangle
    color string
}
```

Then, you could initialize the `coloredTriangle` struct, and call the `perimeter()` method from the `triangle` struct (and even access its fields), like this:

```go
func main() {
    t := coloredTriangle{triangle{3}, "blue"}
    fmt.Println("Size:", t.size)
    fmt.Println("Perimeter", t.perimeter())
}
```

Go ahead and include the above changes in your program to see how embedding works. When you run the program with a `main()` like the previous one, you should see the following output:

```output
Size: 3
Perimeter 9
```

If you're familiar with any existing OOP language, you might think that the `triangle` struct looks like a base class and `coloredTriangle` is a subclass (like inheritance), but that's not quite correct. What's happening, in reality, is that the Go compiler is promoting the `perimeter()` method by creating a wrapper method, something like this:

```go
func (t coloredTriangle) perimeter() int {
    return t.triangle.perimeter()
}
```

Notice that the receiver is `coloredTriangle`, calling the `perimeter()` method from the triangle field. The good news is that you don't need to create the above method (but you could). Go does that for your under the hood. We included the above just for learning purposes.

## Overload methods

Following with the same `triangle` example, we wrote before. What happens if you want to change the implementation of the `perimeter()` method in the `coloredTriangle` struct? You can't have two functions with the same name. However, because methods need an extra parameter (the receiver), you're allowed to have a method with the same name as long as you're specific to the receiver you want to use.

In other words, you could write the wrapper method we mentioned before if you want to change its behavior. Let's suppose that the perimeter in a colored triangle it's two times the perimeter from a normal triangle, something like this:

```go
func (t coloredTriangle) perimeter() int {
    return t.size * 3 * 2
}
```

Now, without changing anything else in the `main()` method you wrote before, like this:

```go
func main() {
    t := coloredTriangle{triangle{3}, "blue"}
    fmt.Println("Size:", t.size)
    fmt.Println("Perimeter", t.perimeter())
}
```

You'll have a different output when you run it:

```output
Size: 3
Perimeter 18
```

However, if you still need to call the `perimeter()` method from the `triangle` struct, you can do it by accessing it explicitly, like this:

```go
func main() {
    t := coloredTriangle{triangle{3}, "blue"}
    fmt.Println("Size:", t.size)
    fmt.Println("Perimeter (colored)", t.perimeter())
    fmt.Println("Perimeter (normal)", t.triangle.perimeter())
}
```

Now when you run the preceding code, you should see the following output:

```output
Size: 3
Perimeter (colored) 18
Perimeter (normal) 9
```

As you've noticed, in Go, you can "override" a method and still access the "original" one in case you need it.

## Encapsulation in methods

Encapsulation means that a method is not accessible to the caller (client) of an object. Usually, in other programming languages, you simply need to use the `private` or `public` keywords before the method's name. However, in Go, you simply need to use a capitalized identifier to make a method public and an uncapitalized identifier to make a method private.

As a reminder, encapsulation in Go only takes effect between packages. In other words, you can only hide implementation details to another package, but not to the package itself.

To give it a try, create a new package `geometry` and move the triangle struct there, like this:

```go
package geometry

type Triangle struct {
    size int
}

func (t *Triangle) doubleSize() {
    t.size *= 2
}

func (t *Triangle) SetSize(size int) {
    t.size = size
}

func (t *Triangle) Perimeter() int {
    t.doubleSize()
    return t.size * 3
}
```

You could use the preceding package like this:

```go
func main() {
    t := geometry.Triangle{}
    t.SetSize(3)
    fmt.Println("Perimeter", t.Perimeter())
}
```

And you should see the following output:

```output
Perimeter 18
```

If you try to call the `size` field or the `doubleSize()` method from the `main()` function, the program will panic, like this:

```go
func main() {
    t := geometry.Triangle{}
    t.SetSize(3)
    fmt.Println("Size", t.size)
    fmt.Println("Perimeter", t.Perimeter())
}
```

When you run the preceding code, you get the following error:

```output
./main.go:12:23: t.size undefined (cannot refer to unexported field or method size)
```
