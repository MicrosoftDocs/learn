There are times when the programs you write don't behave the way you expected. Sometimes, there are external factors that you can't control, like other processes blocking a file or even accessing a memory address that's not available anymore. Failures are simply another type of behavior that your programs can have. It's better if you anticipate those failures to troubleshoot problems when they happen.

As you've already learned, Go's approach for exception handling is different, and so is its process for error handling. In Go, a function that could fail should always return an additional value so that you can anticipate and manage a failure successfully. For example, you could run a default behavior and log as much information as possible to reproduce the problem and fix it.

In this module, you'll learn Go's approach to logging and error handling.

## Learning objectives

In this module, you'll learn about:

- Go's approach to error handling.
- Error handling strategies.
- The `log` standard package for logging.
- Logging frameworks.

## Prerequisites

- A Go environment that's ready to create applications. Ideally, you should have installed and configured Go locally and installed [Visual Studio Code](https://code.visualstudio.com/download) with the [Go extension](https://marketplace.visualstudio.com/items?itemName=golang.Go).
- Ability to create and modify `.go` files.
- Ability to run Go applications by using the terminal prompt.
- Knowledge of basic data types like `string`, `int`, and `boolean`.
- Knowledge of how to write basic data control flows like `if` and `for` statements.
- Knowledge of how to write functions that have multiple return values.
