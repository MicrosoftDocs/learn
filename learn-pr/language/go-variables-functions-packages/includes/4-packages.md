Packages in Go are like libraries or modules in other programming languages. You can pack your code and reuse it somewhere else. The source code of a package can be distributed in more than one `.go` files. So far, we've been writing the `main` package and have made a few references to other native packages.

In this section, you'll not only learn what a package is, but you'll also learn how to create one and how to consume external packages.

## Main package

As you might have noticed, even the most straightforward program in Go has to be part of a package. Usually, the default one is the `main` package, the one we've been using so far. If a program is part of the `main` package, Go generates a binary file, and when it runs, it calls the `main()` function.

In other words, the `main` package means that your program will produce a standalone executable. **Whereas, when a program is part of a different package than `main`, then Go doesn't generate a binary file but a package archive file (.a extension).**

By convention, the package name is the same as the last element of the import path. For instance, to import the `math/rand` package, you'll need to import it like this:

```go
import "math/rand"
```

And to refer to objects inside the package, you'll have to do it like this:

```go
rand.Int()
```

Let's go deeper into this topic by creating a package.

## Create a package

Create a new directory in the `$GOPATH/src` directory called `calculator`, and create a new file called `sum.go`. The tree directory should look like this:

```output
src/
  calculator/
    sum.go
```

Initialize the `sum.go` file with the name of the package:

```go
package calculator
```

Then, you can start writing the functions and variables for the package. Unlike other programming languages, Go doesn't provide the `public` or `private` keywords to indicate if a variable or function can be called outside or inside of the package. However, Go follows two simple rules:

- If you want something to be **private**, start its name with a **lower case letter**
- If you want something to be **public**, start its name with an **upper case letter**

So let's add the following code to the calculator package we're creating:

```go
package calculator

var logMessage = "[LOG]"

// Version of the calculator
var Version = "1.0"

func internalSum(number int) int {
    return number - 1
}

// Sum two integer numbers
func Sum(number1, number2 int) int {
    return number1 + number2
}
```

From the above code, let's highlight a few things:

- The `logMessage` variable can be called only within the package
- The `Version` variable can be reached from anywhere, and it's recommended that you include a comment to describe the purpose of this variable (useful for who's using this package)
- The `internalSum` function can be called only within the package
- The `Sum` function can be reached from anywhere, and it's recommended that you include a comment to describe the purpose of this variable (useful for who's using this package)

To confirm that everything is working, you can run the `go build` command in the `calculator` directory. If you do it, notice that it doesn't generate an executable binary.

## Creating a module

You've grouped the calculator functionality into a `package`, now it's time to group the package into a `module`. Why? Your package's module is the one in charge of specifying the context that Go needs to run the code you've grouped together, including the Go version your code is written for.

Additionally, modules help other developers to reference specific versions of your code and make working with dependencies less painful. Another benefit is that **our program's source code doesn't strictly need to exist in the `$GOPATH/src` directory**, making it more convenient to work with different package versions in other projects at the same time.

So, to create a module for the `calculator` package, run the following command in the root directory (`$GOPATH/src/calculator`):

```output
go mod init github.com/myuser/calculator
```

From the above command, the `github.com/myuser/calculator` becomes now the package's name, and this is how you'll reference it in other programs. Additionally, the above command creates a new file `go.mod`, and the tree directory now looks like this:

```output
src/
  calculator/
    go.mod
    sum.go
```

And the content of the `go.mod` file should look like this (Go version might be different):

```output
module github.com/myuser/calculator

go 1.14
```

To reference this package in other programs, you need to import it under the module name, and in this case, it is `github.com/myuser/calculator`. Let's see an example of how to use this package in the following section.

