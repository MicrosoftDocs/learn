Packages in Go are like libraries or modules in other programming languages. You can package your code and reuse it somewhere else. The source code of a package can be distributed in more than one `.go` file. So far, we've been writing the `main` package and have made a few references to other native packages.

In this section, you'll learn what a package is. You'll also learn how to create one and how to consume external packages.

## The main package

As you might have noticed, even the most straightforward program in Go has to be part of a package. Usually, the default package is the `main` package, the one we've been using so far. If a program is part of the `main` package, Go generates a binary file. When that file runs, it calls the `main()` function.

In other words, when you use the `main` package, your program will produce a standalone executable. But when a program is part of a package other than `main`, Go doesn't generate a binary file. It generates a package archive file (a file with an .a extension).

By convention, the package name is the same as the last element of the import path. For example, to import the `math/rand` package, you need to import it like this:

```go
import "math/rand"
```

And to refer to objects in the package, you do it like this:

```go
rand.Int()
```

Let's create a package.

## Create a package

Create a new directory in the `$GOPATH/src` directory called `calculator`. Create a file called `sum.go`. The tree directory should look like this directory:

```output
src/
  calculator/
    sum.go
```

Initialize the `sum.go` file with the name of the package:

```go
package calculator
```

You can now start to write the functions and variables for the package. Unlike other programming languages, Go doesn't provide the `public` or `private` keywords to indicate if a variable or function can be called from outside or inside of the package. But Go follows two simple rules:

- If you want something to be private, start its name with a lowercase letter.
- If you want something to be public, start its name with an uppercase letter.

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

Let's look at a few things in that code:

- The `logMessage` variable can be called only from within the package.
- The `Version` variable can be reached from anywhere. We recommend that you include a comment to describe the purpose of this variable. (This description is useful for anyone who uses the package.)
- The `internalSum` function can be called only from within the package.
- The `Sum` function can be reached from anywhere. Again, we recommend that you include a comment to describe the purpose of the variable.

To confirm that everything is working, you can run the `go build` command in the `calculator` directory. If you do, notice that no executable binary is generated.

## Create a module

You've grouped the calculator functionality into a package. Now it's time to group the package into a module. Why? Your package's module specifies the context that Go needs to run the code you've grouped together. This contextual information includes the Go version your code is written for.

Also, modules help other developers reference specific versions of your code and make working with dependencies easier. Another benefit is that our program's source code doesn't strictly need to exist in the `$GOPATH/src` directory. Freeing that restriction makes it more convenient to work with different package versions in other projects at the same time.

So, to create a module for the `calculator` package, run this command in the root directory (`$GOPATH/src/calculator`):

```output
go mod init github.com/myuser/calculator
```

After you run this command, `github.com/myuser/calculator` becomes the package's name. You'll use that name to reference it in other programs. The command also creates a new file called `go.mod`. Finally, the tree directory now looks like this directory:

```output
src/
  calculator/
    go.mod
    sum.go
```

The contents of the `go.mod` file should look like the following code. (The Go version might be different.)

```output
module github.com/myuser/calculator

go 1.14
```

To reference this package in other programs, you need to import it by using the module name. In this case, the name is `github.com/myuser/calculator`. Now let's look at an example of how to use this package.

> [!NOTE]
> Historically, managing dependencies in Go hasn't been easy. The dependency management system is still a work in progress. If you want to learn more about modules, see this [series of posts published in the Go blog](https://blog.golang.org/using-go-modules).

## Reference a local package (a module)

Now let's use the package. We'll continue with the sample application we've been using. This time, instead of having the `sum` function in the `main` package, let's use the one we created earlier in the `calculator` package.

The tree file structure now should look like this:

```output
src/
  calculator/
    go.mod
    sum.go
  helloworld/
    main.go
```

We'll use this code for the `$GOPATH/src/helloword/main.go` file:

```go
package main

import "github.com/myuser/calculator"

func main() {
    total := calculator.Sum(3, 5)
    println(total)
    println("Version: ", calculator.Version)
}
```

Notice that the import statement uses the name of the package you created: `calculator`. To call the `Sum` function from that package, you need to specify the package name as `calculator.Sum`. Finally, you now also have access to the `Version` variable. You call it like this: `calculator.Version`.

If you try to run the program now, it won't work. You need to inform Go that you're using modules to reference other packages. To do so, run this command in the `$GOPATH/src/helloworld` directory:

```output
go mod init helloworld
```

In the above command, `helloworld` is the name of the project. This command creates a new `go.mod` file, so now the tree directory looks like this:

```output
src/
  calculator/
    go.mod
    sum.go
  helloworld/
    go.mod
    main.go
```

When you open the `go.mod` file, you should see something like the following code. (The Go version might be different.)

```output
module helloworld

go 1.14
```

Because you're referencing a local copy of the module, you need to inform Go that you don't want to use a remote location. So you need to manually modify the `go.mod` file to include the reference, like this:

```output
module helloworld

go 1.14

require github.com/myuser/calculator v0.0.0

replace github.com/myuser/calculator => ../calculator
```

The `replace` keyword specifies to use a local directory instead of a remote location for the module. In this case, because the `helloworld` and `calculator` programs are in `$GOPATH/src`, the location is simply `../calculator`. If the module's source is in a different location, you define the local path here.

Run the program by using this command:

```output
go run main.go
```

The output should be as follows:

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

[Publishing a Go package](https://github.com/golang/go/wiki/PackagePublishing) is fairly easy. You just need to make the package source code publicly available. Most developers use GitHub to make packages available to the public. That's why you'll sometimes find references to `github.com` in import statements.

For example, if you want to publish your `calculator` package to your GitHub account, you need to create a repository named `calculator`. The URL should look similar to this one:

```output
https://github.com/myuser/calculator
```

You'll version your packages by tagging your repository, like this:

```output
git tag v0.1.0
git push origin v0.1.0
```

Developers who want to use your package (including you) would reference it like this:

```output
import "github.com/myuser/calculator"
```

Let's talk in more detail about how to reference third-party packages.

## Referencing external (third-party) packages

Sometimes your programs need to reference packages written by other developers. Typically, those packages are available on GitHub. The following instructions for referencing third-party packages work whether you're developing a package (a package other than `main`) or a standalone program (the `main` package).

Let's add a reference to the `rsc.io/quote` package:

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

If you're using Visual Studio Code, the `go.mod` file is updated when you save the file. It now looks like this:

```output
module helloworld

go 1.14

require (
    github.com/myuser/calculator v0.0.0
    rsc.io/quote v1.5.2
)

replace github.com/myuser/calculator => ../calculator
```

Notice how `rsc.io/quote` references a specific version of the package. When you need to upgrade your program's dependencies, you'll need to change the version here.

Run the program again by using this command:

```output
go run main.go
```

The output should look like this:

```output
8
Version:  1.0
Hello, world.
```

All future references to third-party packages will need to be in the `go.mod` file. When you run or compile the application, Go will download all of its dependencies.
