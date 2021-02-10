We've come to the final module, where we'll write a simple program that uses almost all of the concepts we've seen so far. The idea is to guide you step by step on how to write a program, how to structure the files, how to compile the files, how to run the program, and how to test the program. We haven't covered how to write tests in Go, but we'll use this module to introduce this important topic.

We'll start by writing the core of the program, which will be for an online bank. Users will interact with your program through an API. We'll create two projects in Go to practice how to reference local packages from another program. Finally, to make sure our core program logic always works, we'll create a set of tests that we can run before testing the program manually in the browser.

Like other modules, you'll have to extend the program by solving a challenge that will help you be more confident when writing other Go programs in the future.

## Learning objectives

In this module, you'll practice and learn:

- How testing works in Go.
- How to wrap the core logic of a program into a package.
- How to expose the core logic through a Web API.
- How to write tests for your core logic package (by using test-driven development).
- How almost all concepts we've covered so far can work together.

## Prerequisites

- A Go environment ready to create programs. Ideally, you should have installed and configured Go locally and installed [Visual Studio Code](https://code.visualstudio.com/download) with the [Go extension](https://marketplace.visualstudio.com/items?itemName=golang.Go).
- The ability to create and modify `.go` files.
- The ability to run Go programs by using the terminal prompt.
- Knowledge of basic data types like `string`, `int`, and `boolean`.
- Knowledge of how to write basic data control flows like `if` and `for` statements.
- Knowledge of how to write functions.
- Knowledge of how to create structures and methods.
- Knowledge of how to use libraries like `net/http`.
