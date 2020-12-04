# Introduction to the stream editor (`sed`)

The stream editor (`sed`) is a useful text parsing and manipulation tool. It can be used to do transformations on text coming from the standadrd input or a file. `sed` edits the text line-by-line and in a non-interactive way. This means you make the decisions as you call the command and these directions are executed automatically. This makes `sed` a powerful and fast tool to transform text.

## Basic usage

`sed` operates on text from the `stdin` or from a file. This allows you to send the output of another command directly into `sed` for editing or you can work from a file that you have previously created or edited. 

Remember that `sed` outputs everything to `stdout` by default, so if ou want to save the edited text, you'll need to redirect the output using the redirect operator (`>`) as we did with the `cat` command.

The basic usage of `sed` is:

```bash
sed [options] commands [file-to-edit]
```

For example, to use `sed` directly on the `NASA-software-API.txt` file you'd run the command as follows:

```bash
sed '' NASA-software-API.txt
```

This will print the content of the file to the `stdout`. Pretty much as if you were calling `cat`. The single quotes contain the editing commands you pass to `sed`. In this case, you passed it nothing, so `sed` printed each line it received to standard output.

`sed` can also use the `stdin` rather than a file. You can pipe the output of the `cat` command into `sed` to produce the same result:

```bash
cat NASA-software-API.txt | sed ''
```

## Substituting text

Text substitution is perhaps the most well-known use for `sed`