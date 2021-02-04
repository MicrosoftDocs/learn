Interfaces in Go are a type of data that's used to represent the behavior of other types. An interface is like a blueprint or a contract that an object should satisfy. When you use interfaces, your code base becomes more flexible and adaptable, because you're writing code that isn't tied to a particular implementation. Therefore, you can extend the functionality of a program quickly. You'll understand why in this module.

Unlike interfaces in other programming languages, interfaces in Go are satisfied implicitly. Go doesn't offer keywords to implement an interface, so if you've worked with interfaces in other programming languages but are new to Go, this idea might be confusing.

In this module, we'll work with multiple examples to explore interfaces in Go and demonstrate how to make the most of them.

## Declare an interface

An interface in Go is an abstract type that includes only the methods that a concrete type must possess or implement. That's why we say that an interface is like a blueprint.

Let's say that you want to create an interface in your geometry package that indicates what methods a shape must implement. You could define an interface like this:

```go
type Shape interface {
    Perimeter() float64
    Area() float64
}
```

The `Shape` interface means that any type that you want to consider a `Shape` needs to have both the `Perimeter()` and `Area()` methods. For instance, when you create a `Square` struct, it has to implement both methods, not just one. Also, notice that an interface doesn't contain implementation details for those methods (for example, for calculating the perimeter and area of a shape). They're simply a contract. Shapes such as triangles, circles, and squares have different ways to calculate area and perimeter.

## Implement an interface
As we discussed previously, in Go, you don't have a keyword to implement an interface. An interface in Go is satisfied implicitly by a type when it has all the methods that an interface requires. 

Let's create a `Square` struct that has both methods from the `Shape` interface, as shown in the following example code:

```go
type Square struct {
    size float64
}

func (s Square) Area() float64 {
    return s.size * s.size
}

func (s Square) Perimeter() float64 {
    return s.size * 4
}
```

Notice how the method's signature from the `Square` struct matches the signature from the `Shape` interface. However, another interface might have a different name but the same methods. How or when does Go know which interface a concrete type is implementing? Go knows it when you're using it, at runtime.

To demonstrate how interfaces are used, you could write the following:

```go
func main() {
    var s Shape = Square{3}
    fmt.Printf("%T\n", s)
    fmt.Println("Area: ", s.Area())
    fmt.Println("Perimeter:", s.Perimeter())
}
```

When you run the preceding program, you get the following output:

```output
main.Square
Area:  9
Perimeter: 12
```

At this point, it makes no difference whether or not you use an interface. Let's create another type, such as `Circle`, and then explore why interfaces are useful. Here's the code for the `Circle` struct:

```go
type Circle struct {
    radius float64
}

func (c Circle) Area() float64 {
    return math.Pi * c.radius * c.radius
}

func (c Circle) Perimeter() float64 {
    return 2 * math.Pi * c.radius
}
```

Now let's refactor the `main()` function and create a function to print out the type of the object it receives, along with its area and perimeter, like this:

```go
func printInformation(s Shape) {
    fmt.Printf("%T\n", s)
    fmt.Println("Area: ", s.Area())
    fmt.Println("Perimeter:", s.Perimeter())
    fmt.Println()
}
```

Notice how the `printInformation` function has `Shape` as a parameter. This means that you could send to this function a `Square` or a `Circle` object, and it will work, although the output will be different. Your `main()` function now looks like this:

```go
func main() {
    var s Shape = Square{3}
    printInformation(s)

    c := Circle{6}
    printInformation(c)
}
```

Notice that for the `c` object, we don't specify that it's a `Shape` object. However, the `printInformation` function expects an object that implements the methods that are defined in the `Shape` interface.

When you run the program, you should get the following output:

```output
main.Square
Area:  9
Perimeter: 12

main.Circle
Area:  113.09733552923255
Perimeter: 37.69911184307752
```

Notice how you don't get an error, and the output varies depending on the object type it receives. You can also see that the object type in the output doesn't say anything about the `Shape` interface.

The beauty of using interfaces is that, for every new type or implementation of `Shape`, the `printInformation` function doesn't have to change. This is why we said earlier that your code becomes flexible and easier to extend when you use interfaces.

## Implement a Stringer interface

