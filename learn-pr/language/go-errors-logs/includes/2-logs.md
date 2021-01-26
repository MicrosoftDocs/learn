Logs play a significant role in our programs as they become the source of information we can check when something goes wrong. Usually, when an error happens, end users simply see a message indicating a problem with the program. However, from a developer's perspective, we need more information than a simple error message. Mainly because we would like to reproduce the problem to write the proper fix. In this module, you'll learn how logging works in Go, along with a few practices you should always implement.

## The log package

For starters, Go offers a simple standard package to work with logs that you can use similarly as you do with the `fmt` package. The standard package doesn't provide log levels and doesn't let you configure separate loggers for each package. If you need to write more complex logging configurations, we'll cover how you can do it by using a logging framework – more on this later.

So, the simplest way that you could use logs is like this:

```go
import (
    "log"
)

func main() {
    log.Print("Hey, I'm a log!")
}
```

When you run the preceding code, you get the following output:

```output
2020/12/19 13:39:17 Logging in Go!
```

By default, the `log.Print()` function includes the date and time as the log message's prefix. And even though you could get the same behavior using `fmt.Print()`, you could do other things like sending logs to a file – more on this later.

You could use the `log.Fatal()` function to log an error and terminate the program as if you'd write `os.Exit(1)`. To give it a try, let's use the following code snippet:

```go
package main

import (
    "fmt"
    "log"
)

func main() {
    log.Fatal("Hey, I'm an error log!")
    fmt.Print("Can you see me?")
}
```

When you run the preceding code, you get the following output:

```output
2020/12/19 13:53:19  Hey, I'm an error log!
exit status 1
```

Notice how the last line `fmt.Print("Can you see me?")` isn't executed because the `log.Fatal()` function call makes the program terminate. You have a similar behavior when you use the `log.Panic()` function, which in addition to calls the `panic()` function, like this:

```go
package main

import (
    "fmt"
    "log"
)

func main() {
    log.Panic("Hey, I'm an error log!")
    fmt.Print("Can you see me?")
}
```

When you run the preceding code, you get the following output:

```output
2020/12/19 13:53:19  Hey, I'm an error log!
panic: Hey, I'm an error log!

goroutine 1 [running]:
log.Panic(0xc000060f58, 0x1, 0x1)
        /usr/local/Cellar/go/1.15.5/libexec/src/log/log.go:351 +0xae
main.main()
        /Users/christian/go/src/helloworld/logs.go:9 +0x65
exit status 2
```

Notice how you're still getting the log message, but also the error stack trace.

Another essential function is the `log.SetPrefix()` that you can use to add a prefix to your program's log messages. For instance, you could use the following code snippet:

```go
package main

import (
    "log"
)

func main() {
    log.SetPrefix("main(): ")
    log.Print("Hey, I'm a log!")
    log.Fatal("Hey, I'm an error log!")
}
```

When you run the preceding code, you get the following output:

```output
main(): 2021/01/05 13:59:58 Hey, I'm a log!
main(): 2021/01/05 13:59:58 Hey, I'm an error log!
exit status 1
```

Notice how this becomes useful because you set the prefix once, and your logs include information like the name of the function where the log originated from.

You could explore [other functions from the official docs site](https://golang.org/pkg/log/).

## Logging to a file

Besides printing out logs to the console, you might want to send logs to a file so that you can process them later or in real time.

Why would you want to send logs to a file? First, you might want to hide specific information from your end users. Either because they won't be interested or you might be exposing sensitive information. When you have logs in files, you could then centralize all logs into a single location and correlate logs with other events. This is a typical pattern now that's common to have distributed applications that can be ephemeral, like containers.

So, let's use the following code to test sending logs to a file:

```go
package main

import (
    "log"
    "os"
)

func main() {
    file, err := os.OpenFile("info.log", os.O_CREATE|os.O_APPEND|os.O_WRONLY, 0644)
    if err != nil {
        log.Fatal(err)
    }

    defer file.Close()

    log.SetOutput(file)
    log.Print("Hey, I'm a log!")
}
```

When you run the above code, you don't see anything in the console. However, if you check your directory, you should see a new file called `info.log` with the logs you sent out with the `log.Print()` function. Notice that you need to start by creating or opening a file and then configuring the log package to send all the output to a file. You can then continue using the `log.Print()` function as you'd typically do.

## Logging frameworks

Lastly, there might be times when the log package's functions are not enough, and therefore, you might find useful a framework logging instead of writing your own libraries. For instance, a few logging frameworks in Go are [Logrus](https://github.com/sirupsen/logrus), [Zerolog](https://github.com/rs/zerolog), [Zap](https://github.com/uber-go/zap), or [Apex](https://github.com/apex/log).

Let's explore what we can do with Zerolog.

First, you need to install the package. If you've followed all the guides, you're probably using Go modules already, so you don't need to do anything. However, just in case, you could run the following command in your workstation to install the Zerolog libraries:

```
go get -u github.com/rs/zerolog/log
```

Then, use the following code snippet to give it a try:

```go
package main

import (
    "github.com/rs/zerolog"
    "github.com/rs/zerolog/log"
)

func main() {
    zerolog.TimeFieldFormat = zerolog.TimeFormatUnix
    log.Print("Hey! I'm a log message!")
}
```

When you run the preceding code, you get the following output:

```output
{"level":"debug","time":1609855453,"message":"Hey! I'm a log message!"}
```

Notice how you simply had to include the proper import names, and then you could continue using the `log.Print()` function as you'd typically do. Also, notice how the output changes to a JSON format, which with regard to logs it's a useful format when you perform searches in a centralized location.

Another useful feature is that you can include context data very quickly, like this:

```go
package main

import (
    "github.com/rs/zerolog"
    "github.com/rs/zerolog/log"
)

func main() {
    zerolog.TimeFieldFormat = zerolog.TimeFormatUnix

    log.Debug().
        Int("EmployeeID", 1001).
        Msg("Getting employee information")

    log.Debug().
        Str("Name", "John").
        Send()
}
```

When you run the preceding code, you get the following output:

```output
{"level":"debug","EmployeeID":1001,"time":1609855731,"message":"Getting employee information"}
{"level":"debug","Name":"John","time":1609855731}
```

Notice how we added as a context the employee ID, and it becomes part of the logline as another property. Also, it's important to highlight that the fields you include are strongly typed.

You can implement other features with Zerolog like logging levels, format stack traces, use more than one logger instance to manage different outputs, among other things that you could [check in their GitHub site](https://github.com/rs/zerolog).
