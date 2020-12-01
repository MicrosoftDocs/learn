Go is a programming language developed at Google, announced in 2009 as an open-source project by Robert Griesemer, Rob Pike, and Ken Thompson. Since then, Go has been used for developing other very known technologies like Docker, Kubernetes, Terraform, and others. But Go, it’s a general-purpose language too. The goals of the language were to be expressive, efficient, and effective when writing reliable and robust code.

According to the [TIOBE index](https://www.tiobe.com/tiobe-index/), in 2009 and [2016 Go was the programming language of the year](https://insights.dice.com/2017/01/10/go-tiobe-programming-language-2016/). And although it reached its tipping point that year, Go has [maintained a sustained rating over the years](https://www.tiobe.com/tiobe-index/go/). Since 2015, Go has also been rated as one of the top loved languages according to the [annual Stack Overflow Developer Survey](https://insights.stackoverflow.com/survey/2020#most-loved-dreaded-and-wanted)

Go has many similarities with C inheriting many aspects of the C’s syntax, control-flow statements, basic data types, pointers, and others. However, Go it’s more than an up to date version of C. It borrows and adapts ideas from other programming languages, and removes any unnecessary features that could bring complexity to the language. For instance, some portions of the object oriented programming paradigm are not implemented as fully in Go, and you’ll learn why in some of the upcoming modules.

Go is very idiomatic in very different topics like source code formats, not allowing unused code, not requiring an IDE, preferring to use standard libraries than frameworks, and offering a different approach for concurrent programming and error handling.

Go runs on Unix systems like Linux and macOS, and Windows is supported as well.

## Go Principles

To understand why some things in Go are they way they are, it’s worth to understand what are the principles behind this programming language:

- Go strives to keep things small and simple, or do more in only a few lines of code
- Concurrency is a first citizen, functions can run as lightweight threads
- Compilation and execution is fast, the aim is to be as fast as C
- Requires casting to be explicit, otherwise it throws a compilation error
- Unused code is not a warning, but an error (won’t compile)
- There’s an official formatting that helps to maintain consistency across projects
- Go is not a good friend of frameworks as it prefers the usage of standard libraries
- Guarantee backwards compatibility
- Go’s license is completely open source
