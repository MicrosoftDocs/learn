# Introduction to the stream editor (`sed`)

The stream editor (`sed`) is a useful text parsing and manipulation tool. It can be used to do transformations on text coming from the standard input or a file. `sed` edits the text line-by-line and in a non-interactive way. This means you make the decisions as you call the command and these directions are executed automatically. This makes `sed` a powerful and fast tool to transform text.

## Basic usage

`sed` operates on text from the `stdin` or from a file. This behavior allows you to send the output of another command directly into `sed` for editing or you can work from a file that you've previously created or edited.

Remember that `sed` outputs everything to `stdout` by default, so if you want to save the edited text, you'll need to redirect the output using the redirect operator (`>`) as we did with the `cat` command.

The basic usage of `sed` is:

```bash
sed [options] commands [file-to-edit]
```

For example, to use `sed` directly on the `NASA-software-API.txt` file you'd run the command as follows:

```bash
sed '' NASA-software-API.txt
```

This command will print the content of the file to the `stdout`. It's almost equivalent to using the command `cat`. The single quotes contain the editing commands you pass to `sed`. In this case, you passed it nothing, so `sed` printed each line it received to standard output.

`sed` can also use the `stdin` rather than a file. You can pipe the output of the `cat` command into `sed` to produce the same result:

```bash
cat NASA-software-API.txt | sed ''
```

## Text substitution with sed

Text substitution is perhaps the most well-known use for `sed`. As we learned before, `sed` can search for test patterns using regular expressions. But `sed` can also replace the matched text with something else.

The basic syntax for text substitution is:

```bash
sed s'/old_text/new_text/'
```

The `s` is the substitute command and the three forward slashes `/` are used to separate the text fields.

Imagine you have a URL (https://www.nasa.gov/about/sites/index.html) and you want to replace `index.html` with `home`. You can achieve this with the following command:

```bash
echo "https://www.nasa.gov/about/sites/index.html" | sed s'/index.html/home/'
```

The output shows the modified URL:

```output
https://www.nasa.gov/about/sites/homes
```

Let's replace the `NASA` occurrences for 'National Aerospace Agency' in the `NASA-software-API.txt` file:

```bash
 sed 's/NASA/National Aerospace Agency/' NASA-software-API.txt
```

You'll notice that the substitution happened on all matches for NASA but the command `sed` printed out all of the lines in the file. This is the default behavior of `sed`.

Let's say we only want to print the lines in which the pattern was replaced. We can use the flag `-n` to suppress automatic printing and pass the option `p` to the replacement flag, like so:

```bash
sed -n 's/NASA/National Aerospace Agency/p' NASA-software-API.txt
```

## Writing to a file

There's one more flag that can follow the third delimiter. With it, you can specify a file that will receive the modified data. An example is the following, which will write all lines in which we replaced `NASA` before:

```bash
sed -n 's/NASA/National Aerospace Agency/w NASA-replaced.txt' NASA-software-API.txt
```

You should now have a new file `NASA-replaced.txt`.
