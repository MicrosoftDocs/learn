Interfaces in Go are another type of data and are used to represent other types' behavior. An interface is simply a blueprint or a contract that an object should satisfy. When you use interfaces, your codebase becomes more flexible and adaptable because you're not writing code tied to a particular implementation. Therefore, you can extend the functionality of a program quickly. You'll understand why in this module.

Unlike other programming languages, interfaces in Go are satisfied implicitly. Go doesn't offer keywords to implement an interface, so when you're new to Go but you've worked with interfaces in other programming languages, this might be confusing.

In this module, we'll explore interfaces in Go and how to make the most of them by running multiple examples.

## Declare an interface

An interface in Go is an abstract type that includes only the methods that a concrete type must possess (or implement). That's why we said previously that an interface it's like a blueprint.

Let's say that you want to create an interface in your geometry package that indicates what methods a shape must implement. You could define an interface like this:

```go
type Shape interface {
    Perimeter() float64
    Area() float64
}
```

The `Shape` interface means that any type that wants to be considered a `Shape` needs to have the `Perimeter()` **and** `Area()` methods. For instance, when you create a `Square` struct, it has to implement both methods, not just one. Also, notice that an interface doesn't have the implementation details for those methods (calculate the perimeter and the area of a shape). They're simply a contract. Shapes like triangles, circles, or squares have different ways to calculate the area and the perimeter.

## Implement an interface
As we said before, in Go, you don't have a keyword to implement an interface. An interface in Go is satisfied implicitly by a type when it has all the methods that an interface requires. 

For instance, let's create a `Square` struct that has both methods from the `Shape` interface, like this:

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

Notice how the method's signature from the `Square` struct matches the ones from the `Shape` interface. However, there might be another interface with a different name that has the same methods. How does Go know which interface a concrete type is implementing? Go knows it when you're using it, at runtime.

To demonstrate how interfaces are used, you could write the following:

```go
func main() {
    var s Shape = Square{3}
    fmt.Printf("%T\n", s)
    fmt.Println("Area: ", s.Area())
    fmt.Println("Perimeter:", s.Perimeter())
}
```

When you run the preceding program, you see the following output:

```output
main.Square
Area:  9
Perimeter: 12
```

At this point, it doesn't make a difference if you use an interface or not. Let's create another type like `Circle`, and then we'll explore why interfaces are useful. Here's the code for the `Circle` struct:

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

Now let's refactor the `main()` function and create a function to print out the type of the object it receives along with its area and perimeter, like this:

```go
func printInformation(s Shape) {
    fmt.Printf("%T\n", s)
    fmt.Println("Area: ", s.Area())
    fmt.Println("Perimeter:", s.Perimeter())
    fmt.Println()
}
```

Notice how the `printInformation` function has `Shape` as a parameter, this means that you could send to this function a `Square` or a `Circle` object, and it will work (although the output will be different). So now your `main()` function looks like this:

```go
func main() {
    var s Shape = Square{3}
    printInformation(s)

    c := Circle{6}
    printInformation(c)
}
```

Notice that for the `c` object, we don't specify that it's a `Shape` object. However, the `printInformation` function expects an object that implements the methods defined in the `Shape` interface.

When you run the program, you should see the following output:

```output
main.Square
Area:  9
Perimeter: 12

main.Circle
Area:  113.09733552923255
Perimeter: 37.69911184307752
```

Notice how you don't get an error, and the output varies depending on the object type it receives. You can also see the object type in the output doesn't say anything about the `Shape` interface.

The beauty of using interfaces is that for every new type or implementation of `Shape` the `printInformation` function doesn't have to change. This is why we said before that your code becomes flexible and more comfortable to extend when you use interfaces.

## Implement a Stringer interface

A simple example of extending existing functionality is by using a `Stringer` which is an interface that has a `String()` method, like this:

```go
type Stringer interface {
    String() string
}
```

The `fmt.Printf` function uses this interface to print out values, so that means you can write your custom `String()` method to print a custom string, something like this:

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

When you run the preceding program, you see the following output:

```output
John Doe is from USA
Mark Collins is from United Kingdom
```

As you can see, you've used a custom type (a struct) to write a custom version of the `String()` method. This is a common way of implementing an interface in Go, and you'll find examples of this in many programs as we're about to explore.

## Extend an existing implementation

Let's say that you have the following code, and you'd like to extend its functionality by writing a custom implementation of a `Writer` method that's in charge of manipulating some data.

Create a program using the following code that consumes the GitHub API to get three repositories from Microsoft:

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

When you run the preceding code, something like the following (a portion of it for readability purposes):