A simple example of extending existing functionality is to use a `Stringer`, which is an interface that has a `String()` method, like this:

```go
type Stringer interface {
    String() string
}
```

The `fmt.Printf` function uses this interface to print out values, which means that you can write your custom `String()` method to print a custom string, like this:

```go
package main

import "fmt"

type Person struct {
    Name, Country string
}

func (p Person) String() string {
    return fmt.Sprintf("%v is from %v", p.Name, p.Country)
}
func main() {
    rs := Person{"John Doe", "USA"}
    ab := Person{"Mark Collins", "United Kingdom"}
    fmt.Printf("%s\n%s\n", rs, ab)
}
```

When you run the preceding program, you get the following output:

```output
John Doe is from USA
Mark Collins is from United Kingdom
```

As you can see, you've used a custom type (a struct) to write a custom version of the `String()` method. This is a common way of implementing an interface in Go, and you'll find examples of this in many programs, as we're about to explore.

## Extend an existing implementation

Let's say that you have the following code, and you'd like to extend its functionality by writing a custom implementation of a `Writer` method that's in charge of manipulating some data.

By using the following code, you can create a program that consumes the GitHub API to get three repositories from Microsoft:

```go
package main

import (
    "fmt"
    "io"
    "net/http"
    "os"
)

func main() {
    resp, err := http.Get("https://api.github.com/users/microsoft/repos?page=15&per_page=5")
    if err != nil {
        fmt.Println("Error:", err)
        os.Exit(1)
    }

    io.Copy(os.Stdout, resp.Body)
}
```

When you run the preceding code, you get something like the following output (shortened for readability):

```output
[{"id":276496384,"node_id":"MDEwOlJlcG9zaXRvcnkyNzY0OTYzODQ=","name":"-Users-deepakdahiya-Desktop-juhibubash-test21zzzzzzzzzzz","full_name":"microsoft/-Users-deepakdahiya-Desktop-juhibubash-test21zzzzzzzzzzz","private":false,"owner":{"login":"microsoft","id":6154722,"node_id":"MDEyOk9yZ2FuaXphdGlvbjYxNTQ3MjI=","avatar_url":"https://avatars2.githubusercontent.com/u/6154722?v=4","gravatar_id":"","url":"https://api.github.com/users/microsoft","html_url":"https://github.com/micro
....
```

