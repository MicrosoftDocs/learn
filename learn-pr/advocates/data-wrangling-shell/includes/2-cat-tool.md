Here we will use the command `cat` to create, display and concatenate files. This will be reall useful when performing complex data wrangling.
# The `cat` command

The `cat` command is one of the most basic yet useful commands for working with files. It has three main functions when it comes to text files: display their content, combine copies, and create new files.
## Reading files 

The most common use of `cat` is reading the content of files. Its default output destination (a.k.a standard output or`stdout`) is the monitor screen. For example, to display the content of a file named `file1`:
```bash
cat file1
```

1. Run the command `cat` to display the contents of `NASA-software-API.txt`

```bash
cat NASA-software-API.txt
```
## File creation 

`cat` can  be used to create files and it is often easier than vi or text editors for small files.

You can create new files by redirecting the standard output of the `cat` command using the *output redirect operator* `>` followed by the name of the file to be created. Then pressing <kbd>ENTER</kbd> and finally simultaneously pressing <kbd> CTRL + d </kbd>.
Let's see this in practice!

1. Run the command `cat` followed with the `>` operator and the file name (file1):
```bash
cat > file1
```
1. Press <kbd> ENTER</kbd>, this will place the cursor at a new line
1. Type some text, in this case: `NASA headquarters` followed by <kbd> ENTER</kbd>.
2. Terminate the program and restore the command prompt by pressing <kbd> CTRL + d </kbd>

Note that if there is an existing `file1` this will be completely overwritten. To append a line to the existing file `file1` without overwritting you can use the `>>` operator. For example to add `Goddard Space Flight Center` to `file1` you'd run:

```bash
cat >> file1
Goddard Space Flight Center
```

## Concatenating files

The third use of `cat` is the concatenation of copies of the contents of files. Because the concatenation occurs only to the copies, there is no effect on the original files.

For example, to concatenate two copies of the `file1` we created before you'd run the following command;
```bash
cat file1 file1
```

Your output should look similar to this:
```output
NASA headquarters
NASA headquarters
```

The contents of each file will be displayed on the `stdout` starting on a new line and in the order that the file names appear in the command. You can also redirect this output to a second file `file2`:

```bash
cat file1 file1 > file2
```