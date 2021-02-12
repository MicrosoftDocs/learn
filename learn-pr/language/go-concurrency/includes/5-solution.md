## Calculate Fibonacci numbers faster with concurrency

The improved version of the program where you implement concurrency and make it run faster is as follows:

```go
package main

import (
    "fmt"
    "math/rand"
    "time"
)

func fib(number float64, ch chan string) {
    x, y := 1.0, 1.0
    for i := 0; i < int(number); i++ {
        x, y = y, x+y
    }

    r := rand.Intn(3)
    time.Sleep(time.Duration(r) * time.Second)

    ch <- fmt.Sprintf("Fib(%v): %v\n", number, x)
}

func main() {
    start := time.Now()

    size := 15
    ch := make(chan string, size)

    for i := 0; i < size; i++ {
        go fib(float64(i), ch)
    }

    for i := 0; i < size; i++ {
        fmt.Printf(<-ch)
    }

    elapsed := time.Since(start)
    fmt.Printf("Done! It took %v seconds!\n", elapsed.Seconds())
}
```

The second version of the program where you use two unbuffered channels is as follows:

```go
package main

import (
    "fmt"
    "time"
)

var quit = make(chan bool)

func fib(c chan int) {
    x, y := 1, 1

    for {
        select {
            case c <- x:
                x, y = y, x+y
            case <-quit:
                fmt.Println("Done calculating Fibonacci!")
            return
        }
    }
}

func main() {
    start := time.Now()

    command := ""
    data := make(chan int)

    go fib(data)

    for {
        num := <-data
        fmt.Println(num)
        fmt.Scanf("%s", &command)
        if command == "quit" {
            quit <- true
            break
        }
    }

    time.Sleep(1 * time.Second)

    elapsed := time.Since(start)
    fmt.Printf("Done! It took %v seconds!\n", elapsed.Seconds())
}
```
