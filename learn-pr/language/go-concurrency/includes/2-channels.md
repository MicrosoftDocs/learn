A channel in Go is a communication mechanism between goroutines, and this is why we said before that Go's approach for concurrency is: **"Do not communicate by sharing memory; instead, share memory by communicating."** So when you need to send a value from one goroutine to another, you use channels. Let's see how they work and how you can start using them to write concurrent Go programs.

## Channels syntax

Because a channel is a communication mechanism that sends and receives data, they also have a type, which means that you can only send data for the kind that the channel supports. You use the keyword `chan` as the data type for a channel, but you also need to specify the data type that will pass through the channel, like an `int` type.

Every time you declare a channel or want to specify a channel as a parameter in a function, you need to use `chan <type>`, like `chan int`. And, to create a channel, you use the built-in `make()` function, like this:

```go
ch := make(chan int)
```

A channel can do two operations: *send* and *receive* data, and to specify the type of operation a channel has, you need to use the channel operator `<-`. Additionally, **sending and receiving data in channels are blocking operations**–you'll see in a moment why. When you want to say that a channel only sends data, you have to use the `<-` operator after the channel, and when you want the channel to receive data, you have to use the `<-` operator before the channel, like this:

```go
ch <- x // sends (or write) x through channel ch
x = <-ch // x receives (or reads) data sent to the channel ch
<-ch // receives data, but the result is discarded
```

Another operation that you could use in a channel is to close it. To close a channel, you use the built-in `close()` function, like this:

```go
close(ch)
```

When you close a channel, you're saying that data will not be sent in that channel again. If you try to send data to a closed channel, the program will panic. And if you try to receive data from a closed channel, you'll be able to read all data sent, and every subsequent "read" will return a zero value.

Let's go back to the program we created before, and let's use channels to remove the sleep functionality and clean it a little bit. First, let's create a string channel in the `main` function, like this:

```go
ch := make(chan string)
```

And let's remove the sleep line `time.Sleep(3 * time.Second)`.

Now, we can use channels to communicate between goroutines, so let's refactor our code, and instead of printing out the result in the `checkAPI` function, send that message over the channel. But to use the channel from that function, you need to add the channel as the parameter. The `checkAPI` function should look like this:

```go
func checkAPI(api string, ch chan string) {
    _, err := http.Get(api)
    if err != nil {
        ch <- fmt.Sprintf("ERROR: %s is down!\n", api)
        return
    }

    ch <- fmt.Sprintf("SUCCESS: %s is up and running!\n", api)
}
```

Notice that we have to use the `fmt.Sprintf` function because we don't want to print out any text from there. Simply send a formatted text. Also, notice that we're using the `<-` operator after the channel variable to send data.

Now, you need to change the `main` function as well to send the channel variable and receive the data to print it out, like this:

```go
ch := make(chan string)

for _, api := range apis {
    go checkAPI(api, ch)
}

fmt.Print(<-ch)
```

Notice how we're using the `<-` operator before the channel says that we want to read data from the channel.

When you re-run the program, you see an output like this one:

```output
ERROR: https://api.somewhereintheinternet.com/ is down!

Done! It took 0.007401217 seconds!
```

Well, at least it's working without a call to a sleep function, right? But it's still not doing what we want to because we're seeing the output only from one of the goroutines, and we created five. Let's see why this program it's working this way in the next section.

## Unbuffered channels

When you create a channel using the `make()` function, you create an unbuffered channel, which is the default behavior. Unbuffered channels block the sending operation until there's someone ready to receive the data. This is why we said before that sending and receiving are blocking operations. This is also why the program from the previous section stopped as soon as it received the first message.

We can start by saying that the `fmt.Print(<-ch)` blocks the program because it's reading from a channel, and it's waiting for some data to arrive. As soon as it got something, it continues with the next line, and the program finishes. What happened to the rest of the goroutines? They're still running, but no one is listening anymore, and because the program finished early, some goroutines couldn't send data. To prove this point, let's add another `fmt.Print(<-ch)`, like this:

```go
ch := make(chan string)

for _, api := range apis {
    go checkAPI(api, ch)
}

fmt.Print(<-ch)
fmt.Print(<-ch)
```

When you re-run the program, you see an output like this one:

```output
ERROR: https://api.somewhereintheinternet.com/ is down!
SUCCESS: https://api.github.com is up and running!
Done! It took 0.263611711 seconds!
```

Notice that now you see the output for two APIs, and if you continue adding more `fmt.Print(<-ch)` you'll end up reading all the data that it's being sent to the channel. But what happens if you try to read more data and no one is sending data anymore, something like this:

```go
ch := make(chan string)

for _, api := range apis {
    go checkAPI(api, ch)
}

fmt.Print(<-ch)
fmt.Print(<-ch)
fmt.Print(<-ch)
fmt.Print(<-ch)
fmt.Print(<-ch)
fmt.Print(<-ch)

fmt.Print(<-ch)
```

When you re-run the program, you see an output like this one:

```output
ERROR: https://api.somewhereintheinternet.com/ is down!
SUCCESS: https://api.github.com is up and running!
SUCCESS: https://management.azure.com is up and running!
SUCCESS: https://graph.microsoft.com is up and running!
SUCCESS: https://outlook.office.com/ is up and running!
SUCCESS: https://dev.azure.com is up and running!
```

It's working, but the program doesn't finish because the last print line it's blocking it as it's expecting to receive data. You'll have to close the program with a command like `Ctrl+C`. This simply proofs that reading and receiving data are blocking operations. To fix this problem, you might simply change the code for a loop and receive only the data you're sure you're sending, like this:

```go
for i := 0; i < len(apis); i++ {
    fmt.Print(<-ch)
}
```

Here's the final version of the program in case something went wrong with your version:

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

    ch := make(chan string)

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

When you re-run the program, you see an output like this one:

```output
ERROR: https://api.somewhereintheinternet.com/ is down!
SUCCESS: https://api.github.com is up and running!
SUCCESS: https://management.azure.com is up and running!
SUCCESS: https://dev.azure.com is up and running!
SUCCESS: https://graph.microsoft.com is up and running!
SUCCESS: https://outlook.office.com/ is up and running!
Done! It took 0.602099714 seconds!
```

The program is doing what it's supposed to do, and you're not using a sleep function anymore, but you're using channels. Notice also how it takes around 600ms to finish instead of almost 2 seconds when weren't using concurrency.

Finally, we could say that unbuffered channels are synchronizing the sending and receiving operations. Even though you're using concurrency, the communication is **synchronous**.