To put in practice the debugging concepts you just saw, you'll create a short Node.js program to compute the *N*<sup>th</sup> number of the Fibonacci sequence.

The Fibonacci sequence is a suite of numbers that starts with the number 0 and 1, with every other following number being the sum of the two previous ones. The sequence continues like that:

```text
0, 1, 1, 2, 3, 5, 8, 13, 21...
```

Let's create a new Node.js program to illustrate the concept.

## Prepare environment

Before we dive into the exercise, we first have to prepare the code and environment.

1. Copy and paste this command in the terminal on the right to prepare the Node.js environment:

    ```bash
    source <(curl -Ls https://aka.ms/install-node-lts)
    ```

1. After everything has finished installing, create a new JavaScript file with:

    ```bash
    code fibonacci.js
    ```

1. Then paste this code in the editor:

    ```js
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

1. Save the file, and then run the program by using the terminal:

    ```bash
    node fibonacci.js
    ```

The program should display the result `3` in the console. Oops, it seems there's a bug in there because we expected to see `5`. Let's understand what's going wrong by using the Node.js built-in debugger.

## Start built-in debugger

Start the program again. This time with the built-in debugger enabled:

```bash
node inspect fibonacci.js
```

You should see the debugger prompt displayed. Now step in using the `s` command until the execution point is located at the beginning of the `fibonacci` function, like this:

```bash
break in fibonacci.js:2
  1 function fibonacci(n) {
> 2   let n1 = 0;
  3   let n2 = 1;
  4   let sum = 0;
debug>
```

We can check at this point the value of the *n* parameter passed in the function by using the command:

```bash
exec n
```

You should see `5` displayed in the console. Step in again by using the `s` command until the execution point is at the beginning of the loop, like this:

```bash
break in fibonacci.js:7
  5
  6   for (let i = 2; i <= n; i++) {
> 7     sum = n1 + n2;
  8     n1 = n2;
  9     n2 = sum;
debug>
```

> [!NOTE]
> You might have noticed that to move through the `for(...) {}` line requires multiple steps in commands. This situation occurs because there are multiple *statements* on this line. When you step, you move on to the next statement in your code. Usually, there's one statement per line. If that's not the case, you need multiple steps to move on to the next line.

## Locate the bug with breakpoints

Now let's add a breakpoint here so that we can quickly move through the loop iterations:

```bash
sb()
```

You should see the same lines displayed again in the console, which indicates that a breakpoint was set at this line. When the current execution point moves, you'll see a `*` on the line where you set the breakpoint. Advance to the next loop iteration by using the `c` command.

We can check the current iteration state with the `exec` command:

```bash
exec [i, sum]
```

> [!NOTE]
> You can see the value of multiple variables by using an array, like with `[i, sum]`.

You should see `[ 3, 1 ]` in the console. Because the code hasn't updated the value of `sum` for the current iteration (`3`), it currently represents the Fibonacci number for the previous iteration:

```text
fibonacci(2) = fibonacci(0) + fibonacci(1)
             = 0 + 1
             = 1
```

It seems that our program runs correctly up to this point. Continue to the next loop iteration by using the `c` command. Check the state again:

```bash
exec [i, sum]
```

You should see `[ 4, 2 ]` in the console, which is correct again. Now we're at the point just before the number we're interested in, which is `5`. To be cautious, advance step by step through this iteration by using the `s` command. Try to reach our previous breakpoint, but do it one step at a time.

What happened?

## Fix the bug

After checking the loop condition `i < n`, the execution suddenly jumped to the return line:

```bash
break in fibonacci.js:12
 10   }
 11
>12   return n === 0 ? n1 : n2;
 13 }
 14
```

That's it, we just found our bug! Instead of updating the sum for the iteration 5, the code jumped out of the loop. That's why we got the result of the previous iteration (3) in our initial run.

Fix the loop condition by changing `i < n` to `i <= n` in the code editor. Now you can exit the debugger by selecting **Ctrl+D**, and then run your program again:

```bash
node fibonacci.js
```

You should see the expected result displayed in the console now, which is `5`.

You can use the built-in debugger in Node.js to learn the basic debugging principles and for quick debugging sessions. It can be bothersome to type in the commands and might be too limited and difficult to use with complex programs.

We'll see in the next sections how to use the Visual Studio Code debugger instead.
