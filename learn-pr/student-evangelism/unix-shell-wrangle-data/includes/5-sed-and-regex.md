The stream editor (`sed`) is a useful text parsing and manipulation tool. It can be used to do transformations on text that comes from the standard input or a file. The `sed` tool edits the text line by line and in a noninteractive way. In this way, you make the decisions as you call the command. These directions are executed automatically. This capability makes `sed` a powerful and fast tool to transform text.

## Basic usage

The `sed` tool operates on text from `stdin` or from a file. This behavior allows you to send the output of another command directly into the `sed` tool for editing. You can also work from a file that you've previously created or edited.

Remember that the `sed` command outputs everything to `stdout` by default. If you want to save the edited text, you need to redirect the output by using the redirect operator (`>`) as we did with the `cat` command.

The basic usage of `sed` is `sed [options] commands [file-to-edit]`.

To use `sed` directly on the **NASA-software-API.txt** file, you would run the command as follows:

```bash
sed '' NASA-software-API.txt
```

This command prints the content of the file to the `stdout`. It's almost equivalent to using the `cat` command. The single quotation marks contain the editing instructions you pass to `sed`. In this case, no editing instructions were passed, so `sed` printed each line it received to standard output.

The `sed` tool can also use `stdin` rather than a file. You can pipe the output of the `cat` command into the `sed` command to produce the same result:

```bash
cat NASA-software-API.txt | sed ''
```

## Text substitution with sed

Text substitution is perhaps the most well-known use for the `sed` tool. As we learned before, the `sed` command can search for test patterns by using regular expressions. But the tool can also replace the matched text with something else.

The basic syntax for text substitution is `sed s'/old_text/new_text/'`, where the letter `s` is the editing instruction that means *substitute* and the three forward slashes (`/`) separate the text fields to use in the substitution.

Imagine you have the URL `https://www.nasa.gov/about/sites/index.html`. You want to replace the `index.html` portion of the URL with the text `home`. You can make this replacement by using the following `sed` command:

```bash
echo "https://www.nasa.gov/about/sites/index.html" | sed s'/index.html/home/'
```

The output shows the modified URL:

```output
https://www.nasa.gov/about/sites/homes
```

Let's try this replacement on content in the **NASA-software-API.txt** file. We'll substitute all instances of the abbreviation "NASA" with the full title "National Aerospace Agency." Before we make the substitution, we'll get a count of the number of instances of the abbreviation "NASA." After we run the `sed` tool, we'll get a count of the number of instances of the full title "National Aerospace Agency" to ensure all instance of the abbreviation were replaced.

1. Open the NASA-software-API.txt file in the Cloud Shell editor:

    ```bash
    code NASA-software-API.txt
    ```

1. Open the search box for the integrated editor, and select the **regex** icon (**`.*`**) to enable regex pattern match searching.

1. In the search box, enter the string `NASA`.

   The search box result shows 27 matches for the abbreviation "NASA."
   
1. Now run the `sed` command to do the replacement:

   ```bash
   sed 's/NASA/National Aerospace Agency/' NASA-software-API.txt
   ```

   Notice that the substitution happens on all matches for NASA, but the command prints all lines of the file to the terminal (`stdout`). This behavior is the default for the `sed` tool.

   To print only those lines where replacement is applied, we can use the `-n` flag. We also pass the `p` option to suppress automatic printing.

1. Run the `sed` command again, but this time, print only the lines where the pattern replacement is applied:

   ```bash
   sed -n 's/NASA/National Aerospace Agency/p' NASA-software-API.txt
   ```


## Write to a file

One of the most common uses of the `sed` tool is to capture the results of the parsing or editing operation. In the previous examples, we were limited in our ability to verify the command results. We could only see the output of the command as shown in the terminal. 

There's another flag can we can use after the third delimiter in the `sed` command to resolve this issue. The `w` flag let's us specify a file to receive the modified data from the command.

Let's try the previous command again. This time, we'll write all content modified by the `sed` command to a new file.

1. Run the `sed` command to print only the lines that are replaced, and send the modified data to a new file, such as **NASA-replaced.txt**:

   ```bash
   sed -n 's/NASA/National Aerospace Agency/w NASA-replaced.txt' NASA-software-API.txt
   ```

1. Run `ls` to see the new file in your directory.

   ```output
   file1    file2    NASA-logs-1995.txt    NASA-replaced.txt    NASA-software-API.txt
   ```

1. Open the new file in the Cloud Shell editor.

   You should see 27 lines in the file. The last line should be empty.
