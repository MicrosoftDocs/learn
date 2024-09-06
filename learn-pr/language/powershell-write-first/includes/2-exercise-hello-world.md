One of the best ways to learn to code is to write many tiny programs. Writing smaller programs gets
you grounded in the fundamentals of programming and important techniques that you'll apply when you
begin writing larger programs.

## Write your first lines of code

In this exercise, you'll follow a longstanding tradition among software developers of printing the
phrase "Hello World!" to a command line or console window. You can learn a lot from even this
basic exercise.

### Step 1: Type the code in Cloud Shell

Azure Cloud Shell provides an in-browser experience to support our tutorial approach. Cloud Shell
is at the right side of the webpage. It behaves like a normal PowerShell terminal window, but in a
sandbox environment. You can type commands directly in the window, or you can run scripts you've
already written and get the results in Cloud Shell.

In this module, you'll use a version of a code editor in Cloud Shell to write and run scripts.

1. In the Cloud Shell terminal, type the following code:

    ```powershell
    New-Item HelloWorld.ps1
    code HelloWorld.ps1
    ```

    The `New-Item` command creates a new `.ps1` file in the current directory. The `.ps1` filename
    extension is the extension that's used for PowerShell scripts.

    The `code` command followed by the filename of the script you want to work with opens the file
    in the Cloud Shell code editor. Another window opens where you can write and edit scripts and
    then save them to run in Cloud Shell. If you want to open a file that's stored in another
    location, you can define the full path instead of using only the filename.



1. In the code editor window, type the following code:

    ```powershell
    Write-Output 'Hello World!'
    ```

1. Use the <kbd>Ctrl</kbd>+<kbd>S</kbd> keyboard shortcut in Windows (or <kbd>⌘</kbd>+<kbd>S</kbd>
   on macOS) to save the file.

    We'll explain how and why it works soon. But first, you should run your code to ensure that
    you've typed it correctly.

    > [!NOTE]
    > You might be tempted to use the **Copy** button on the code sample to skip all the typing.
    > However, we encourage you to type this line of code yourself. The physical act of typing
    > builds muscle memory and helps you gain insights that you might not get otherwise.

### Step 2: Run the script

To run the script, enter the following command in the Cloud Shell terminal:

```powershell
. ./HelloWorld.ps1
```

> [!NOTE]
> Be sure to include the dot (`.`) at the beginning of the command. This tells PowerShell to run
> the script or file that's being called.

### Step 3: Observe the result

You should see the following output in Cloud Shell:

```Output
Hello World!
```

### What to do if you see an error message

Where other languages require every character to be precise, PowerShell is more relaxed. It's case
insensitive, meaning that it doesn't care whether you accidentally type an upper or lowercase
letter where you aren't supposed to. It interprets `Write-Output` and `write-output` the same way.
The main things to watch out for are misspellings or having an extra or missing space.

If an error occurs, it might look something like this:

```Output
Write-Outpu: The term 'Write-Outpu' is not recognized as a name of a cmdlet, function, script file, or executable program. 
Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
```

In this example, PowerShell is telling us that we incorrectly wrote `Write-Outpu` instead of
`Write-Output`, and it can't find the command we specified.

Reading these errors is essential in helping you learn what caused them. When you run a program and
you get an error, the error often includes the line number where the issue occurred, a description
of the error, and sometimes a suggestion for how to fix it.

> [!NOTE]
> Not all errors are as straightforward as the preceding example to read and understand. Some might
> take a little bit of testing and investigation to figure out their cause.

### Step 4: Create a new file and write code to receive input

1. In the open `HelloWorld.ps1` file, comment out the code you wrote in the editor by adding a
   number sign (`#`) before the command. Below the commented line, add the following lines of code:

    ```powershell
    # Write-Output 'Hello World!'

    $name = Read-Host -Prompt "Please enter your name"
    Write-Output "Congratulations $name! You have written your first code with PowerShell!"
    ```

> [!NOTE]
> You create a code _comment_ by prefixing a line of text with the number sign (`#`). This useful
> technique helps you prevent certain code from running without having to remove it entirely. You
> can also use comments to add information for yourself or others who read your code later. You can
> place comments anywhere in your code, and any text after the `#` on the same line is commented
> out.

1. Save the file, and then run the script by using the same command you used earlier:

    ```powershell
    . ./HelloWorld.ps1
    ```

1. At the prompt that asks for your name, type your name, and then select <kbd>Enter</kbd>.

    The output is a message with your name inserted. For example:

    ```Output
    Congratulations Chase! You have written your first code with PowerShell!
    ```

### How did your program work?

In this exercise, you invoked a _cmdlet_ called `Write-Output`. Cmdlets are the main way you use
PowerShell. The command syntax is a `Verb-Noun` format. This makes it easier to understand what the
code is trying to do. The cmdlet's name is its intent. The code is doing something (verb) to a
thing (noun).

`Hello World!` and the congratulatory sentence are both _string_ inputs for the `Write-Output`
cmdlet to process and output. A string is a basic data type that computers use. In PowerShell, you
can enclose strings in either single quotation marks (`''`) or double quotation marks (`""`). For
our code, we'll use double quotation marks to allow PowerShell to display variable _values_ instead
of variable _names_. You'll learn more about data types and how to define them in a later module.

By using `Read-Host`, you can write a message to prompt a user for input. You define the message
for the user with the `-Prompt` parameter. Parameters allow a cmdlet to take input from a user. You
store the input in a _variable_ called `$name`, and then you use the `Write-Output` cmdlet to
display the custom message in the Cloud Shell terminal.

You'll learn more about variables in a later module. For now, just think of them as containers that
store values to make your code more flexible. Instead of having to type a name into every program,
you can store a value in a variable and reuse it to get different results.

You define a variable by placing a dollar sign (`$`) at the beginning of a word. After the word,
use an equal sign (`=`) followed by the value you want to store in the variable. In the preceding
example, you stored the name "Chase." Variables can be named anything, but it's best to name them
something that helps you understand what it's storing and where to use it. For example, `$name` is
storing someone's first name.

Many cmdlets work much like the preceding example. A user provides input to the cmdlet, the cmdlet
does something, and then the cmdlet produces an output. This process can be something like writing
to the output pane, computing an equation, changing something in the environment, or many other
things.

### Recap

Let's take a moment to recap what you've learned in this first unit:

- Cmdlets are the main way to interact with PowerShell. They're written in a `Verb-Noun` format.
- Parameters take input so that a cmdlet can provide output or take action.
- PowerShell is a relaxed language. That is, it's case insensitive by default.
- PowerShell errors can help you identify issues, and reading errors carefully can save you time.
- Variables are used to store values that you want to use dynamically in your programs.
