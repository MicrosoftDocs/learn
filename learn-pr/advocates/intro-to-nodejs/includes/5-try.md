In this unit, you'll create and run a simple Hello World Node.js script.

## Node.js REPL

Node.js has a built-in read-eval-print loop (REPL) mode that's useful for quick code evaluation and experimentation. REPL mode is an interactive console environment where you can enter JavaScript code and have Node.js interpret and run the code and then print the output.

The Node.js REPL mode works as follows:

- **Read**: Reads and parses the user's JavaScript code input (or shows an error if the code is invalid).
- **Eval**: Evaluates the entered JavaScript code.
- **Print**: Prints the computed results.
- **Loop**: Loops and waits for the user to enter a new command (or exits if the user enters **ctrl-c** twice).

To start REPL mode, run the `node` program in Azure Cloud Shell:

```bash
node
```

The REPL environment opens. You should see the following output:

```text
>
```

Try typing the code `console.log('Hello World, from the REPL.')` inside the REPL console and view the output. This code prints a "Hello World, from the REPL." message in the REPL output:

```text
> console.log('Hello World, from the REPL.')
Hello World, from the REPL.
```

To exit the REPL environment, enter **ctrl-c** twice:

```text
>
(To exit, press ^C again or type .exit)
>
```

## Create a Node.js script

Node.js also supports running code from files.

1. Using Azure Cloud Shell, open a new editor by entering the `code` command:

   ```bash
   code
   ```

1. Inside the shell code editor, create a file by entering the following code:

   ```javascript
   console.log('Hello World, from a script file.');
   ```

1. Save the file by entering `Ctrl+S` (Windows, Linux) or `Cmd+S` (macOS) under `index.js`.

1. In the command-line shell, enter `node` followed by the name of the file, in this case `index.js`:

   ```bash
   node index.js
   ```

You should see the following output:

```text
$ node index.js
Hello World, from a script file.
```

You have now run your first Node.js JavaScript code.
