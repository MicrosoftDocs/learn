Debugging is a multi-stage process that usually goes along these lines:

1. Identify a bug in your program.
1. Find where the bug is located in your code.
1. Analyze why the bug occurs.
1. Fix the bug.
1. Validate that your fix works.

After you identify an error in your Node.js program, the first challenge you will be facing is to find where the error is located is your code. To achieve this one of the most efficient way is to run your code step-by-step to get at idea of where things start to go wrong.

## Breakpoints

Though, running through *all* your code step-by-step might be extremely inefficient if you program have thousands of lines of code. In that case, you can use a **breakpoint**. It allows you to *break* from your program normal execution and pause at a given *point* in your code.

Using breakpoints you can make your program running normally, up until your reach the critical portion of code where you suspect the error is and switch to step-by-step.

There are multiple ways of defining breakpoints in your code depending of your debugger and code editor, but there is one universal way to force any JavaScript debugger to pause at a given point: using the `debugger` statement.

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

As a debugger have full access to the execution environment, a malicious actor could also use it to inject arbitrary code on your Node.js process. That's why by default Node.js does not allow you to debug a running program, you have to enable a special mode called **inspector** mode to allow debugging.

You need to use the `--inspect` option to allow a Node.js process to listen for a debugger client that will attach itself to the process and take control of your program execution.

By default, when Node.js is started with the `--inspect` option it will listen on host `127.0.0.1` on port `9229`. You can however specify a custom host and port using `--inspect=<HOST>:<PORT>`.

> [!IMPORTANT]
> You should avoid binding the Node.js debugger port to a public IP address or to 0.0.0.0, otherwise any clients that can connect to your IP address could potentially connect and control your Node.js process. By doing so an attacker can remotely run arbitrary code on your execution environment, leading to a potentially severe security breach.

As an alternative, you can use the `--inspect-brk` option that works the same as `--inspect` but breaks code execution just before the start of your code.

After Node.js is started with inspect mode enabled, you can use any compatible debugger clients to connect to your Node.js process.

## Built-in debugger

For example, you can use [node-inspect](https://github.com/nodejs/node-inspect), a command-line debugger that comes bundled with Node.js. You can use it by running your program like this:

```sh
node inspect <YOUR_SCRIPT>.js
```

It will run Node.js with inspect mode enabled and at the same time launch the integrated interactive debugger, and pause execution just before your code starts.

TODO: commands

cont
step,
out
sb()
cb()
repl