The stream editor (`sed`) is a useful text parsing and manipulation tool. It can be used to do transformations on text that comes from the standard input or a file. The `sed` tool edits the text line by line and in a noninteractive way. In this way, you make the decisions as you call the command. These directions are executed automatically. This capability makes `sed` a powerful and fast tool to transform text.

## Basic usage

The `sed` tool operates on text from the `stdin` or from a file. This behavior allows you to send the output of another command directly into `sed` for editing. You can also work from a file that you've previously created or edited.

Remember that `sed` outputs everything to `stdout` by default. If you want to save the edited text, you'll need to redirect the output by using the redirect operator (`>`) as we did with the `cat` command.

The basic usage of `sed` is `sed [options] commands [file-to-edit]`.

For example, to use `sed` directly on the `NASA-software-API.txt` file, you would run the command as follows:

```bash
sed '' NASA-software-API.txt
```

This command will print the content of the file to the `stdout`. It's almost equivalent to using the command `cat`. The single quotation marks contain the editing commands you pass to `sed`. In this case, you passed it nothing, so `sed` printed each line it received to standard output.

The `sed` tool can also use the `stdin` rather than a file. You can pipe the output of the `cat` command into `sed` to produce the same result:

```bash
cat NASA-software-API.txt | sed ''
```

## Text substitution with sed

Text substitution is perhaps the most well-known use for `sed`. As we learned before, `sed` can search for test patterns by using regular expressions. But `sed` can also replace the matched text with something else.

The basic syntax for text substitution is `sed s'/old_text/new_text/'`, where `s` is the substitute command and the three forward slashes (`/`) are used to separate the text fields.

Imagine that you have the URL https://www.nasa.gov/about/sites/index.html, and you want to replace `index.html` with `home`. You can make this replacement by using the following command:

```bash
echo "https://www.nasa.gov/about/sites/index.html" | sed s'/index.html/home/'
```

The output shows the modified URL:

```output
https://www.nasa.gov/about/sites/homes
```

Let's replace the `NASA` occurrences for *National Aerospace Agency* in the `NASA-software-API.txt` file:

```bash
 sed 's/NASA/National Aerospace Agency/' NASA-software-API.txt
```

You'll notice that the substitution happened on all matches for NASA, but the command `sed` printed out all the lines in the file. This behavior is the default for the `sed` tool.

Let's say we only want to print the lines in which the pattern was replaced. We can use the flag `-n` to suppress automatic printing and pass the option `p` to the replacement flag, like so:

```bash
sed -n 's/NASA/National Aerospace Agency/p' NASA-software-API.txt
```

## Write to a file

There's one more flag that can follow the third delimiter. With it, you can specify a file that will receive the modified data. In the following example, we'll write all lines in which we replaced `NASA` before:

```bash
sed -n 's/NASA/National Aerospace Agency/w NASA-replaced.txt' NASA-software-API.txt
```

You should now have the new file `NASA-replaced.txt`.
