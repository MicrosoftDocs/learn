To put in practice the debugging concepts you just saw, you'll create a short Node.js program to compute the *N*<sup>th</sup> number of the Fibonacci sequence.

The Fibonacci sequence is a suite of numbers starting with the number 0 and 1, with every other following number being the sum of the two previous ones, going on like that:

```text
0, 1, 1, 2, 3, 5, 8, 13, 21...
```

Let's create a new Node.js program to illustrate that.

## Prepare environment

Before diving into the exercise, we have first to prepare the code and environment.

1. Copy and paste the command below in the terminal on the right to prepare the Node.js environment:

    ```bash
    source <(curl -Ls https://aka.ms/install-node-lts)
    ```

1. Once everything has finished installing, create a new JavaScript file with:

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

1. Save the file, then run the program using the terminal:

    ```bash
    node fibonacci.js
    ```

The program should display the result `3` in the console. Oops, it seems there's a bug in there, as we expected `5`! Let's understand what's going wrong using the Node.js built-in debugger.

## Start built-in debugger

Start again the program, this time with the built-in debugger enabled:

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

We can check at this point the value of the **n** parameter passed in the function using the command:

```bash
exec n
```

You should see `5` displayed in the console. Step in again using the `s` command until the execution point is at the beginning of the loop, like this:

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
> You may have noticed that it requires multiples step in commands to move through the `for(...) {}` line. This is because there are multiple **statements** on this line, and when stepping you move on to the next statement in your code. Usually there is one statement per line, but if that's not the case you need multiple steps to move on to the next line.

## Locate the bug with breakpoints

Now let's add a breakpoint here so we can quickly move through the loop iterations:

```bash
sb()
```

You should see the same lines displayed again in the console, indicating that a breakpoint has been set at this line. When the current execution point moves, you'll see a `*` on the line where you set the breakpoint. Advance to the next loop iteration by using the `c` command.

We can check the current iteration state with the `exec` command:

```bash
exec [i, sum]
```

> [!NOTE]
> You can see the value of multiple variable by using an array, like with `[i, sum]`.

You should see in the console `[ 3, 1 ]`. As the code hasn't updated the value of `sum` for the current iteration (`3`), it currently represents the fibonacci number for the previous iteration:

```text
fibonacci(2) = fibonacci(0) + fibonacci(1)
             = 0 + 1
             = 1
```

It seems that our program runs correctly up to this point. Continue to the next loop iteration using the `c` command, and check the state again:

```bash
exec [i, sum]
```

You should see in the console `[ 4, 2 ]`, which is correct again. Now we're at the point just before the number we're interested in (5), so it may be cautious to advance step by step through this iteration, using the `s` command. Try to reach our previous breakpoint, but one step at a time.

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

That's it, we just found our bug! Instead of updating the sum for the iteration 5, the code jumped out of the loop, that's why we got the result of the previous iteration (3) in our initial run.

Fix the loop condition by changing `i < n` to `i <= n` in the code editor. Now you can exit the debugger with `CTRL + D`, and run your program again:

```bash
node fibonacci.js
```

You should see the expected result displayed in the console now: `5`.

While you can use the built-in debugger in Node.js to learn the basic debugging principles and for quick debugging sessions, it can be bothersome to type in the commands and may be too limited and difficult to use with complex programs.

We'll see in the next sections how to use VS Code debugger instead.
