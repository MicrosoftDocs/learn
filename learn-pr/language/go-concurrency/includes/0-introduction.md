You might have heard before that Go does an outstanding job for concurrency. Perhaps it is the most prominent feature that has made Go so popular and the choice for writing other software like Docker, Kubernetes, and Terraform. However, before you start learning how concurrency works in Go, you might need to forget what you already know from other programming languages because Go's approach is very different.

At this point, you already have the required knowledge to cover more advanced topics like concurrency. Nonetheless, we'll start by making the case of why concurrency is needed, and we'll introduce different topics little by little. We recommend that you practice all of the sample codes and don't move forward until you feel that you understood the concept very well. Practice, as you've experienced in previous modules, it's what will help you to better understand concepts.

So let's start to explore what you'll learn in this module.

## Learning objectives

In this module, you will learn about:

- How concurrency works in Go
- The difference between concurrency and parallelism
- How communication works in a concurrent program by using channels
- How to write a program that runs faster by implementing concurrency
- How to write dynamic programs that can use buffers to take advantage of concurrency when one to launch a limited number of concurrent calls

## Prerequisites

- A Go environment ready to create applications. Ideally, you should have installed and configured Go locally and [Visual Studio Code](https://code.visualstudio.com/download) with the [Go extension](https://marketplace.visualstudio.com/items?itemName=golang.Go) installed.
- Be able to create and modify `.go` files
- Be able to run Go applications using the terminal prompt
- Have knowledge of basic data types like `string`, `int`, and `boolean`
- Have knowledge of how to write basic data control flows like `if` and `for` statements
- Have knowledge of how to write functions
- Have knowledge of how to use libraries like `net/http`