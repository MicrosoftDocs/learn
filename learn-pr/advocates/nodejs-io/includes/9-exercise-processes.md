- Learn how to invoke a command with arguments
- Running executable files, `exec()` vs `execFile()`
- Understand parent/child communication with `fork()`

## Spawn a process

In this exercise, you'll learn how to spawn up a process and also invoke a command with arguments.

First, create an application file to work in, the suggestion is calling it `app.js`.

Now, add the following code:

```javascript
const { spawn } = require('child_process');
```

This will import the module `child_process`. From there, you'll use the method `spawn()` that will create a shell. You need to provide it with a command so that's up next:

```javascript
const ls = spawn('ls', ['-lh']);
```

Above you're invoking `ls` with the argument `-lh`. All arguments sent to a command should be placed in the second parameter that is an array.

Next, you need to listen to the results. For that you'll work with the stream `stdout` on your resulting object `ls`, like so:

```javascript
ls.stdout.on('data', (data) => {
  console.log(`stdout: ${data}`);
});
```

Additionally you want to listen to any errors your command might cause so let's add that code:

```javascript
ls.stderr.on('data', (data) => {
  console.error(`stderr: ${data}`);
});
```

Note, how you subscribe to the event `data` on the `stderr` stream.

Finally listen to the event `close` that reports when the command has finished:

```javascript
ls.on('close', (code) => {
  console.log(`child process exited with code ${code}`);
});
```

Now run this code with the following command:

```bash
node <name of your app file>.js
```

This should produce the following output (exact output might vary)

```bash
rw-r--r--  1 <user>  <group>   311B 17 Mar 21:23 <name of your app file>.js
```

## Running executable files

You've dedicated methods on the `child_process` module that runs commands. Generally the `exec()` method is preferred, over `execFile()` as it doesn't create a shell and thereby is less resource intensive. However that's only possible on Linux. On Windows, `.cmd` and `.bat` files are only allowed to run in a shell so therefore `execFile()` is the only choice.

### Prerequisites for Linux

Create a file `command.sh`, give it for example a content like this:

```bash
# lists files and some other info
ls -la
```

Now give the file permission to execute:

```bash
chmod +x command.sh
```

Lastly execute the file using `bash` or `sh` like so:

```bash
sh command.sh
```

This should output all the files in your directory with some added info on permissions, size, creation dates and more

### Prerequisites for Windows

Create a file `mycommand.bat`, give it for example a content like this:

```bash
# lists files and some other info
dir
```

Lastly execute the file like so (file ending can be omitted):

```bash
mycommand
```

### Invoke command from code

Add the following code to your application file:

```javascript
const { exec } = require('child_process');

const process = exec('sh command.sh', (err, stdout, stderr) => {
  if (stderr) {
    console.error(`Error: ${err.message}`)
  } else {
    console.log(`Output: ${stdout}`)
  }
})

process.on('close', (code) => {
  console.log(`Process closed with code: ${code}`);
})
```

Now run this code with the following command:

```bash
node <name of your app file>.js
```

This should produce the following output (exact output might vary)

```bash
rw-r--r--  1 <user>  <group>   311B 17 Mar 21:23 <name of your app file>.js
```

### Parent/child communication with `fork()`

Using the `fork()` method spawns a new Node.js process and invokes a specified module with an IPC communication channel established. This allows sending messages between parent and child. Demonstrate this communication by doing the following:

- Create a file `parent.js`
- Create a file `child.js`

Now give `parent.js` the following content:

```javascript
// parent.js

const cp = require('child_process');
const path = require('path');
const childPath = path.join(__dirname, 'child.js');

const process = cp.fork(childPath);

```

Above you can see how we create a child process using the method `fork()` given the file `child.js`. You've now additionally established a communication with said process and next step is to listen to messages from it. Add the following to listen to the `message` event:

```javascript
process.on('message', (message) => {
  console.log('PARENT got message:', message);
});
```

This is a two-way communication so you can set up to listen to message from the child process as well with this code:

```javascript
// Causes the child to print: CHILD got message: { hello: 'world' }
process.send({
  hello: 'world'
});
```

Next, give the file `child.js` the following content:

```javascript
// child.js

process.on('message', (message) => {
  console.log('CHILD got message:', message);
});

// Causes the parent to print: PARENT got message: { message: 'from child' }
process.send({ message: 'from child' });
```

Now run this code with the following command:

```bash
node parent.js
```

This should produce the following output (exact output might vary)

```bash
CHILD got message: { hello: 'world' }
PARENT got message: { message: 'from child' }
```
