Go is a programming language that was developed at Google and announced in 2009 as an open-source project by Robert Griesemer, Rob Pike, and Ken Thompson. Since then, Go has been used for developing other well-known technologies, such as Docker, Kubernetes, Terraform, and others. But Go is a general-purpose language too. The goal of the language is to allow programmers to be expressive, efficient, and effective when writing reliable and robust code.

According to the [TIOBE index](https://www.tiobe.com/tiobe-index/), [Go was the programming language of the year](https://insights.dice.com/2017/01/10/go-tiobe-programming-language-2016/) in 2009 and 2016. Although it reached its tipping point in 2016, Go [maintains a high rating](https://www.tiobe.com/tiobe-index/go/). And since 2015, according to the [annual Stack Overflow Developer Survey](https://insights.stackoverflow.com/survey/2020#most-loved-dreaded-and-wanted), Go has also been rated as one of the top loved languages. 

Go has many similarities with C, inheriting many aspects of C syntax, control-flow statements, basic data types, pointers, and other elements. However, Go is more than an up-to-date version of C. It borrows and adapts ideas from other programming languages, while removing any unnecessarily complex features. For instance, some portions of the object-oriented programming paradigm aren't implemented as fully in Go. You'll learn why in some of the upcoming modules.

Go is very idiomatic in topics such as source code formats, disallowing unused code, not requiring an IDE, preferring standard libraries over frameworks, and offering a different approach to concurrent programming and error handling.

Go runs on Unix systems, such as Linux and macOS, and it supports Windows as well.

## Go principles

To understand why some things in Go are the way they are, it's worthwhile to understand the principles behind this programming language:

- Go strives to keep things small and simple, to do more in fewer lines of code.
- Concurrency is a first citizen, and functions can run as lightweight threads.
- Compilation and execution are fast, with the aim to be as fast as C.
- Go requires casting to be explicit, or else it throws a compilation error.
- Unused code is not a warning, but an error, and the code won't compile.
- There's an official formatting that helps to maintain consistency across projects.
- Go isn't a good friend of frameworks, because it prefers to use standard libraries.
- Go guarantees backward compatibility.
- The Go license is completely open source.