> [!NOTE]
> Historically, managing dependencies in Go hasn't been easy, and it's still a work in progress. If you want to learn more about modules, you can check the [series of posts published in the Go's blog](https://blog.golang.org/using-go-modules).

## Referencing local packages (modules)

Once you've created the package, it's time to use it. Let's continue using the sample application we've been using, but this time instead of having the `sum` function in the `main` package, let's use the one we created before in the `calculator` package.

The tree file structure now should look like this:

```output
src/
  calculator/
    go.mod
    sum.go
  helloworld/
    main.go
```

Let's use the following code for the `$GOPATH/src/helloword/main.go` file:

```go
package main

import "github.com/myuser/calculator"

func main() {
    total := calculator.Sum(3, 5)
    println(total)
    println("Version: ", calculator.Version)
}
```

Notice that the import has the name of the package you created, `calculator`. Additionally, to call the `Sum` function from that package, you need to specify the package name like this `calculator.Sum`. Lastly, you now also have access to the `Version` variable as it follows the convention name to be exported, and you call it like this `calculator.Version`.

If you try to run the program now, it won't work. You need to tell Go that you're using modules to reference other packages. To do so, run the following command in the `$GOPATH/src/helloworld` directory:

```output
go mod init helloworld
```

In this case, `helloworld` from the above command is the name of the project. Also, this command creates a new file `go.mod`, so now the tree directory looks like this:

```output
src/
  calculator/
    go.mod
    sum.go
  helloworld/
    go.mod
    main.go
```

When you open the `go.mod` file, you should see something like this (Go version might be different):

```output
module helloworld

go 1.14
```

Because you're referencing a local copy of the module, you need to tell Go that you don't want to use a remote location. So you need to modify the `go.mod` manually and include the reference manually, like this:

```output
module helloworld

go 1.14

require github.com/myuser/calculator v0.0.0

replace github.com/myuser/calculator => ../calculator
```

The `replace` keyword says that instead of using a remote location of the module, use a local directory. In this case, because the `helloworld` and `calculator` programs live in `$GOPATH/src`, the location is simply `../calculator`. If the module's source is in a different location, here's where you define the local path.

You should be able to run the program using this command:

```output
go run main.go
```

And the output should be:

```output
8
Version:  1.0
```

### Challenge 1:

What happens if you try to call the `logMessage` variable or the `internalSum` function from the `calculator` package in the main application? Does it run? Give it a try!

> **Challenge solution**:
>```go
>package main
>
>import "github.com/myuser/calculator"
>
> func main() {
>     total := calculator.internalSum(5)
>     println(total)
>     println("Version: ", calculator.logMessage)
> }
> ```

### Publishing a package

[Publishing a Go package](https://github.com/golang/go/wiki/PackagePublishing) is relatively simple. You simply need to make the package source code publicly available. The majority of developers use GitHub to host packages and make them publicly available. That's the reason you'll sometimes find import in some programs references to `github.com`.

For instance, if you want to publish your `calculator` package to your GitHub account, you'll need to create a repository named `calculator`, and the URL should look similar to this:

```output
https://github.com/myuser/calculator
```

And regarding versioning your packages, you'll do it by tagging your repository, like this:

```output
git tag v0.1.0
git push origin v0.1.0
```

Then, those who want to use your package (or even you) would have to reference it like this:

```output
import "github.com/myuser/calculator"
```

But, let's continue talking in more detail about how to reference third-party packages in the next section.

## Referencing external (third-party) packages

Sometimes, your programs need to reference packages written by other developers. Typically, those packages are available on GitHub. The below instructions for referencing third-party packages work whether you're developing a package (package different than main) or a standalone program (package main).

Now let's add a reference to the `rsc.io/quote` package in your program, like this:

```go
package main

import (
    "github.com/myuser/calculator"
    "rsc.io/quote"
)

func main() {
    total := calculator.Sum(3, 5)
    println(total)
    println("Version: ", calculator.Version)
    println(quote.Hello())
}
```

If you're using VS Code, when you save the file, the `go.mod` file gets updated, and now it looks like this:

```output
module helloworld

go 1.14

require (
    github.com/myuser/calculator v0.0.0
    rsc.io/quote v1.5.2
)

replace github.com/myuser/calculator => ../calculator
```

Notice how `rsc.io/quote` is referencing a specific version of the package. This is where you'll need to change the version when you need to upgrade your program's dependencies.

Rerun the program with the following command:

```output
go run main.go
```

And the output should look like this:

```output
8
Version:  1.0
Hello, world.
```

All future references to third-party packages will need to exist in the `go.mod` file, and when you run or compile the application, Go will download all its dependencies.
