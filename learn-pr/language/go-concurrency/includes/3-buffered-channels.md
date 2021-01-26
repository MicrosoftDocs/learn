As you've learned, channels are unbuffered by default, meaning that they only accept a *send* operation if there's a *receive* operation. Otherwise, the program will be blocked waiting forever. There are times where you need that type of synchronization between goroutines. However, there might be times where you simply need to implement concurrency, and you don't need to restrict how goroutines communicate with each other.

Buffered channels send and receive data without blocking the program because a buffered channel behaves like a queue. You can limit the size of this queue when you create the channel, like this:

```go
ch := make(chan string, 10)
```

Every time you send something to the channel, the element is added to the queue. Then, a receive operation removes the element from the queue. When the channel is full, any send operation simply waits until there's space to hold the data. Conversely, if the channel is empty and there's a read operation, it's blocked until there's something to read.

Here's a simple example to understand buffered channels:

```go
package main

import (
    "fmt"
)

func send(ch chan string, message string) {
    ch <- message
}

func main() {
    size := 4
    ch := make(chan string, size)
    send(ch, "one")
    send(ch, "two")
    send(ch, "three")
    send(ch, "four")
    fmt.Println("All data sent to the channel ...")

    for i := 0; i < size; i++ {
        fmt.Println(<-ch)
    }

    fmt.Println("Done!")
}
```

When you run the program, you see the following output:

```output
All data sent to the channel ...
one
two
three
four
Done!
```

You might say that we haven't done anything different here, and you'll be right. But let's see when happens when you change the `size` variable to a lower number (you can even try with a higher number), like this:

```go
size := 2
```

When you re-run the program, you get the following error:

```output
fatal error: all goroutines are asleep - deadlock!

goroutine 1 [chan send]:
main.send(...)
        /Users/developer/go/src/concurrency/main.go:8
main.main()
        /Users/developer/go/src/concurrency/main.go:16 +0xf3
exit status 2
```

And the reason for this is that the calls to the `send` function are sequential; you're not creating a new goroutine. Therefore there's nothing to queue. *Channels are deeply connected to goroutines, and without another goroutine receiving data from the channel, the whole program might enter into a block forever (as you've seen, it does happen).* Let's make something interesting, create a goroutine for the last two calls (the first two fit into the buffer properly), and make them for loop to run four times, like this:

```go
func main() {
    size := 2
    ch := make(chan string, size)
    send(ch, "one")
    send(ch, "two")
    go send(ch, "three")
    go send(ch, "four")
    fmt.Println("All data sent to the channel ...")

    for i := 0; i < 4; i++ {
        fmt.Println(<-ch)
    }

    fmt.Println("Done!")
}
```

When you run the above program, it works as expected. As a recommended practice, when you use channels, always use goroutines.

Now, to test the case where you create a buffered channel with more elements that you'll need, let's use the example we used before to check APIs and create a buffered channel with a size of 10, like this:

```go
package main

import (
    "fmt"
    "net/http"
    "time"
)

func main() {
    start := time.Now()

    apis := []string{
        "https://management.azure.com",
        "https://dev.azure.com",
        "https://api.github.com",
        "https://outlook.office.com/",
        "https://api.somewhereintheinternet.com/",
        "https://graph.microsoft.com",
    }

    ch := make(chan string, 10)

    for _, api := range apis {
        go checkAPI(api, ch)
    }

    for i := 0; i < len(apis); i++ {
        fmt.Print(<-ch)
    }

    elapsed := time.Since(start)
    fmt.Printf("Done! It took %v seconds!\n", elapsed.Seconds())
}

func checkAPI(api string, ch chan string) {
    _, err := http.Get(api)
    if err != nil {
        ch <- fmt.Sprintf("ERROR: %s is down!\n", api)
        return
    }

    ch <- fmt.Sprintf("SUCCESS: %s is up and running!\n", api)
}
```

When you run the program, you get the same output as before. You could play around by changing the channel's size with lower or higher numbers, and the program will still work.

## Unbuffered or buffered channels?

At this point, you might be wondering when to use one type or another. And it all depends on how you want the communication to flow between goroutines. Unbuffered channels communicate synchronously, and it guarantees that every time you send data, the program gets blocked until someone is reading from the channel.

Conversely, buffered channels decouple the send and receive operations, and they don't block a program, but you have to be careful because you might end up causing a deadlock (as you've seen previously). When you use unbuffered channels, you can control how many goroutines can run concurrently. For instance, you might be making calls to an API, and you want to control how many calls you perform every second. Otherwise, you might get blocked.

