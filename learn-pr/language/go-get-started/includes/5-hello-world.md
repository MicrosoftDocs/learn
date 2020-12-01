# Exercise - Hello World
In this section, you’ll write your first Go program that prints a message to the screen. Although this is the typical example to get started in a programming language, you’ll also learn more about the Go CLI, like building and running an application written in Go.

## Step 1: Head over to the Go workspace and launch VS Code
First, to make sure you’re working in your Go workspace, open a terminal prompt, and run the following command to open your workspace directory:

```
cd $GOPATH/src
```

Once there, you can start VS Code from your terminal and start editing the current directory files. However, you need to register the VS Code CLI in your **$PATH** environment variable. To do so, follow these steps:

- Launch VS Code
- Open the **Command Palette** under the **View** top menu and type 'shell command' to find the **Shell Command: Install 'code' command in PATH** command.
- Restart the terminal for the new **$PATH** value to take effect. You'll be able to type 'code .' in any folder to start editing files in that folder.
- Close VS Code.

Now, run the following command to open VS Code in the current directory:

```
code .
```

## Step 2: Create a new folder and create a Go file for the project
Once you’re in VS Code, create a new directory named “helloworld,” and within it, create a new file named “main.go” that will contain the app code. Your folder structure tree should look like this:

```
src/
  helloworld/                     
	main.go
```

Open the main.go file, and type the following code:

```
package main

import "fmt"

func main() {
	fmt.Println("Hello World!")
}
```

Now save the file. Don’t worry about your code format (e.g., tabs vs. spaces) as VS Code will format the code automatically every time you save the file. 

## Step 3: Execute your program 
It’s time to run your program. To do so, open a new terminal prompt in your workstation, or you can have one as well in VS Code by going to the **Terminal** menu and then click on **New Terminal**. Make sure you change the directory to the one for your app code. In this case, it should be **$GOPATH/src/helloworld**. In the terminal, run the following command:

```
go run main.go
```

You should see the following output:

```
Hello World!
```

The **go run** command does two things. First, it starts by compiling the app, and if everything is fine, then execute the app. You can generate an executable by only running the following command:

```
go build main.go
```

When the previous command finishes, it generates an executable app that you can run any time without further processing. Now your project should look like this:

```
src/
  helloworld/                     
	main
	main.go
```

The name of the file without extension (.exe if you’re on Windows) is the executable file you can use to run your program. When you’re developing, you will use the **go run** command. But when you’re building the binaries for your application, you’d use the **go build** command and deploy the binary executable to a proper environment.

## What did you just write in Go?
Now that you’ve created your first Go app and made sure it compiles and runs, let’s examine line by line the code you’ve just written.

Let’s start with the following one:

```
package main
```

This is how we define in Go that the application we’re creating is an executable program (a file we can run). This hello world app is part of the main package. A package is a set of common source code files. Every executable app has this first line, even if the project or file has a different name. We’ll go deeper into this topic in the next module, but for now, just make note that every executable program should be part of the main package.

**Challenge:** To confirm what you’ve just read, change the package’s name in the first line, and try to run the program. What happened? Did you see the “Hello World!” output or any binary executable?

Now let’s talk about the following line:

```
import "fmt"
```

The import statement gives access to your program for other code located in a different package. In this case, **fmt** is a standard library package, and you can [see its documentation at the Go official documentation site](https://golang.org/pkg/fmt/). You need this import because you’re using a function from this package to print a message to the screen later in the program. You can include as many imports as you want or need in your program. However, Go is very idiomatic in this regard, and if you’re importing a package, but you’re not using it, the app won’t compile. If you’re using VS Code, those imports that your program doesn’t use are removed automatically when you save the file you’re editing.

**Challenge:** To confirm what you’ve just read, include another import like **math** or **io**. What happened? Did VS Code remove the import when you saved the file? Try editing the file without VS Code, and try to run the app. What’s the output you see now?

Let’s talk about the following block:

```
func main() {
   fmt.Println("Hello World!")
}
```

The **func** statement is a reserved word to declare a function. But for now, let’s talk about why this function is called **main**. The main function is the starting point of your program. Therefore, you can only have one main function across the package main (the one you defined in the first line). In this function, you called the **Println** function from the **fmt** package and sent a text that you wanted to see on the screen. There’s more we can talk about functions, but we’ll cover this topic in the next module.
