Logs play a significant role in a program because they become a source of information that you can check when something goes wrong. Usually, when an error happens, end users just see a message that indicates a problem with the program. From a developer's perspective, we need more information than a simple error message. That's mainly because we want to reproduce the problem to write a proper fix. In this module, you'll learn how logging works in Go. You'll also learn a few practices that you should always implement.

## The `log` package

For starters, Go offers a simple standard package for working with logs. You can use it in a way that's like how you use the `fmt` package. The standard package doesn't provide log levels and doesn't let you configure separate loggers for each package. If you need to write more complex logging configurations, you can do it by using a logging framework. We'll cover logging frameworks later.

Here's the easiest way to use logs:

```go
import (
    "log"
)

func main() {
    log.Print("Hey, I'm a log!")
}
```

When you run the preceding code, you get this output:

```output
2020/12/19 13:39:17 Logging in Go!
```

By default, the `log.Print()` function includes the date and time as the log message's prefix. You could get the same behavior by using `fmt.Print()`, but you can do other things with the `log` package, like sending logs to a file. We'll look at more `log` package functionality later.

You can use the `log.Fatal()` function to log an error and end the program as if you'd used `os.Exit(1)`. To give it a try, let's use this code snippet:

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

When you run the preceding code, you get this output:

```output
2020/12/19 13:53:19  Hey, I'm an error log!
exit status 1
```

Notice how the last line, `fmt.Print("Can you see me?")`, doesn't run. That's because the `log.Fatal()` function call stops the program. You get similar behavior when you use the `log.Panic()` function, which also calls the `panic()` function, like this:

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

When you run the preceding code, you get this output:

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

You're still getting the log message, but now you also get the error stack trace.

Another essential function is `log.SetPrefix()`. You can use it to add a prefix to your program's log messages. For example, you could use this code snippet:

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

When you run the preceding code, you get this output:

```output
main(): 2021/01/05 13:59:58 Hey, I'm a log!
main(): 2021/01/05 13:59:58 Hey, I'm an error log!
exit status 1
```

You set the prefix once, and your logs will include information like the name of the function from which the log came.

You can explore [other functions on the Go website](https://golang.org/pkg/log/).

## Logging to a file

Besides printing logs to the console, you might want to send logs to a file so you can process them later or in real time.

Why would you want to send logs to a file? First, you might want to hide specific information from your end users. They might not be interested, or you might be exposing sensitive information. When you have logs in files, you can then centralize all logs to a single location and correlate them with other events. This pattern is typical: to have distributed applications that can be ephemeral, like containers.

Let's use the following code to test sending logs to a file:

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

When you run the preceding code, you don't see anything in the console. In your directory, you should see a new file called info.log that contains the logs that you sent by using the `log.Print()` function. Notice that you need to start by creating or opening a file and then configuring the `log` package to send all the output to a file. You can then continue using the `log.Print()` function as you typically would.

## Logging frameworks

Finally, there might be times when the `log` package's functions aren't enough. You might find it helpful to use a logging framework instead of writing your own libraries. A few logging frameworks for Go are [Logrus](https://github.com/sirupsen/logrus), [zerolog](https://github.com/rs/zerolog), [zap](https://github.com/uber-go/zap), and [Apex](https://github.com/apex/log).

Let's explore what we can do with zerolog.

First, you need to install the package. If you've been working in this series, you're probably using Go modules already, so you don't need to do anything. Just in case, you could run this command on your workstation to install the zerolog libraries:

```
go get -u github.com/rs/zerolog/log
```

Now, use this code snippet to give it a try:

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

When you run the preceding code, you get this output:

```output
{"level":"debug","time":1609855453,"message":"Hey! I'm a log message!"}
```

Notice how you just have to include the correct import names and then you can continue using the `log.Print()` function as you typically do. Also, notice how the output changes to JSON format. JSON is a useful format for logs when you run searches in a centralized location.

Another useful feature is that you can include context data quickly, like this:

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

When you run the preceding code, you get this output:

```output
{"level":"debug","EmployeeID":1001,"time":1609855731,"message":"Getting employee information"}
{"level":"debug","Name":"John","time":1609855731}
```

Notice how we added as a context the employee ID. It becomes part of the logline as another property. Also, it's important to highlight that the fields you include are strongly typed.

You can implement other features with zerolog, like using leveled logging, using formatted stack traces, and using more than one logger instance to manage different outputs. For more information, see the [GitHub site](https://github.com/rs/zerolog).
