REPL stands for **r**ead-**e**val-**p**rint-**l**oop and is a command line tool that allows you to run Node.js commands. Node.js has a very compentent REPl that allows you to do many things. Let's explore what those are.

## Why use a REPL

Using a REPL can be a great way to just run a command to try something out. The alternative would be to author a JavaScript file, write some commands and then run it with the `node` executable. Sometimes you just want to run a few commands. A REPL is limited in what it can do but in the case of Node.js its REPL is really competent. So what can it do for us?

## Features

The Node.js has quite a lot of features

- Evaluate a statement, the REPL can take a statement like `2+2` and evaluate that.
- List all commands, it can also list all the commands available in the core.
- Code completion, just like an IDE, an integrated development environment the REPL helps you complete commands. You start taking a command, press the `tab` key and it lists all commands that matches.
- Show latest result, the REPL can list the latest result through the use of the `_`. Just type the `_` character and the enter key and you will see the latests result.
- Multiline editing, sometimes what you need to write spans over multiple lines. The REPL supports that kind of editing.
- Run script, the REPL not only supports you typing in code and have that evaluated. You can also give it a script file as an argument have the script run.
