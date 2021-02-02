Concurrency is the composition of independent activities, like the work that a web server does when it deals with multiple user requests simultaneously but in an autonomous way. Concurrency is present in many programs today. Web servers are one example, but you also see the need for concurrency in processing significant amounts of data in batches.

Go has two styles for writing concurrent programs. One is the traditional one you might have used in other languages with threads. In this module, you'll learn about Go's style, where values are passed between independent activities known as goroutines to communicate processes.

If this is your first time learning about concurrency, we encourage you to spend some extra time reviewing each piece of code we'll write to practice.

## Go's approach to concurrency

Typically, the biggest problem in writing concurrent programs is sharing data between processes. Go takes a different approach from other programming languages with communication, because Go passes data back and forth through channels. This means that only one activity (goroutine) has access to the data, and there's no race condition by design. As you learn about goroutines and channels in this module, you'll better understand Go's concurrency approach.

Go's approach can be summarized in the following slogan: *"Do not communicate by sharing memory; instead, share memory by communicating."* You can learn more about it in [the post from the Go blog about sharing memory by communicating], but we'll continue talking about this in the following sections.

As we said before, Go includes low-level concurrency primitives as well. But we'll cover only the idiomatic way of Go for concurrency in this module.

Let's start by exploring goroutines.

## Goroutines

A goroutine is a concurrent activity, a lightweight thread, not the traditional one you have in an operating system. Let's suppose that you have a program that writes to the output and another function that calculates things like adding two numbers. A concurrent program can have several goroutines calling both functions at the same time.

We can say that the first goroutine that a program executes is the `main()` function. If you want to create another goroutine, you have to use the `go` keyword before calling the function, like this:

```go
func main(){
    login()
    go launch()
}
```

Alternatively, you'll find that many programs like to use anonymous functions to create goroutines, like this:

```go
func main(){
    login()
    go func() {
        launch()
    }()
}
```

To see this in action, let's write a simple concurrent program.

## Write a concurrent program

Because we want to focus only on the concurrent part, let's use an existing program that checks if an API endpoint is responding or not. Here's the code:

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

    for _, api := range apis {
        _, err := http.Get(api)
        if err != nil {
            fmt.Printf("ERROR: %s is down!\n", api)
            continue
        }

        fmt.Printf("SUCCESS: %s is up and running!\n", api)
    }

    elapsed := time.Since(start)
    fmt.Printf("Done! It took %v seconds!\n", elapsed.Seconds())
}
```

When you run the preceding code, you get the following output:

```output
SUCCESS: https://management.azure.com is up and running!
SUCCESS: https://dev.azure.com is up and running!
SUCCESS: https://api.github.com is up and running!
SUCCESS: https://outlook.office.com/ is up and running!
ERROR: https://api.somewhereintheinternet.com/ is down!
SUCCESS: https://graph.microsoft.com is up and running!
Done! It took 1.658436834 seconds!
```

Nothing is out of the ordinary here, but we can do better. Perhaps we can check all sites at the same time? Instead of taking almost two seconds, the program could finish in less than 500 ms. 

Notice that the portion of code we need to run concurrently is the one that makes the HTTP call to the site. In other words, we need to create a goroutine for each API that the program is checking. 

To create a goroutine, we need to use the `go` keyword before calling a function. But we don't have a function there. Let's refactor that code and create a new function, like this:

```go
func checkAPI(api string) {
    _, err := http.Get(api)
    if err != nil {
        fmt.Printf("ERROR: %s is down!\n", api)
        return
    }

    fmt.Printf("SUCCESS: %s is up and running!\n", api)
}
```

Notice that we don't need the `continue` keyword anymore because we're not in a for loop. To stop the execution flow of the function, we simply use the `return` keyword. Now, we need to modify the code in the `main()` function to create a goroutine per API, like this:

```go
for _, api := range apis {
    go checkAPI(api)
}
```

Rerun the program, and see what happens.

It looks like the program is not checking the APIs anymore, right? You might see output like the following:

```output
Done! It took 1.506e-05 seconds!
```

That was fast! What happened? Notice that you see the final message saying that the program has finished. That's because Go created a goroutine for each site within the loop, and it went immediately to the next line. 

Even though it doesn't look like the `checkAPI` function is running, it's running. It just didn't have time to finish. Notice what happens if you include a sleep timer right after the loop, like this:

```go
for _, api := range apis {
    go checkAPI(api)
}

time.Sleep(3 * time.Second)
```

Now when you rerun the program, you might see an output like this:

```output
ERROR: https://api.somewhereintheinternet.com/ is down!
SUCCESS: https://api.github.com is up and running!
SUCCESS: https://management.azure.com is up and running!
SUCCESS: https://dev.azure.com is up and running!
SUCCESS: https://outlook.office.com/ is up and running!
SUCCESS: https://graph.microsoft.com is up and running!
Done! It took 3.002114573 seconds!
```

It looks like it's working, right? Well, not precisely. What if you want to add a new site to the list? Perhaps three seconds aren't enough. How would you know? You can't. There has to be a better way, and that's what we'll discuss in the next section when we talk about channels.
