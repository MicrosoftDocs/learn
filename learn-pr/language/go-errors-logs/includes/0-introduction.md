There are times when the programs you write don't behave the way you expected. Sometimes, there are external factors that you can't control, like other processes blocking a file or even accessing a memory address that's not available anymore. Failures are simply another type of behavior that your programs can have, and it's better if you anticipate those failures to troubleshoot problems when they happen.

As you've already learned, Go's approach for exception handling is different, and so is the process for error handling. In Go, a function that could fail should always return an additional value so that you can anticipate and manage a failure successfully. For instance, you could execute a default behavior and log as much information as possible to reproduce the problem and fix it.

In this module, you'll learn Go's approach to logging and error handling.

## Learning objectives

In this module, you will learn about:

- Go's approach for error handling
- Error handling strategies
- The `log` standard package for logging
- Logging frameworks

## Prerequisites

- A Go environment ready to create applications. Ideally, you should have installed and configured Go locally and [Visual Studio Code](https://code.visualstudio.com/download) with the [Go extension](https://marketplace.visualstudio.com/items?itemName=golang.Go) installed.
- Be able to create and modify `.go` files
- Be able to run Go applications using the terminal prompt
- Have knowledge of basic data types like `string`, `int`, and `boolean`
- Have knowledge of how to write basic data control flows like `if` and `for` statements
- Have knowledge of how to write functions with multiple return values
