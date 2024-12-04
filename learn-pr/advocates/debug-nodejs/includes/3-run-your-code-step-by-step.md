Debugging is a multistage application that usually follows these steps:

1. Identify a bug in your program.
1. Find where the bug is located in your code.
1. Analyze why the bug occurs.
1. Fix the bug.
1. Validate that your fix works.

After you identify an error in your Node.js program, the first challenge you'll face is to find where the error is located in your code. To achieve that, one of the most efficient ways is to run your code step by step to get an idea of where things go wrong.

## Breakpoints

Running through *all* your code step by step might be extremely inefficient if your program has thousands of lines of code. In that case, you can use a *breakpoint*. It allows you to *break* from your program's normal execution and pause at a given *point* in your code.

Using breakpoints, you can make your program run normally up until you reach the critical portion of code where you suspect the error is located. Then you can switch to running step by step.

There are multiple ways of defining breakpoints in your code based on your debugger and code editor. 

## Node.js inspect mode

Because a debugger has full access to the execution environment, a malicious actor could also use it to inject arbitrary code in your Node.js application. That's why, by default, Node.js doesn't allow you to debug a running program. You have to enable a special mode called *inspector* mode to allow debugging.

You need to start your application with the `--inspect` option to allow a debugger _client_ to attach itself to the application and take control of your application execution.

By default, when Node.js is started with the `--inspect` option, it listens on host `127.0.0.1` on port `9229`. You can also specify a custom host and port by using the syntax `--inspect=<HOST>:<PORT>`.

> [!IMPORTANT]
> Avoid binding the Node.js debugger port to a public IP address or to 0.0.0.0. Otherwise, any clients that can connect to your IP address could potentially connect and control your Node.js application. By doing so, an attacker can remotely run arbitrary code on your execution environment. This action could lead to a potentially severe security breach.

As an alternative, you can use the `--inspect-brk` option. It works the same as `--inspect`, but it breaks code execution just before the start of your code. This allows you to attach the debugger and take your time to set breakpoints and step through your code to identify the root cause of the issue. Use this `--inspect-brk` switch when you need to debug: 
* A race condition.
* Intermittent issue that's difficult to reproduce.

After your application is started with inspect mode enabled, you can use any compatible debugger clients to connect to your application process.

## Debugger clients

To debug your application, you need to use a debugger client. A debugger client is a program that connects to your Node.js application and allows you to control its execution. There are many debugger clients available, but the most common ones are:

* **Visual Studio Code**: A graphical debugger client that comes bundled with Visual Studio Code. Use this when debugging during development.
* **node-inspect**: A command-line debugger client that comes bundled with Node.js. Use this when debugging in production.

## Built-in debugger

You can use **node-inspect**, command-line **debugger client**, which comes bundled with Node.js, to debug your Node.js application. It's a simple debugger that allows you to set breakpoints and run your code step by step.

```bash
node inspect <YOUR_SCRIPT>.js
```

The node-inspect debugger runs Node.js with inspect mode enabled and launches at the same time as the integrated interactive debugger. It pauses execution just before your code starts. You should see the debugger prompt that indicates it has successfully launched.

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