Notice that the `io.Copy(os.Stdout, resp.Body)` call is the one that prints to the terminal the content you've obtained from the call to the GitHub API. Let's say that you want to write your own implementation to shorten the content you see in the terminal. When you look at the [source of the `io.Copy` function](https://golang.org/pkg/io/#Copy), you see the following:

```go
func Copy(dst Writer, src Reader) (written int64, err error)
```

If you go deeper into the details of the first parameter, `dst Writer`, you'll notice that `Writer` is an [interface](https://golang.org/pkg/io/#Writer):

```go
type Writer interface {
    Write(p []byte) (n int, err error)
}
```

You can continue exploring the `io` package's source code until you find where [`Copy` calls the `Write` method](https://golang.org/src/io/io.go?s=12980:13040#L411). We'll leave this alone for now.

Because `Writer` is an interface and it's an object that the `Copy` function is expecting, you could write your custom implementation of the `Write` method. Therefore, you can customize the content that you print to the terminal. 

The first thing you need to implement an interface is to create a custom type. In this case, you can create an empty struct, because you simply need to write your custom `Write` method, like this:

```go
type customWriter struct{}
```

Now you're ready to write your custom `Write` function. You also need to write a struct to parse the API response in JSON format to a Golang object. You could use the JSON-to-Go site to create a struct from a JSON payload. So the `Write` method might look like this:

```go
type GitHubResponse []struct {
    FullName string `json:"full_name"`
}

func (w customWriter) Write(p []byte) (n int, err error) {
    var resp GitHubResponse
    json.Unmarshal(p, &resp)
    for _, r := range resp {
        fmt.Println(r.FullName)
    }
    return len(p), nil
}
```

Finally, you have to modify the `main()` function to use your custom object, like this:

```go
func main() {
    resp, err := http.Get("https://api.github.com/users/microsoft/repos?page=15&per_page=5")
    if err != nil {
        fmt.Println("Error:", err)
        os.Exit(1)
    }

    writer := customWriter{}
    io.Copy(writer, resp.Body)
}
```

When you run the program, you should get the following output:

```output
microsoft/aed-blockchain-learn-content
microsoft/aed-content-nasa-su20
microsoft/aed-external-learn-template
microsoft/aed-go-learn-content
microsoft/aed-learn-template
```

The output looks better now, thanks to the custom `Write` method you wrote. Here's the final version of the program:

```go
package main

import (
    "encoding/json"
    "fmt"
    "io"
    "net/http"
    "os"
)

type GitHubResponse []struct {
    FullName string `json:"full_name"`
}

type customWriter struct{}

func (w customWriter) Write(p []byte) (n int, err error) {
    var resp GitHubResponse
    json.Unmarshal(p, &resp)
    for _, r := range resp {
        fmt.Println(r.FullName)
    }
    return len(p), nil
}

func main() {
    resp, err := http.Get("https://api.github.com/users/microsoft/repos?page=15&per_page=5")
    if err != nil {
        fmt.Println("Error:", err)
        os.Exit(1)
    }

    writer := customWriter{}
    io.Copy(writer, resp.Body)
}
```

## Write a custom server API

Finally, let's explore another use case for interfaces that you might find useful if you're creating a server API. The typical way of writing a web server is by using the `http.Handler` interface from the `net/http` package, which looks like the following (you don't have to write this code):

```go
package http

type Handler interface {
    ServeHTTP(w ResponseWriter, r *Request)
}

func ListenAndServe(address string, h Handler) error
```

Notice how the `ListenAndServe` function is expecting a server address, such as `http://localhost:8000`, and an instance of the `Handler` that will dispatch the response from the call to the server address.

Let's create and then explore the following program:

```go
package main

import (
    "fmt"
    "log"
    "net/http"
)

type dollars float32

func (d dollars) String() string {
    return fmt.Sprintf("$%.2f", d)
}

type database map[string]dollars

func (db database) ServeHTTP(w http.ResponseWriter, req *http.Request) {
    for item, price := range db {
        fmt.Fprintf(w, "%s: %s\n", item, price)
    }
}

func main() {
    db := database{"Go T-Shirt": 25, "Go Jacket": 55}
    log.Fatal(http.ListenAndServe("localhost:8000", db))
}
```

Before we explore the preceding code, let's run it like this:

```bash
go run main.go
```

If you don't get any output, it's a good sign. Now open `http://localhost:8000` in a new browser window or, in your terminal, run the following command:

```bash
curl http://localhost:8000
```

You should now get the following output:

```output
Go T-Shirt: $25.00
Go Jacket: $55.00
```

Let's review the preceding code slowly to understand what it does and to observe the power of Go interfaces. First, you start by creating a custom type for a `float32` type, with the idea of writing a custom implementation of the `String()` method, which you'll use later.

```go
type dollars float32

func (d dollars) String() string {
    return fmt.Sprintf("$%.2f", d)
}
```

We then wrote the implementation of the `ServeHTTP` method that the `http.Handler` could use. Notice how we created a custom type again, but this time it's a map, not a struct. Next, we wrote the `ServeHTTP` method by using the `database` type as the receiver. This method's implementation uses the data from the receiver, loops through it, and prints out each item.

```go
type database map[string]dollars

func (db database) ServeHTTP(w http.ResponseWriter, req *http.Request) {
    for item, price := range db {
        fmt.Fprintf(w, "%s: %s\n", item, price)
    }
}
```

Finally, in the `main()` function, we instantiated a `database` type and initialized it with some values. We started the HTTP server by using the `http.ListenAndServe` function, where we defined the server address, including the port to use and the `db` object that implements a custom version of the `ServerHTTP` method. That's why, when you run the program, Go uses your implementation of that method, and that's how you use and implement an interface in a server API.

```go
func main() {
    db := database{"Go T-Shirt": 25, "Go Jacket": 55}
    log.Fatal(http.ListenAndServe("localhost:8000", db))
}
```

You can find another use case for interfaces in a server API when you use the `http.Handle` function. For more information, see the [Writing web applications](https://golang.org/doc/articles/wiki?azure-portal=true) post at the Go site.
