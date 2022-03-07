You might have heard that Go does an outstanding job for concurrency. Perhaps it's the most prominent feature that has made Go so popular and the choice for writing other software like Docker, Kubernetes, and Terraform. 

Before you start learning about how concurrency works in Go, you might need to forget what you already know from other programming languages. Go's approach is very different.

At this point, you already have the required knowledge to cover more advanced topics like concurrency. Nonetheless, we'll start by making the case of why concurrency is needed. We'll introduce different topics little by little. 

We recommend that you practice all of the sample codes and don't move forward until you understand the concepts very well. As you've experienced in previous modules, practice is what will help you to better understand concepts.

Let's start to explore what you'll learn in this module.

## Learning objectives

In this module, you'll learn about:

- How concurrency works in Go.
- The difference between concurrency and parallelism.
- How communication works in a concurrent program by using channels.
- How to write a program that runs faster by implementing concurrency.
- How to write dynamic programs that can use buffers to take advantage of concurrency when you want to launch a limited number of concurrent calls.

## Prerequisites

- A Go environment that's ready to create applications. Ideally, you should have installed and configured Go locally and installed [Visual Studio Code](https://code.visualstudio.com/download) with the [Go extension](https://marketplace.visualstudio.com/items?itemName=golang.Go).
- The ability to create and modify `.go` files.
- The ability to run Go applications by using the terminal prompt.
- Knowledge of basic data types like `string`, `int`, and `boolean`.
- Knowledge of how to write basic data control flows like `if` and `for` statements.
- Knowledge of how to write functions.
- Knowledge of how to use libraries like `net/http`.