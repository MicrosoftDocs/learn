To put in practice the debugging concepts you just saw, you'll create a short Node.js program to compute the *N*<sup>th</sup> number of the Fibonacci sequence.

The Fibonacci sequence is a suite of numbers that starts with the number 0 and 1, with every other following number being the sum of the two previous numbers. The sequence continues like that:

```text
0, 1, 1, 2, 3, 5, 8, 13, 21...
```

Let's create a new Node.js program to illustrate the concept.

## Prepare environment

Before we dive into the exercise, we first have to prepare the code and environment.

1. Copy the following command and paste it into the terminal on the right to prepare the Node.js environment:

    ```bash
    source <(curl -Ls https://aka.ms/install-node-lts)
    ```

1. After everything has finished installing, create a new JavaScript file with the following code:

    ```bash
    code fibonacci.js
    ```

1. Paste this code into the editor pane of the terminal:

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

1. Save the file in the terminal by using <kbd>CTRL</kbd> + S, and then run the program by using the following command:

    ```bash
    node fibonacci.js
    ```

The program should display the result `3` (three) in the console. Oops, it seems there's a bug in there because we expected to see `5` (five) as the result. Let's understand what's going wrong by using the Node.js built-in debugger.

## Start built-in debugger

Start the program again, this time with the built-in debugger enabled. Enter this command in the terminal:

```bash
node inspect fibonacci.js
```

You should see the debugger prompt displayed. Now, step into the code by running the `s` command until the execution point is located at the beginning of the `fibonacci` function, like this:

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