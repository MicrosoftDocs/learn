As a Node.js developer on Tailwind Traders the REPL can really be a great tool if you want is to test out a few commands without having to start up a full Node.js application.

All we need for this set of exercise is Node.js installed on our system and a terminal window started. Let's go!

## Starting/exiting our REPL

The REPL in Node.js is started by typing `node` in the terminal. You should see something like this in your terminal:

```bash
Welcome to Node.js v12.16.2.
Type ".help" for more information.
>
```

If this is what you see, then all is well and you are ready to carry out some commands.

The REPL indicates we should type `.help` for more info. Let's do that:

```bash
.help
```

The output of running that command is:

```bash
> .help
.break    Sometimes you get stuck, this gets you out
.clear    Alias for .break
.editor   Enter editor mode
.exit     Exit the repl
.help     Print this help message
.load     Load JS from a file into the REPL session
.save     Save all evaluated commands in this REPL session to a file

Press ^C to abort current expression, ^D to exit the repl
```

The above shows us the basic set of commands that exist. We see that there exist two ways how we can exit the REPL, namely by typing `.exit` or `^D`. Both ways work.

## Leverage the `.editor` command

This command allows us to treat the REPL like a normal text editor in that we can write multiple lines of code and then have it evaluated. Let's try this out. First type `node` to start the REPL. Now type `.editor`. You should now see the following:

```bash
// Entering editor mode (^D to finish, ^C to cancel)
```

Now add some lines of code, like so:

```bash
var b = [1,2,3];
var joined = b.join('')
console.log(joined);
```

Type `Ctrl + D` (^D) to have it all evaluated and you should see:

```bash
123
```

## Auto complete

A feature we almost take for granted in IDEs is auto completion. The ability to start typing on a command and have the system suggest a list of possible commands you are trying to write. Such a functionality save a couple of keystrokes. It exist in the Node.js REPL as well. All you have to is to start typing on a command and hit the tab key. To see this in action ensure your Node REPL is running by first typing `node` and the return key.

Now type `con` in the terminal and hit the tab key. The REPL should now list all keywords and commands starting with `con`. You should get the following output:

```bash
> con
const        continue     

console      

constructor 
```

As you can see above we get all they keywords we can use starting with the word `con`.

## Load scripts

We've seen so far how we can enter single statements in the REPL but also multiline statements via the `.editor` command. We can also load in an entire script file into our REPL. Create a file `scripts.js` with the following content:

```javascript
let nameObject = { name: 'chris' };
let addressObject = { address: 'london' };
let mergedObject = { ...nameObject, addressObject };
```

Now start up your REPL by typing `node`. Next type the following command:

```bash
.load script.js
```

You will get an output looking like so:

```javascript
> .load script.js
let nameObject = { name: 'chris' };
let addressObject = { address: 'london' };
let mergedObject = { ...nameObject, addressObject };
```

Now our REPl environment know all about the variables we declared in `script.js`. You can test that by typing the following:

```bash
console.info(mergedObject)
```

It should render the following output:

```bash
{ name: 'chris', addressObject: { address: 'london' } }
```
