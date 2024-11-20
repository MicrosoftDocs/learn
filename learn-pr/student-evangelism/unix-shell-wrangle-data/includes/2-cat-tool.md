Here we'll use the `cat` command to display, create, and concatenate files. This command is useful when you do complex data wrangling.

The `cat` command is one of the most basic yet useful commands for working with files. It has three main functions when it comes to text files: display their content, create new files, and combine copies.

## Display content

The `cat` command is most commonly used to read the content of files. Its default output destination, which is also known as a standard output, or `stdout`, is the monitor screen. To display the content of a file, you would enter `cat <filename>`.

- Run the `cat` command to display the content of the **NASA-software-API.txt** file:

   ```bash
   cat NASA-software-API.txt
   ```

   Your output should list each line in the file, and end with these lines:

   ```output
   ...
   SSC-00424 SSC 2013-09-06T00:00:00.000 "General Public" "SSC Site Status Mobile Application"
   GSC-14732-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Tool For Interactive Plotting, Sonification, And 3D Orbit Display (TIPSOD)"
   GSC-14730-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Space Physics Data Facility Web Services"
   GSC-14726-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Earth Observing System (EOS) Clearinghouse (ECHO)"
   ```

## Create files

You can use the `cat` command to create files. Using this command is often easier than using a text editor or vi (short for _visual_) editor for small files.

We create new files by redirecting the standard output of the `cat` command with the *output redirect operator* (`>`) followed by the name of the file to create. After you add text, you use Ctrl + D to return to the prompt.

1. Run the `cat` command with the greater than (`>`) operator and the name of the file to create, such as **file1**:

   ```bash
   cat > file1
   ```

1. Add the following text, and then press Enter to move the cursor to a new line.
   
   ```bash
   NASA headquarters
   ```

1. Press Ctrl + D to end the concatenation action and restore the prompt.

1. To append a line to the file without overwriting the existing content, use the double greater than (`>>`) operator with the `cat` command:

   ```bash
   cat >> file1
   ```

1. Add the following text, and then press Enter to move the cursor to a new line.
   
   ```bash
   Goddard Space Flight Center
   ```
      
1. Press Ctrl + D to end the concatenation action and restore the prompt.

1. If you run the `ls` command, you'll see the new file in your directory:

   ```output
   file1   NASA-logs-1995.txt   NASA-software-API.txt
   ```

1. Use the basic `cat` command to show the content of the updated file:

   ```bash
   cat file1
   ```

   You should see this output:

   ```output
   NASA headquarters
   Goddard Space Flight Center
   ```


## Concatenate files

The third use of the `cat` command is to concatenate copies of the contents of files. Because the concatenation occurs only to the copies, there's no effect on the original files.

1. Run the following command to concatenate two copies of file1 to `stdout`:

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

2. If you run the `ls` command now, you'll notice no new file has been added to your directory:

   ```output
   file1   NASA-logs-1995.txt   NASA-software-API.txt
   ```

   The content of each file was displayed to `stdout` starting on a new line and in the order that the files were named in the command. You can also redirect concatenation output to a file. 

1. Run the `cat` command with the greater than (`>`) operator to save the output in a new file, such as  **file2**:

   ```bash
   cat file1 file1 > file2
   ```

1. Examine the contents of the new file:

   ```bash
   cat file2
   ```

   The output should look like this:

   ```output
   NASA headquarters
   Goddard Space Flight Center
   NASA headquarters
   Goddard Space Flight Center
   ```

1. If you run the `ls` command again, you'll see the new file in your directory:

   ```output
   file1   file2   NASA-logs-1995.txt   NASA-software-API.txt
   ```
