In this section, you'll create and run a simple Hello World Node.js script.

## Node.js REPL

Node.js has a built-in REPL mode (Read Eval Print Loop). This is an interactive console environment where you can enter JavaScript code, have Node.js interprets it and executes it and prints the output. 

Node.js will:

- **Read**: reads and parses the user's input JavaScript code (or show an error if the code is invalid).
- **Eval**: evaluates the entered JavaScript code.
- **Print**: prints the computed results.
- **Loop**: loop and wait for the user to enter a new command (or exit if the user hits **ctrl-c** twice)

The REPL mode is useful for quick code evaluation and experimentation!

To start the REPL mode by running the `node` program in the Azure Cloud Shell.

```bash
node
```

You will then see the REPL environment up and running. You should have the following output:

```text
> 
```

Try typing the following code `console.log('Hello World, from the REPL.')` inside the REPL and see the output. This code will print a "Hello World, from the REPL." message in the REPL's output:

```text
> console.log('Hello World, from the REPL.')
Hello World, from the REPL.
```

To exit the REPL, hit **ctrl-c** twice:

```text
>
(To exit, press ^C again or type .exit)
>
```

## Creating a Node.js script

Node.js does also support running code from files. Using Azure Cloud Shell, open a new editor by entering the `code` command:

```bash
code
```

Inside the shell code editor, create a file with the following code:

```javascript
console.log('Hello World, from a script file.');
```

Save the file with `Ctrl+S` (Windows, Linux) or `Cmd+S` (Mac) under `index.js`.

Then, from the command-line shell, enter `node` followed by the name of the file, in this case, `index.js`:

```bash
node index.js
```

You should get the following output:

```text
$ node index.js
Hello World, from a script file.
```

Congratulations! You just run your first Node.js code.
