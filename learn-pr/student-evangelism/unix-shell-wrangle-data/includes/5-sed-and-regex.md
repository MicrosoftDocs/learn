The stream editor (`sed`) is a useful text parsing and manipulation tool. It can be used to do transformations on text that comes from the standard input or a file. The `sed` tool edits the text line by line and in a noninteractive way. In this way, you make the decisions as you call the command. These directions are executed automatically. This capability makes `sed` a powerful and fast tool to transform text.

## Basic usage

The `sed` tool operates on text from `stdin` or from a file. This behavior allows you to send the output of another command directly into the `sed` tool for editing. You can also work from a file that you've previously created or edited.

Remember that the `sed` command outputs everything to `stdout` by default. If you want to save the edited text, you need to redirect the output by using the redirect operator (`>`) as we did with the `cat` command.

The basic usage of `sed` is `sed [options] commands [file-to-edit]`.

- Try this basic `sed` command on the **NASA-software-API.txt** file:

   ```bash
   sed '' NASA-software-API.txt
   ```

The command prints the content of the file to `stdout` in a similar manner to what we saw with the `cat` command. The single quotation marks contain the editing instructions for the `sed` command. In this case, we didn't pass any editing instructions, so the command printed each line it received to the terminal. 

The `sed` tool can work on input from `stdin` rather than a file, and you can also save the output from the command. 


## Text substitution with sed

Text substitution is perhaps the most well-known use for the `sed` tool. As we learned before, the `sed` command can search for test patterns by using regular expressions. But the tool can also replace the matched text with something else.

The general syntax for text substitution is `sed s'/old_text/new_text/'`, where the letter `s` is the editing instruction that means *substitute* and the forward slashes (`/`) separate the text to use in the substitution.

Imagine you have the URL `https://www.nasa.gov/about/sites/index.html` and you want to replace the `index.html` portion of the URL with the text `home`. 

- Try this replacement by using the following `sed` command:

   ```bash
   echo "https://www.nasa.gov/about/sites/index.html" | sed s'/index.html/home/'
   ```

   The output shows the modified URL:

   ```output
   https://www.nasa.gov/about/sites/home
   ```

Let's try some replacement operations on content in the **NASA-software-API.txt** file.

We'll substitute all instances of the abbreviation "NASA" with the full title "National Aerospace Agency." Before we make the substitution, we'll get a count of the number of instances of the abbreviation "NASA." After we run the `sed` tool, we'll check the count to make sure all instances were replaced.

1. Open the NASA-software-API.txt file in the Cloud Shell editor:

    ```bash
    code NASA-software-API.txt
    ```

1. Open the search box for the integrated editor, and enter the string `NASA`.

   The search box result shows 27 matches for the abbreviation "NASA."

   > [!Tip]
   > To reduce the amount of space used by the Cloud Shell editor, you can use the content divider that separates the editor from the terminal. If you make this adjustment, you'll have more space in the terminal to see command output.
   
1. Now run the `sed` command to do the replacement:

   ```bash
   sed 's/NASA/National Aerospace Agency/' NASA-software-API.txt
   ```

   Notice the substitution happens on all matches for "NASA," but the command prints all lines of the file to the terminal (`stdout`). This behavior is the default for the `sed` tool.

   To print only the lines where a replacement was applied, we can use the `-n` flag. We also pass the `p` option in the editing instructions to suppress automatic printing.

1. Run the `sed` command again, and print only the lines where the pattern replacement is applied:

   ```bash
   sed -n 's/NASA/National Aerospace Agency/p' NASA-software-API.txt
   ```

   We see less output this time because we used the `-n` flag and the `p` option.


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

   You should see 26 lines of content in the new file.


## Challenge

If you use the search box to look for the string "NASA" in the new file, you'll notice one remaining instance of the abbreviation. Our call to the `sed` command made only 26 substitutions.
   
One line in the NASA-software-API.txt file had two instances of the "NASA" abbreviation. Our call to the `sed` command successfully replaced the first instance. The second instance of "NASA" appears within the term "NASAViz."

Can you use the commands we've reviewed to make this final replacement?
