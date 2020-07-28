Debugging is a multi-stage process that usually goes along these lines:

1. Identify a bug in your program.
1. Find where the bug is located in your code.
1. Analyze why the bug occurs.
1. Fix the bug.
1. Validate that your fix works.

After you identify an error in your Node.js program, the first challenge you'll face is to find where the error is located in your code. To achieve that, one of the most efficient ways is to run your code step by step to get an idea of where things start to go wrong.

## Breakpoints

Though, running through *all* your code step by step might be extremely inefficient if your program has thousands of lines of code. In that case, you can use a **breakpoint**. It allows you to *break* from your program normal execution and pause at a given *point* in your code.

Using breakpoints you can make your program running normally, up until your reach the critical portion of code where you suspect the error is and switch to step by step.

There are multiple ways of defining breakpoints in your code depending on your debugger and code editor. Though, there is one universal way to force any JavaScript debugger to pause at a given point: using the `debugger` statement.

You can add this statement at any point in your code, like this for example:

```js
function addToBasket(product) {
  // pause at the beginning of this function
  debugger;

  const basket = getCurrentBasket();
  basket.add(product);
}
```

## Node.js inspect mode

As a debugger has full access to the execution environment, a malicious actor could also use it to inject arbitrary code in your Node.js process. That's why by default Node.js doesn't allow you to debug a running program, you have to enable a special mode called **inspector** mode to allow debugging.

You need the `--inspect` option to allow a Node.js process to listen for a debugger client that will attach itself to the process and take control of your program execution.

By default, when Node.js is started with the `--inspect` option it will listen on host `127.0.0.1` on port `9229`. You can however specify a custom host and port using `--inspect=<HOST>:<PORT>`.

> [!IMPORTANT]
> You should avoid binding the Node.js debugger port to a public IP address or to 0.0.0.0, otherwise any clients that can connect to your IP address could potentially connect and control your Node.js process. By doing so an attacker can remotely run arbitrary code on your execution environment, leading to a potentially severe security breach.

As an alternative, you can use the `--inspect-brk` option that works the same as `--inspect` but breaks code execution just before the start of your code.

After Node.js is started with inspect mode enabled, you can use any compatible debugger clients to connect to your Node.js process.

## Built-in debugger

For example, you can use [node-inspect](https://github.com/nodejs/node-inspect), a command-line debugger that comes bundled with Node.js. You can use it by running your program like this:

```bash
node inspect <YOUR_SCRIPT>.js
```

It will run Node.js with inspect mode enabled and launch at the same time the integrated interactive debugger, and pause execution just before your code starts. You should see the debugger prompt indicating it has successfully launched:

```bash
node inspect myscript.js
< Debugger listening on ws://127.0.0.1:9229/ce3689fa-4433-41ee-9d5d-98b5bc5dfa27
< For help, see: https://nodejs.org/en/docs/inspector
< Debugger attached.
Break on start in myscript.js:1
> 1 const express = require('express');
  2
  3 const app = express();
debug>
```

You can now use one of the multiple commands to control the execution of your program:

- `cont` or `c`: Continue execution, until the next breakpoint or the end of your program.
- `next` or `n`: Step next. Executes the next line of code in the current context.
- `step` or `s`: Step in. Same as `next`, except that if the next line of code is a function call, go to the first line of this function's code.
- `out` or `o`: Step out. If the current execution context is inside the code of a function, execute the remaining code of this function and jump back to the line of code where this function was initially called.
- `restart` or `r`: Restart the program and pause the execution before the start of your code.

To set or clear breakpoints in your code, you can use the following commands:

- `setBreakpoint()` or `sb()`: Add a breakpoint on the current line.
- `setBreakpoint(<N>)` or `sb(<N>)`: Add a breakpoint on line number *N*.
- `clearBreakpoint('myscript.js', <N>)` or `cb('myscript.js', <N>)`: Clear breakpoint in file `myscript.js` on line number *N*.

To get information about the current execution point, you can use these commands:

- `list(<N>)`: List your source code with *N* lines before and after the current execution point.
- `exec <EXPR>`: Evaluate an expression within current execution context. It's useful to get information about the current state, for example you can get the value of a variable named `i` using `exec i`.

That's quite a few commands to remember, thankfully you can also use the `help` command to show the complete list of available commands. To exit the debugger at any time, press `CTRL + D` or type the command `.exit`.
