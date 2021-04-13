A method in Go is a special type of function with a simple difference: you have to include an extra parameter before the function name. This additional parameter is known as the *receiver*. 

Methods are useful when you want to group functions and tie them to a custom type. This approach in Go is similar to creating a class in other programming languages, because it allows you to implement certain features from the object-oriented programming (OOP) model, such as embedding, overloading, and encapsulation.

To understand why methods are important in Go, let's start with how you declare one.

## Declare methods

So far, you've used structs only as another custom type you can create in Go. In this module, you'll learn that, by adding methods, you can add behaviors to the structs you create.

The syntax to declare a method is something like this:

```go
func (variable type) MethodName(parameters ...) {
    // method functionality
}
```

However, before you can declare a method, you have to create a struct. Let's say you want to make a geometry package and, as part of that package, you decide to create a triangle struct called `triangle`. You then want to use a method to calculate the perimeter of that triangle. You can represent it in Go like this:

```go
type triangle struct {
    size int
}

func (t triangle) perimeter() int {
    return t.size * 3
}
```

The struct looks like a normal one, but the `perimeter()` function has an extra parameter of type `triangle` before the function name. This means that when you use the struct, you can call the function like this:

```go
func main() {
    t := triangle{3}
    fmt.Println("Perimeter:", t.perimeter())
}
```

If you try to call the `perimeter()` function as you ordinarily would, it won't work because the function's signature says that it needs a receiver. That's why the only way to call that method is to declare a struct first, which gives you access to the method. This means that you could even have the same name for a method as long as it belongs to a different struct. For instance, you could declare a `square` struct with a `perimeter()` function, like this:

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

When you run the preceding code, notice that there's no error, and you get the following output:

```output
Perimeter (triangle): 9
Perimeter (square): 16
```

From the two calls to the `perimeter()` function, the compiler determines which function to call based on the receiver type. This helps keep consistency and short names in functions among packages and avoids including the package name as a prefix. We'll talk about why this might be important when we cover interfaces in the next unit.

## Pointers in methods

There will be times when a method needs to update a variable or, if the argument is too big, you might want to avoid copying it. In these instances, you need to use pointers to pass the address of a variable. In a previous module, when we discussed pointers, we said that every time you call a function in Go, Go makes a copy of each argument value to use it.

The same behavior is present when you need to update the receiver variable in a method. For instance, let's say you want to create a new method to double the triangle size. You need to use a pointer in the receiver variable, like this:

```go
func (t *triangle) doubleSize() {
    t.size *= 2
}
```

You can prove that the method works, like this:

```go
func main() {
    t := triangle{3}
    t.doubleSize()
    fmt.Println("Size:", t.size)
    fmt.Println("Perimeter:", s.perimeter())
}
```

When you run the preceding code, you should get the following output:

```output
Size: 6
Perimeter: 18
```

You don't need a pointer in the receiver variable when the method is merely accessing the receiver's information. However, Go convention dictates that if any method of a struct has a pointer receiver, all methods of that struct must have a pointer receiver, even if a method doesn't need it.

## Declare methods for other types

One crucial aspect of methods is defining them for any type, not just for custom types such as structs. However, you can't define a struct from a type that belongs to another package. Therefore, you can't create a method on a basic type, such as a `string`.

Nonetheless, you can use a hack to create a custom type from a basic type and then use it as if it were the basic type. For instance, let's say you want to create a method to transform a string from lowercase letters to uppercase. You could write something like this:

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

When you run the preceding code, you get the following output:

```output
Learning Go!
LEARNING GO!
```

Notice how you can use the new object `s` as if it were a string when you first print out its value. Then, when you call the `Upper` method, `s` prints out all uppercase letters of type string.

## Embed methods

In a previous module, you learned that you can use a property in one struct and embed the same property in another struct. That is, you can reuse properties from one struct to avoid repetition and keep consistency in your code base. A similar idea applies to methods. You can call methods of the embedded struct even if the receiver is different.

For instance, let's say you want to create a new triangle struct with logic to include a color. Additionally, you want to continue using the triangle struct you declared before. So, the colored triangle struct would look like this:

```go
type coloredTriangle struct {
    triangle
    color string
}
```

You could then initialize the `coloredTriangle` struct, and call the `perimeter()` method from the `triangle` struct (and even access its fields), like this:

```go
func main() {
    t := coloredTriangle{triangle{3}, "blue"}
    fmt.Println("Size:", t.size)
    fmt.Println("Perimeter", t.perimeter())
}
```

Go ahead and include the preceding changes in your program to see how embedding works. When you run the program with a `main()` method like the previous one, you should get the following output:

```output
Size: 3
Perimeter 9
```

If you're familiar with an OOP language such as Java or C++, you might think that the `triangle` struct looks like a base class and `coloredTriangle` is a subclass (such as inheritance), but that's not quite correct. What's happening, in reality, is that the Go compiler is promoting the `perimeter()` method by creating a wrapper method, which looks something like this:

```go
func (t coloredTriangle) perimeter() int {
    return t.triangle.perimeter()
}
```

Notice that the receiver is `coloredTriangle`, which calls the `perimeter()` method from the triangle field. The good news is that you don't need to create the preceding method. You could, but Go does that for you under the hood. We included the preceding example only for learning purposes.

## Overload methods

Let's return to the `triangle` example that we discussed earlier. What happens if you want to change the implementation of the `perimeter()` method in the `coloredTriangle` struct? You can't have two functions with the same name. However, because methods need an extra parameter (the receiver), you're allowed to have a method with the same name as long as it's specific to the receiver you want to use. That's how you overload methods.

In other words, you could write the wrapper method we've just discussed if you want to change its behavior. If the perimeter of a colored triangle is twice the perimeter of a normal triangle, the code would be something like this:

```go
func (t coloredTriangle) perimeter() int {
    return t.size * 3 * 2
}
```

Now, without changing anything else in the `main()` method you wrote before, it would look like this:

```go
func main() {
    t := coloredTriangle{triangle{3}, "blue"}
    fmt.Println("Size:", t.size)
    fmt.Println("Perimeter", t.perimeter())
}
```

When you run it, you get a different output:

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

When you run this code, you should get the following output:

```output
Size: 3
Perimeter (colored) 18
Perimeter (normal) 9
```

As you might have noticed, in Go, you can *override* a method and still access the *original* one if you need it.

## Encapsulation in methods

Encapsulation means that a method is inaccessible to the caller (client) of an object. Usually, in other programming languages, you place the `private` or `public` keywords before the method name. In Go, you need to use only a capitalized identifier to make a method public and an uncapitalized identifier to make a method private.

Encapsulation in Go takes effect only between packages. In other words, you can hide only implementation details from another package, not the package itself.

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

You could use the preceding package, like this:

```go
func main() {
    t := geometry.Triangle{}
    t.SetSize(3)
    fmt.Println("Perimeter", t.Perimeter())
}
```

And you should get the following output:

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
