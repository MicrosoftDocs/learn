# Processes

To work with process we will need to use the module `child_process`. This module allows us to spawn processes. To ensure we don't block the Node.js event-loop we want to spawn up new processes using the method `spawn()`. There is a synchronous version of this ending in `Sync`, but usually we want to avoid blocking in Node.js as much as we can.

By default, pipes for `stdin`, `stdout`, and `stderr` are created  between the parent Node.js process and the spawned child. This means we have access to the mentioned streams and can therefore listen to events being produced by any of these streams.

## Process creation

There are four ways a process an be created

- `spawn()`,  this spawns up a new process using the given command. It takes an array of argument as the second argument and the third argument is an optional `options` object
- `exec()`, this method spawns a shell and runs the provided command within that shell, it takes a callback function that is invoked when the command completes passing the streams `stdout` and `stderr`
- `execFile()`, this executes the command directly without spawning a shell
- `fork()`, this spawns a new Node.js process and invokes a specified module with an IPC communication channel established that allows sending messages between parent and child

All of the above methods comes with synchronous version that will block the event loop.

## Working with our child process

So what can we do with a process we spawn up?

Well, we can create a process that runs a Bash command and capture the result. Then we can listen to the emitted result and incorporate that as part of our Node.js program. Consider the below code:

```javascript
const { spawn } = require('child_process');
const ls = spawn('ls', ['-lh']);
```

Here we are using the method `spawn()` from the `child_process` module and we are able to the following command to our terminal.

```bash
ls -lh
```

The above doesn't capture the output though. For that we need to listen to an event `data`. However let's first have a closer look at `ls` variable. It exposes two stream for us `stdout` and `stderr`. It is on each of these streams that we will listen to the `data` event to capture the output from our command, depending on whether it succeeded or failed. Let's also listen to the `close` event so we know when the command has finished executing.

Add the following code:

```javascript
ls.stdout.on('data', (data) => {
  console.log(`stdout: ${data}`);
});

ls.stderr.on('data', (data) => {
  console.error(`stderr: ${data}`);
});

ls.on('close', (code) => {
  console.log(`child process exited with code ${code}`);
});
```

This should produce output data looking like so:

```bash
-rw-r--r--  1 <user>  <group>   <size> <date> <name of app file>
```
