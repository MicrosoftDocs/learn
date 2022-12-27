Go is a programming language that was developed at Google. It was announced in 2009 as an open-source project by Robert Griesemer, Rob Pike, and Ken Thompson. Since then, Go has been used for developing other well-known technologies like [Docker][DockerWebsite], [Kubernetes][KubernetesWebsite], and [Terraform][TerraformWebsite]. While Go is used heavily in server-side and cloud software, it's a general-purpose language with an abundance of different use cases.

Go is expressive, concise, and clean. It's designed to be idiomatic, which allows programmers to productively write code that is efficient and robust. Programs written in Go can run on Unix systems, such as Linux and macOS, and on Windows. Go is notable in part because of its unique concurrency mechanisms, making it easy to write programs that can take advantage of multiple cores at once. It's primarily a strongly and statically typed language, meaning variable types are known at compile-time. It does, however, have some dynamically typed capabilities.

According to the [TIOBE index][TIOBE], [Go was the programming language of the year][GoAwards] in 2009 and 2016. Although it reached its apex in 2016, Go [maintains a high rating][GoRating]. According to the [annual Stack Overflow Developer Survey][StackSurvey], Go continues as a top-loved language. 

Go has many similarities with C and inherits aspects of C syntax like control-flow statements, basic data types, pointers, and other elements. Both the language's syntax and semantics go beyond C, though. It also draws similarities to Java, C#, Python, and more. In general, Go tends to borrow and adapt features from other programming languages, while shedding most of the complexity. For example, you can use some object-oriented (OO) programming features and design patterns in Go, but the full OO paradigm isn't fully implemented. You'll learn why later in this Learning path.

## Go principles

Here are the underlying principle benefits of the Go programming language:

- The Go license is 100% open source.
- Go programs compile to a single self-contained binary, making it easy to share and distribute.
- Go supports cross-compiling to a variety of platforms and operating systems.
- Go strives to keep the language small and simple, and to do more in fewer lines of code.
- Concurrency is a first-class citizen, and enables any function to be run as a lightweight thread with little programmer effort.
- Go provides automatic memory management including garbage collection.
- Compilation and execution are fast.
- Go requires that all code be used, or else an error is thrown.
- There's official formatting that helps to maintain consistency across projects.
- Go has a large and comprehensive standard library, and many applications can be built without third-party dependencies.
- Go guarantees language backward compatibility with past releases.


## Go use cases

- Systems level applications
- Web applications
- Cloud-native applications
- Utilities and command line tools
- Distributed systems
- Database implementations

<!-- Links -->
[GoAwards]: https://insights.dice.com/2017/01/10/go-tiobe-programming-language-2016/?azure-portal=true
[GoRating]: https://www.tiobe.com/tiobe-index/go/?azure-portal=true
[StackSurvey]: https://insights.stackoverflow.com/survey/2020#most-loved-dreaded-and-wanted?azure-portal=true
[TIOBE]: https://www.tiobe.com/tiobe-index/?azure-portal=true
[DockerWebsite]: https://www.docker.com/?azure-portal=true
[KubernetesWebsite]: https://kubernetes.io/?azure-portal=true
[TerraformWebsite]:https://www.terraform.io/?azure-portal=true
