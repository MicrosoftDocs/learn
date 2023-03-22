In this section, you'll write your first Go program to print a message to the screen. This exercise is a typical way to get started in a programming language. You'll learn more about the Go command-line interface (CLI), and how to build and run a Go application.

## Configure the IDE to open from the CLI

You can open the Visual Studio Code IDE from your CLI prompt and start editing the files in your current workspace. This IDE feature is implemented by using the **$PATH** (or _$Path_) system environment variable. When the feature is enabled, you can use the `code .` command from the CLI to open the IDE and edit files in your current directory.

Some installations of Visual Studio Code add support for the CLI to the $PATH variable by default. You might see this option during the installation process. If you already have this setting configured, then you're all set. Otherwise, you might need to do the following steps to use this feature.

::: zone pivot="linux,macos"
### Linux or macOS

Follow these steps to register the Visual Studio Code CLI in your $PATH environment variable:

1. Open Visual Studio Code.

1. Under **View**, select **Command Palette**.

1. In the search box, enter **shell command**. As you type, the results filter.

1. Choose the **Shell Command: Install 'code' command in PATH** command.

1. Close your open Command or Terminal prompt.

   > [!Important]
   > If you have an open prompt from the previous exericse, close the prompt and open a new prompt. This step is necessary for the new **$PATH** value to take effect.

1. Close Visual Studio Code.

::: zone-end

::: zone pivot="windows"
### Windows

Follow these steps to add the location of the Visual Studio Code CLI to your $Path system environment variable:

> [!NOTE]
> If you're familiar with environment variables, and know how to add a new location to your $Path system variable, you can use the method that works best for you. The following procedure is a bit long, but it's a verified method to ensure the variable is correctly updated.

1. Open the Windows **Control Panel**.

1. Select **System**, and then select **Advanced system settings**.

1. In the **System properties** dialog, under **Advanced**, select **Environment variables**. The **Edit environment variables** dialog opens.

   The **Edit environment variables** dialog shows two lists:
   - User variables for \<user-name\>: Local variable definitions for the specific user.
   - System variables: System variable definitions for all users.

   In this procedure, we're working with the system variables.

1. In the **Environment variables** dialog, in the **System variables** list box, scroll to locate the **Path** variable.

1. Select the **Path** variable to highlight the row. Select **Edit**. The **Edit environment variables** dialog opens. The dialog lists all the folder locations that are defined in the variable.

1. In the **Edit environment variables** dialog, select **New**. An empty row opens at the end of the list.
 
1. In the empty row, enter the location of the Visual Studio Code CLI executable. Replace `<user-name>` with your user name.

   ```console
   C:\Users\<user-name>\AppData\Local\Programs\Microsoft VS Code\bin
   ```

1. Select **OK** to close each dialog.

1. Close the **System properties** dialog and the Windows **Control Panel**.

::: zone-end


## Step 1: Open your Go workspace and the IDE

After you confirm Visual Studio Code is ready to use from the CLI, you can open your Go workspace.

1. Open a new Command or Terminal prompt.

1. Open your Go workspace directory by running the following command:

   ::: zone pivot="linux,macos"

   ```console
   cd $GOPATH/src
   ```

   ::: zone-end

   ::: zone pivot="windows"

   ```console
   cd %GOPATH%/src
   ```

   ::: zone-end

1. Use the following command to open Visual Studio Code from your workspace:

   ```console
   code .
   ```

Visual Studio Code launches. The **Explorer** view is shown on the left, and a **Welcome** page is on the right.

In the **Explorer** view, the **SRC** section of your Go project should be open (expanded). This section is the */src* folder for your project. It's currently empty, but we'll add some content in the next step.

## Step 2: Create a new folder and a Go file

Let's add a folder and file to your Go project. There are several ways in Visual Studio Code to create new items:

- Actions on the toolbar menu:
  - Select **File** > **Open folder**, and then create a **New folder**.
  - Select **File** > **New file**, and start a new file.
- Links on the **Welcome** page, which are similar to the toolbar menu actions.
- Icons in the **Explorer** view, to the right of the **SRC** section:
  - Select the **New folder** icon. In the text box, type the folder name, and press Enter.
  - Select the **New file** icon. In the text box, type the file name, and press Enter.

Complete the following steps in Visual Studio Code. 
To create the new file and folder, use the process that works best for you.

1. Create a new folder named *helloworld*. 
1. Create a new file named *main.go* for your app code.
1. Expand the **Explorer** > **SRC** view to show your folder structure tree. It should look like this example:

   > SRC/<br>
   > &nbsp;&nbsp;&nbsp;&nbsp;helloworld/<br>
	> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;main.go

### Install Go extension tools

If *main.go* is the first Go file you open in Visual Studio Code, you might be prompted to install other tools for the Go extension. When you're prompted, select **Install**. A Terminal opens at the bottom of the IDE to show the output of the process. You should see output like this example:

> Tools environment: GOPATH=C:\Projects\Go<br>
> Installing 5 tools at C:\Projects\Go\bin in module mode.<br>
> Installing github.com/uudashr/gopkgs/v2/cmd/gopkgs (C:\Projects\Go\bin\gopkgs.exe) SUCCEEDED

During the install process, check the status bar in Visual Studio Code. If you see a message at the bottom right, such as "All tools not installed," select the message. In the popup, select **Install**.

When the install process succeeds, the Terminal output displays a summary:

> All tools successfully installed. You are ready to Go :).

## Step 3: Add code to your Go file

Now let's add code to your Go file.

