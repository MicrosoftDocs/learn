In this section, you’ll write your first Go program, which prints a simple message to the screen. This is a typical way to get started in a programming language, but you’ll also learn more about the Go command-line interface (CLI), and how to build and run an application that's written in Go.

## Step 1: Open your Go workspace and Visual Studio Code
To ensure that you’re working in your Go workspace, open a terminal prompt, and then open your workspace directory by running the following command:

```
cd $GOPATH/src
```

After you've opened your workspace, you can open Visual Studio Code from your terminal and start editing the current directory files. You first need to register the Visual Studio Code CLI in your **$PATH** environment variable. To do so, follow these steps:

1. Open Visual Studio Code.
1. On the **View** menu, open the **Command Palette**.
1. In the search box, type **shell command** to find the **Shell Command: Install 'code' command in PATH** command.
1. Restart the terminal for the new **$PATH** value to take effect. You'll be able to type **`code .`** in any folder to start editing files in that folder.
1. Close Visual Studio Code.

Now, to open Visual Studio Code in the current directory, run the following command:

```
code .
```

## Step 2: Create a new folder and a Go file for the project
In Visual Studio Code, create a new directory named *helloworld* and, within it, create a new file named *main.go*, which will contain the app code. Your folder structure tree should look like this:

```
src/
  helloworld/                     
	main.go
```

Open the *main.go* file, and type the following code:

```
package main

import "fmt"

func main() {
	fmt.Println("Hello World!")
}
```

Save the file. 

Don’t worry about your code formatting (for example, tabs versus spaces), because Visual Studio Code formats the code automatically every time you save the file. 

## Step 3: Execute your program 
It’s time to run your program. To do so, open a new terminal prompt in your workstation. Alternatively, you can open a command prompt in Visual Studio Code by going to the **Terminal** menu and then selecting **New Terminal**. Be sure to change the directory to the one for your app code. In this case, it should be **$GOPATH/src/helloworld**. In the terminal, run the following command:

```
go run main.go
```

You should see the following output:

```
Hello World!
```

The **go run** command does two things. First, it compiles the app and then, if everything is fine, executes the app. You can generate an executable by running only the following command:

```
go build main.go
```

When the preceding command finishes, it generates an executable app that you can run anytime without further processing. Now your project should look like this:

```
src/
  helloworld/                     
	main
	main.go
```

The name of the file without the file name extension (.exe if you’re on Windows) is the executable file you can use to run your program. When you’re developing, you will use the **go run** command. But when you’re building the binaries for your application, you’d use the **go build** command and deploy the binary executable to a proper environment.

## What did you just write in Go?
Now that you’ve created your first Go app and made sure that it compiles and runs, let’s examine line by line the code you’ve just written.

Let’s start with the following line:

```
package main
```

This is how to define in Go that the application you’re creating is an executable program (a file that you can run). This "Hello World!" app is part of the main package. A package is a set of common source code files. Every executable app has this first line, even if the project or file has a different name. 

We’ll go deeper into this topic in the next module but, for now, just make note that every executable program should be part of the main package.

**Challenge**: To confirm what you’ve just read, change the package’s name in the first line, and try to run the program. What happened? Did you see the “Hello World!” output or any binary executable?

Now let’s talk about the following line:

```
import "fmt"
```

The import statement gives access to your program from other code that's located in a different package. In this case, *fmt* is a standard library package, and it's documented at the [official Go documentation site](https://golang.org/pkg/fmt/). 

You need this import statement because you’re using a function from this package to print a message to the screen later in the program. You can include as many imports as you want or need in your program. However, Go is very idiomatic in this regard. If you’re importing a package but not using the statement, the app won’t compile. If you’re using Visual Studio Code, the program's unused imports are removed automatically when you save the file you’re editing.

**Challenge**: To confirm what you’ve just read, include another import, such as *math* or *io*. What happened? Did Visual Studio Code remove the import when you saved the file? Try editing the file without Visual Studio Code, and try to run the app. What output do you see now?

Let’s talk about the following block:

```
func main() {
   fmt.Println("Hello World!")
}
```

The *func* statement is a reserved word that's used to declare a function. For now, let’s talk about why this function is called *main*. The main function is the starting point of your program. Therefore, you can have only one main function across the package main (the one you defined in the first line). In this function, you called the *Println* function from the *fmt* package and sent a text message that you wanted to see on the screen. 

There’s more to cover about functions, and we’ll do so in the next module.