```output
[{"id":276496384,"node_id":"MDEwOlJlcG9zaXRvcnkyNzY0OTYzODQ=","name":"-Users-deepakdahiya-Desktop-juhibubash-test21zzzzzzzzzzz","full_name":"microsoft/-Users-deepakdahiya-Desktop-juhibubash-test21zzzzzzzzzzz","private":false,"owner":{"login":"microsoft","id":6154722,"node_id":"MDEyOk9yZ2FuaXphdGlvbjYxNTQ3MjI=","avatar_url":"https://avatars2.githubusercontent.com/u/6154722?v=4","gravatar_id":"","url":"https://api.github.com/users/microsoft","html_url":"https://github.com/micro
....
```

Notice that the `io.Copy(os.Stdout, resp.Body)` call is the one that prints out to the terminal the content obtained from the call to the GitHub API. Let's say that you'd like to write your own implementation to shorten the content you see in the terminal. When you look at the [source of the `io.Copy` function](https://golang.org/pkg/io/#Copy), you see the following:

```go
func Copy(dst Writer, src Reader) (written int64, err error)
```

If you go deeper and see the details of the first parameter, `dst Writer` you'll see that `Writer` is an [interface](https://golang.org/pkg/io/#Writer):

```go
type Writer interface {
    Write(p []byte) (n int, err error)
}
```

You can continue exploring the `io` package's source code until you find where [`Copy` ends up calling the `Write` method](https://golang.org/src/io/io.go?s=12980:13040#L411), but for now, let's leave it here.

Because `Writer` is an interface and it's an object that the `Copy` function is expecting, it means that you could write your custom implementation of the `Write` method. Therefore, you're able to customize the content you print out to the terminal. 

So, the first thing you need to implement an interface is to create a custom type. In this case, we can create an empty struct because we simply need to write our custom `Write` method, like this:

```go
type customWriter struct{}
```

Now you're ready to write your custom `Write` function. Also, you need to write a struct to parse the API response in JSON format to a Golang object. You could use the JSON-to-Go site to create a struct from a JSON payload. So the `Write` method could look like this:

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

Now when you run the program, you should see the following output:

```output
microsoft/aed-blockchain-learn-content
microsoft/aed-content-nasa-su20
microsoft/aed-external-learn-template
microsoft/aed-go-learn-content
microsoft/aed-learn-template
```

The output looks better now, and it's thanks to the custom `Write` method we wrote. Here's the final version of the program:

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

Finally, let's explore another use case for interfaces that you might find useful if you're creating a server API. The typical way of writing a web server is by using the `http.Handler` interface from the `net/http` package that looks like this (you don't have to write the below code):

```go
package http

type Handler interface {
    ServeHTTP(w ResponseWritter, r *Request)
}

func ListenAndServe(address string, h Handler) error
```

Notice how the `ListenAndServe` function is expecting a server address like `http://localhost:8000` and an instance of the `Handler` which will dispatch the response from the call to the server address.

Let's create the following program, and then we'll explore it:

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

If you don't see any output, it's a good sign. Now open `http://localhost:8000` in a new browser window or simply run the following command in your terminal:

```bash
curl http://localhost:8000
```

You should now see the following output:

```output
Go T-Shirt: $25.00
Go Jacket: $55.00
```

From the code above, let's review it slowly to understand what it does and see the power of Go interfaces. First, you start by creating a custom type for a `float32` type with the idea of writing a custom implementation of the `String()` method that we'll use later.

```go
type dollars float32

func (d dollars) String() string {
    return fmt.Sprintf("$%.2f", d)
}
```

Then, we wrote the implementation of the `ServeHTTP` method that the `http.Handler` could use. Notice how we created a custom type again, but this time is not a struct but a map. Then, we wrote the `ServeHTTP` method using the `database` type as the receiver. This method's implementation details are to use the data from the receiver, loop through it, and print out each item.

```go
type database map[string]dollars

func (db database) ServeHTTP(w http.ResponseWriter, req *http.Request) {
    for item, price := range db {
        fmt.Fprintf(w, "%s: %s\n", item, price)
    }
}
```

Finally, in the `main()` function, we instantiated a `database` type and initialized it with some values. Then, we start the HTTP server by using the `http.ListenAndServer` function where we define the server address, including the port to use and the `db` object that implements a custom version of the `ServerHTTP` method. That's why when you run the program Go uses your implementation of that method, and that's how you use and implement an interface in a server API.

```go
func main() {
    db := database{"Go T-Shirt": 25, "Go Jacket": 55}
    log.Fatal(http.ListenAndServe("localhost:8000", db))
}
```

Another use case for interfaces in a server API can be found when using the `http.Handle` function. You can find more information about it at the ["Writing Web Applications"](https://golang.org/doc/articles/wiki/) post from the Go site.
