To put in practice the debugging concepts you just saw, you'll create a short Node.js program to compute the *N*<sup>th</sup> number of the Fibonacci sequence.

The Fibonacci sequence is a suite of numbers that starts with the number 0 and 1, with every other following number being the sum of the two previous numbers. The sequence continues like that:

```text
0, 1, 1, 2, 3, 5, 8, 13, 21...
```

Let's create a new Node.js program to illustrate the concept.


## Open project in development container

#### [Remote development (browser)](#tab/github-codespaces)

1. Start the process to create a new GitHub Codespace on the `main` branch of the [`MicrosoftDocs/node-essentials`](https://github.com/MicrosoftDocs/node-essentials) GitHub repository.

    > [!div class="nextstepaction"]
    > [Open this project in GitHub Codespaces](https://github.com/codespaces/new?azure-portal=true&hide_repo_select=true&ref=main&repo=278117471)

1. On the **Create codespace** page, review the codespace configuration settings and then select **Create new codespace**

    :::image type="content" source="../media/codespaces/codespace-configuration.png" alt-text="Screenshot of the confirmation screen before creating a new codespace.":::

1. Wait for the codespace to start. This startup process can take a few minutes.

1. Open a new terminal in the codespace.

    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="../media/codespaces/open-terminal-option.png" lightbox="../media/codespaces/open-terminal-option.png" alt-text="Screenshot of the codespaces menu option to open a new terminal.":::

1. Validate that Node.js is installed in your environment:

    ```bash
    node --version
    ```

    The dev container uses a Node.js LTS version such as `v20.5.1`. The exact version might be different.

1. The remaining exercises in this project take place in the context of this development container.

#### [Local development (Docker)](#tab/visual-studio-code)


1. Open **Visual Studio Code** in the context of an empty directory.
1. Ensure that you have the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed in Visual Studio Code.
1. Open a new terminal in the editor.
    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="../media/codespaces/open-terminal-option.png" lightbox="../media/codespaces/open-terminal-option.png" alt-text="Screenshot of the menu option to open a new terminal.":::
1. Clone the [`MicrosoftDocs/node-essentials`](https://github.com/MicrosoftDocs/node-essentials) GitHub repository into the current directory.

    ```bash
    git clone https://github.com/MicrosoftDocs/node-essentials.git
    ```

1. Open the repository in code with the following commands in the terminal.

    ```bash
    cd node-essentials
    code .
    ```

1. Open the **Command Palette**, search for the **Dev Containers** commands, and then select **Dev Containers: Reopen in Container**.
    :::image type="content" source="../media/codespaces/reopen-container-command-palette.png" alt-text="Screenshot of the Command Palette option to reopen the current folder within the context of a development container.":::
    > [!TIP]
    > Visual Studio Code might automatically prompt you to reopen the existing folder within a development container. This is functionally equivalent to using the command palette to reopen the current workspace in a container.
    >
    > :::image type="content" source="../media/codespaces/reopen-container-toast.png" alt-text="Screenshot of a toast notification to reopen the current folder within the context of a development container.":::
1. Validate that Node.js is installed in your environment:

    ```bash
    node --version
    ```

    The dev container uses a Node.js LTS version such as `v20.5.1`. The exact version might be different.

1. The remaining exercises in this project take place in the context of this development container.

---

## Prepare environment

Before we dive into the exercise, we first have to prepare the code and environment.

1. Open the `./nodejs-debug` subfolder, then create a new JavaScript file named `fibonacci.js`. 
1. Right-click the `./nodejs-debug` subfolder and select `Open in integrated terminal.`

1. Paste this code into the file:

    ```javascript
    function fibonacci(n) {
      let n1 = 0;
      let n2 = 1;
      let sum = 0;

      for (let i = 2; i < n; i++) {
        sum = n1 + n2;
        n1 = n2;
        n2 = sum;
      }

      return n === 0 ? n1 : n2;
    }

    const result = fibonacci(5);
    console.log(result);
    ```

1. Save the file, <kbd>CTRL</kbd> + <kbd>S</kbd>, and run the program by using the following command:

    ```bash
    node fibonacci.js
    ```

The program should display the result `3` (three) in the console. Oops, it seems there's a bug in there because we expected to see `5` (five) as the result. Let's understand what's going wrong by using the Node.js built-in debugger.

## Start built-in debugger

Start the program again, this time with the built-in debugger enabled. Enter this command in the terminal:

```bash
node inspect fibonacci.js
```

In the terminal, you should see the debugger prompt displayed. Now, step into the code by running the `s` command until the execution point is located at the beginning of the `fibonacci` function, like this:

```bash
break in fibonacci.js:2
  1 function fibonacci(n) {
> 2   let n1 = 0;
  3   let n2 = 1;
  4   let sum = 0;
debug>
```

At this point, we can check the value of the *n* parameter that's passed in the function by running the following command:

```bash
exec n
```

You should see `5` (five) displayed as the result in the console. Continue to step into the code by running the `s` command until the execution point is inside the beginning of the loop. It takes five steps with the `s` command to reach this point:

```bash
break in fibonacci.js:7
  5
  6   for (let i = 2; i < n; i++) {
> 7     sum = n1 + n2;
  8     n1 = n2;
  9     n2 = sum;
debug>
```

> [!NOTE]
> You might have noticed that to move through the `for(...) {}` line requires multiple steps with the debug commands. This situation occurs because there are multiple *statements* on this line. When you step, you move to the next statement in your code. Usually, there's one statement per line. If that's not the case, you need multiple steps to move to the next line.

## Locate the bug with breakpoints

Now let's add a breakpoint at this line so we can quickly move through the loop iterations. Enter the following command in the terminal:

```bash
sb()
```

You should see the same lines displayed again in the console, which indicates that a breakpoint was set at this line. When the current execution point moves, you'll see an asterisk `*` on the line where you set the breakpoint.

Advance to the next loop iteration by running the `c` command in the terminal:

```bash
c
```

We can check the current iteration state with the `exec` command and see the value of multiple variables by using an array as the command parameter. To see the values of the iterator `i` and the total `sum`, we use the syntax `[i, sum]`. Enter this command in the terminal:

```bash
exec [i, sum]
```

You should see the result `[ 3, 1 ]` in the console.

The code hasn't yet updated the value of the `sum` variable for the current iteration, which is `3` (three).
The value of the `sum` variable still shows the Fibonacci number for the previous iteration. Here's the calculation we're using in the code to get the current `sum` value:

```javascript
fibonacci(2) = fibonacci(0) + fibonacci(1)
             = 0 + 1
             = 1
```

Based on our calculation, it seems that our program runs correctly up to this point.

Continue to the next loop iteration by running the `c` command in the terminal, and then check the state again:

```bash
c
exec [i, sum]
```

You should see the result `[ 4, 2 ]` in the console.

Now we're at the point just before the iteration number that we're interested in, which is `5` (five). To be cautious, let's advance step by step through this iteration by using the `s` command. Try to reach our previous breakpoint, but do it one step at a time. Don't step beyond the breakpoint!

What happened?

<!-- Use the `s` command five (5) times. -->


## Fix the bug

After checking the loop condition `i < n`, the execution suddenly jumped to the line that has the `return`  command. Here's what you should see in the terminal:

```bash
break in fibonacci.js:12
 10   }
 11
>12   return n === 0 ? n1 : n2;
 13 }
 14
```

That's it, we just found our bug! Instead of updating the sum for the iteration `5` (five), the code jumped out of the loop. That's why we got the result of the previous iteration `3` (three) in our initial run.

We need to fix the loop condition in the fibonacci.js code. In the code editor, change the value of the test statement from less than `<` to less than or equal to `<=`:

:::code language="javascript" source="../code/fix-loop-condition.js" highlight="1":::

Save your changes in the code editor, and then exit the debugger by selecting <kbd>Ctrl+D</kbd>.

Now run your program again in the terminal:

```bash
node fibonacci.js
```

You should see the expected result displayed in the console now, which is `5` (five).

You can use the built-in debugger in Node.js to learn the basic debugging principles and for quick debugging sessions. It can be bothersome to enter the commands and might be too limited and difficult to use with complex programs.

We'll see in the next sections how to use the Visual Studio Code debugger instead.