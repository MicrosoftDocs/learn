Here we'll use the `cat` command to display, create, and concatenate files. This command is useful when you do complex data wrangling.

The `cat` command is one of the most basic yet useful commands for working with files. It has three main functions when it comes to text files: display their content, create new files, and combine copies.

## Display content

The `cat` command is most commonly used to read the content of files. Its default output destination, which is also known as a standard output, or `stdout`, is the monitor screen. To display the content of a file, you would input `cat <filename>`.

Run the `cat` command to display the contents of `NASA-software-API.txt`.

```bash
cat NASA-software-API.txt
```

## Create files

You can use the `cat` command to create files. Using this command is often easier than using a vi or text editor for small files.

Create new files by redirecting the standard output of the `cat` command by using the *output redirect operator* `>` followed by the name of the file to be created. Then select <kbd>ENTER</kbd>, and finally simultaneously select <kbd>CTRL+D</kbd>.

1. Run the `cat` command followed by the `>` operator and the file name, `file1`.

   ```bash
   cat > file1
   ```

1. Select <kbd>ENTER</kbd> to place the cursor at a new line.
1. Enter some text, in this case, **NASA headquarters**. Then select <kbd>ENTER</kbd>.
1. End the program and restore the command prompt by selecting <kbd>CTRL+D</kbd>. If `file1` exists, it will be overwritten.

1. To append a line to the existing file without overwriting, you can use the `>>` operator. For example, to add `Goddard Space Flight Center` to `file1` you would first run:

     ```bash
     cat >> file1
     ```

1. Select <kbd>ENTER</kbd>, and then add the next line:

     ```bash
     Goddard Space Flight Center
     ```

1. Select <kbd>ENTER</kbd>, then <kbd>CTRL+D</kbd> to complete the command.

## Concatenate files

The third use of the `cat` command is to concatenate copies of the contents of files. Because the concatenation occurs only to the copies, there's no effect on the original files.

For example, to concatenate two copies of the `file1` we created before, you would run the following command:

```bash
cat file1 file1
```

Your output should look something like this:

```output
NASA headquarters
Goddard Space Flight Center
NASA headquarters
Goddard Space Flight Center
```

If you run the command `ls` again, you'll see that the new files have been added to your directory:

```output
file1 NASA-logs-1995.txt NASA-software-API.txt
```

The contents of each file will be displayed on the `stdout` starting on a new line and in the order that the file names appear in the command. You can also redirect this output to a second file, `file2`.

```bash
cat file1 file1 > file2
```
