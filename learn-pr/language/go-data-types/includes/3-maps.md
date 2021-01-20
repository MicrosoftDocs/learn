A map in Go is basically a hash table, which is a collection of key/value pairs items. All keys in a map have to be of the same type, as well as the values. However, you can use different types for keys and values. For instance, keys could be numbers, and the values could be strings. To access a particular item in a map, you do it by referencing its key.

## Declaring and initializing a map

To declare a map, you need to use the `map` keyword, and then you define the key and value type, like this `map[T]T`. For instance, if you would like to create a map that contains the age of students, you can use the following code:

```go
package main

import "fmt"

func main() {
    studentsAge := map[string]int{
        "john": 32,
        "bob":  31,
    }
    fmt.Println(studentsAge)
}
```

When you run the above code, you see the following output:

```output
map[bob:31 john:32]
```

If you don't want to initialize a map with items, you can use the built-in `make()` function to create a slice in the previous section. You could use the following code to create an empty map:

```go
studentsAge := make(map[string]int)
```

Maps are dynamic. You can add, access, or remove items after creating them. Let's explore those actions.

## Adding items

To add items, you don't need to use a built-in function as you do with slices. Maps are more straightforward, and you only need to define a key and a value. If the pair doesn't exist, the item is added to the map.

Let's rewrite the code we used previously to create a map using the `make` function and then adding items to the map. You could use the following code:

```go
package main

import "fmt"

func main() {
    studentsAge := make(map[string]int)
    studentsAge["john"] = 32
    studentsAge["bob"] = 31
    fmt.Println(studentsAge)
}
```

When you run the code, you get the same output as before:

```output
map[bob:31 john:32]
```

Notice that we've added items to a map that was initialized. But if you try to do the same with a `nil` map, you'll get an error. For instance, the following code won't work:

```go
package main

import "fmt"

func main() {
    var studentsAge map[string]int
    studentsAge["john"] = 32
    studentsAge["bob"] = 31
    fmt.Println(studentsAge)
}
```

When you run the above code, you get the following error:

```output
panic: assignment to entry in nil map

goroutine 1 [running]:
main.main()
        /Users/johndoe/go/src/helloworld/main.go:7 +0x4f
exit status 2
```

To avoid having problems when adding items into a map, make sure you create an empty map (not a `nil` map) using the `make` function as we showed in the previous code snippet. However, this rule only applies when adding items. If you run lookups, deletes, or loop operations in a `nil` map, Go won't panic. We'll confirm that in a moment.

## Accessing items

To access items in a map, you use the usual subscript notation `m[key]`, as you do with arrays or slices. Here's a simple example of how to access an item:

```go
package main

import "fmt"

func main() {
    studentsAge := make(map[string]int)
    studentsAge["john"] = 32
    studentsAge["bob"] = 31
    fmt.Println("Bob's age is", studentsAge["bob"])
}
```

When you use the subscript notation in a map, you always get a response back, even if the key is not present on a map. Go doesn't panic when you access an item that doesn't exist. Instead, you get the default value back. You can confirm that behavior using the following code:

```go
package main

import "fmt"

func main() {
    studentsAge := make(map[string]int)
    studentsAge["john"] = 32
    studentsAge["bob"] = 31
    fmt.Println("Christy's age is", studentsAge["christy"])
}
```

When you run the above code, you see the following output:

```output
Christy's age is 0
```

Although in many cases, it's fair that Go doesn't return an error when accessing an item that doesn't exist in a map, there are times where you need to know if an item exists or not. In Go, the subscript notation for a map can yield two values. The first one would be the value of an item, and the second one, is a boolean flag that indicates if the key exists or not.

To fix the problem with the last code snippet, you could do the following:

```go
package main

import "fmt"

func main() {
    studentsAge := make(map[string]int)
    studentsAge["john"] = 32
    studentsAge["bob"] = 31

    age, exist := studentsAge["christy"]
    if exist {
        fmt.Println("Christy's age is", age)
    } else {
        fmt.Println("Christy's age couldn't be found")
    }
}
```

When you run the above code, you see the following output:

```output
Christy's age couldn't be found
```

Use the second code snippet when you need to check if a key in a map exists before accessing it.

## Removing items

To remove an item from a map, you can use the built-in `delete()` function. Here's an example of how to remove items from a map:

```go
package main

import "fmt"

func main() {
    studentsAge := make(map[string]int)
    studentsAge["john"] = 32
    studentsAge["bob"] = 31
    delete(studentsAge, "john")
    fmt.Println(studentsAge)
}
```

When you run the code, you get the following output:

```output
map[bob:31]
```

And as we said before, if you try to delete an item that doesn't exist, Go won't panic. Here's an example of that:

```go
package main

import "fmt"

func main() {
    studentsAge := make(map[string]int)
    studentsAge["john"] = 32
    studentsAge["bob"] = 31
    delete(studentsAge, "christy")
    fmt.Println(studentsAge)
}
```

When you run the code, you don't get an error, and the output is the following:

```output
map[bob:31 john:32]
```

## Looping in a map

Lastly, let's see how you can loop in a map to access all its items programmatically. To do so, you can use the range-based loop, like this:

```go
package main

import (
    "fmt"
)

func main() {
    studentsAge := make(map[string]int)
    studentsAge["john"] = 32
    studentsAge["bob"] = 31
    for name, age := range studentsAge {
        fmt.Printf("%s\t%d\n", name, age)
    }
}
```

When you run the above code, you see the following output:

```output
john    32
bob     31
```

Notice how you can store the key and value information in different variables. In this case, we're holding the key in the `name` variable, and the value in the `age` variable. `range` yields first the key of an item, and secondly the value of that item. And you can ignore either one of them using the `_` variable, like this:

```go
package main

import (
    "fmt"
)

func main() {
    studentsAge := make(map[string]int)
    studentsAge["john"] = 32
    studentsAge["bob"] = 31

    for _, age := range studentsAge {
        fmt.Printf("Ages %d\n", age)
    }
}
```

Even though, in this case, it doesn't make any sense to print the ages in that way, there are going to be cases where you don't really need to know the key of an item. Alternatively, you can use only the item's key, like this:

```go
package main

import (
    "fmt"
)

func main() {
    studentsAge := make(map[string]int)
    studentsAge["john"] = 32
    studentsAge["bob"] = 31

    for name := range studentsAge {
        fmt.Printf("Names %s\n", name)
    }
}
```