## Channel directions

An interesting feature for channels in Go is that when you use channels as parameters to a function, you can specify whether the channel is meant to *send1* or *receive* data. As your program grows, you might end up having too many functions, and it's a good idea to document the intent of each channel to use them properly. Or perhaps you're writing a library and want to expose a channel as read-only to maintain data consistency.

To define the channel's direction, you do it in a similar way when you're reading or receiving data, but you do it when you're declaring them in a function parameter. The syntax to define the type of channel as a parameter in a function is like the following:

```go
chan<- int // it's a channel to only send data
<-chan int // it's a channel to only receive data
```

When you send data through a channel meant to be *receive-only*, you get an error when compiling the program.

Let's use the following program as an example of two functions, one that reads data and another one that sends data, like this:

```go
package main

import "fmt"

func send(ch chan<- string, message string) {
    fmt.Printf("Sending: %#v\n", message)
    ch <- message
}

func read(ch <-chan string) {
    fmt.Printf("Receiving: %#v\n", <-ch)
}

func main() {
    ch := make(chan string, 1)
    send(ch, "Hello World!")
    read(ch)
}
```

When you run the program, you see the following output:

```output
Sending: "Hello World!"
Receiving: "Hello World!"
```

The above program clarifies each channel's intent in every function, meaning that if you try to use a channel to send data in a channel whose purpose is only to receive data, you'll get a compile error. For instance, if you try to do something like this:

```go
func read(ch <-chan string) {
    fmt.Printf("Receiving: %#v\n", <-ch
    ch <- "Bye!"
}
```

When you try to run the program, you see the following error:

```output
# command-line-arguments
./main.go:12:5: invalid operation: ch <- "Bye!" (send to receive-only type <-chan string)
```

It's better to have a compile error than misusing a channel.

## Multiplexing

Finally, let's cover a short topic on how to interact with more than one channel simultaneously by using the `select` keyword. There will be times when you'd like to wait for an event to happen when working with multiple channels. For instance, you might include some logic to abort an operation when there's an anomaly in the data your program is processing.

A `select` statement works like a `switch` statement but for channels, and it blocks the program execution until it receives an event to process. If it gets more than one event, it chooses one at random. An essential aspect of the `select` statement is that it finishes its execution once it processes an event. If you'd like to wait for more events to happen, you might need to use a loop.

Let's use the following program to see `select` in action:

```go
package main

import (
    "fmt"
    "time"
)

func process(ch chan string) {
    time.Sleep(3 * time.Second)
    ch <- "Done processing!"
}

func replicate(ch chan string) {
    time.Sleep(1 * time.Second)
    ch <- "Done replicating!"
}

func main() {
    ch1 := make(chan string)
    ch2 := make(chan string)
    go process(ch1)
    go replicate(ch2)

    for i := 0; i < 2; i++ {
        select {
        case process := <-ch1:
            fmt.Println(process)
        case replicate := <-ch2:
            fmt.Println(replicate)
        }
    }
}
```

When you run the program, you see the following output:

```output
Done replicating!
Done processing!
```

Notice that the `replicate` function finished first; that's why you see its output in the terminal first. The main function has a loop because the `select` statement ends as soon as it receives an event, but we're still waiting for the `process` function to finish.