1. In the *main.go* file, add the following code:

   ```go
   package main

   import "fmt"

   func main() {
       fmt.Println("Hello World!")
   }
   ```

1. Save the file.

Don't worry about code formatting like tabs or spaces. Visual Studio Code formats the code automatically every time you save the file. 

## Step 4: Execute your Go program 

The Go program can be executed in a Command or Terminal prompt, or in a Terminal that runs inside Visual Studio Code.

You can use an existing prompt, or open a new one. If you open a new prompt, remember to change the directory location to your Go workspace. Also be sure to run the program from the folder that has your Go file: *$GOPATH/src/helloworld*. 


### Open a Terminal inside Visual Studio Code

If you want to run the program from within Visual Studio Code, rather than a standalone Command or Terminal prompt, follow these steps:

1. In Visual Studio Code, select **Terminal**, and then select **New Terminal**.

1. In the drop-down box at the top-right of the Terminal, select **New Command Prompt**.

1. In the Terminal, run the following command to change the directory location to your Go workspace and the folder that has your Go file: 

   ::: zone pivot="linux,macos"

   ```console
   cd $GOPATH/src/helloworld
   ```

   ::: zone-end

   ::: zone pivot="windows"

   ```console
   cd %GOPATH%/src/helloworld
   ```

   ::: zone-end


### Run your Go app

To run your Go app, use the following command in your Terminal or prompt:

```console
go run main.go
```

You should see the following output:

```output
Hello World!
```

The `go run` command does two things. It compiles the app, and after compile succeeds, it executes the app.

### Build an executable

To generate an executable for your program, use this command:

```console
go build main.go
```

When the `go build` command completes, it generates an executable app that you can run anytime without further processing. The command only produces an executable. It doesn't run the program like the `go run` command.

### Review the /src contents

Here's what your project should look like now in the **Explorer** > **SRC** view:

> SRC/<br>
> &nbsp;&nbsp;&nbsp;&nbsp;helloworld/<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;main<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;main.go

In the **Explorer** view, the name of the file without the extension is the executable file you can use to run your program. (On Windows, this file actually has the *.exe* extension.) When you're developing, you use the `go run` command. To build the binaries for your application, you use the `go build` command and deploy the binary executable to a proper environment.

## What did you just write in Go?

You created your first Go app and made sure it compiles and runs. Let's examine the code line by line.

We'll start with the first statement in your Go file:

```go
package main
```

The `package main` statement is how we tell Go that the app we're creating is an executable program (a file you can run). Our "Hello World!" app is part of the `main` package. A package is a set of common source code files. Every executable app has this first line, even if the project or file has a different name. 

We'll look closer at these concepts in the next module. For now, we need to know that **every** executable program should be part of the `main` package.

> [!div class="alert is-tip"]
> **Challenge: _Change the package name_**
>
> Can you confirm the importance of the `main` package?
>
> 1. In your Go file, change the package name in the first line.
> 1. Save the file, and run your program again in the Terminal.
>
> &nbsp;
> What happens? Do you see "Hello World!"? Is a binary executable produced?
>
> &nbsp;
> <details>
> <summary><b>Show answer</b></summary>
> <br>
> <i>"Hello World!" isn't displayed. A binary executable isn't produced. You should see an error: `go run: cannot run non-main package`. Why? Every executable program should be part of the `main` package.</i>
> 
> </details>
>
***

Here's the next line in your Go file:

```go
import "fmt"
```

The `import` statement gives access to your program to other code in different packages. In this case, *fmt* is a standard library package. You can read about the *fmt* package at the [official Go documentation site][GoDocs]. 

You need this `import` statement because you're using a function from this package to print a message to the screen later in the program. You can include as many `import` statements as you want or need in your program. However, Go is idiomatic in this regard. If you import a package, but don't use a corresponding function from the package, the app won't compile. A great feature of Visual Studio Code is that it automatically removes unused imports in a program when you save the file.


Did Visual Studio Code remove the import when you saved the file? Try editing the file without Visual Studio Code, and try to run the app. What output do you see now?

> [!div class="alert is-tip"]
> **Challenge: _Add another import_**
>
> Can you verify what you learned about unused imports?
> 1. Restore your Go file to the original code.
> 1. Add another import statement like `math` or `io`.
> 1. Save the file, and run your program again in the Terminal.
>
> &nbsp;
> What happens? Does Visual Studio Code remove the unused import? If so, when is it removed?
>
> 1. Edit your Go file again, but don't use Visual Studio Code.
> 1. Save the file, and run your program in a new prompt.
>
> &nbsp;
> What happens? What output do you see now?
>
> &nbsp;
> <details>
> <summary><b>Show answer</b></summary>
> <br>
> <i>If you edit your Go file in the IDE, when you save your file, Visual Studio Code detects any unused packages and removes the corresponding `import` statements. When you edit your Go file outside of Visual Studio Code, the code fails. You should see an error, such as: `# command-line-arguments .\main.go:5:2: imported and not used: "math"`.</i>
> 
> </details>
>
***

Let's look at the block of code in your Go file:

```go
func main() {
   fmt.Println("Hello World!")
}
```

The `func` statement is a reserved word that's used to declare a function. This first function is named "main" because it's the starting point of our program. You can have only one `main()` function across the `package main` (the one you defined in the first line). In the `main()` function, you called the `Println` function from the `fmt` package. You sent a text message that you wanted to see on the screen. 

There's more to cover about functions, and we'll do that in the next module.

<!-- Links -->
[GoDocs]: https://golang.org/pkg/fmt/?azure-portal=true
