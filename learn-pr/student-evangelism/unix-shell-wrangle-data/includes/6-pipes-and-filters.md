So far, you've been introduced to commands to inspect files, regular expressions, and the stream editor.

We also know now that commands such as `cat` and `grep` have the monitor screen as standard output. In many cases, you'll want to redirect the output to another file, by using the `>` redirect operator, or even to another program that transforms data for further processing. In UNIX, we call these programs [filters](http://www.linfo.org/filters.html).

You might have started to guess by now that it's possible to construct a *pipeline of commands* by stringing together multiple filters. To do so, we can use [pipes](http://www.linfo.org/pipes.html). Pipes are a form of redirection, which allows us to send the output of one program (or filter) to another program for further processing.

For example, you might want to merge the `stdout` and `stderr` streams and then display them on the terminal. You also might want to save the results to a file to examine build issues. You can take these actions by using pipes and filters.

Let's see some examples of pipes and filters by using the commands you've already learned in the previous units.

1. Here's a simple pipe from the `cat` command to the `nl` command by using the `NASA-software-APi.txt` file:

    ```bash
     cat NASA-software-API.txt | nl
    ```

1. Count the number of words in all `.txt` files in a directory, and sort the output in ascending order:

    ```bash
    wc -l  *.txt | sort -n
    ```

    Notice how we're using the wildcard `*.txt` to indicate *all files ending in .txt*.

1. Now what about displaying only the first line of the preceding command?

   ```bash
   wc -l  *.txt | sort -n | head -n 1
   ```

1. Number the lines in `NASA-software-API.txt`, filter the first five lines, and then sort them in reverse order:

   ```bash
     nl -s = NASA-software-API.txt | head -n 5 | sort -r
   ```

1. Revisiting from the `sed` unit:

    1. Use the `grep` command to find the first 10 lines that contain `NASA` in the `NASA-software-APi.txt` file.
    2. Sort the output in reverse order.
    3. Replace `NASA` for `National Aerospace Agency` (replicating grep's behavior).

    ```bash
    grep -m10 'NASA' NASA-logs-1995.txt | sort -r | sed -n s'/NASA/National Aerospace Agency/p'
    ```

As you can see in the preceding examples, we can build many different pipelines with just a few commands. This module briefly introduced you to different kinds of tools and commands. But this introduction should be enough to get you started with data wrangling in the UNIX shell.

## Summary

Some of the key takeaways from this module are:

- The `cat` command allows you to display, concatenate, and append files.
- Pipes (`|`) send the output of one command as input of another command.
- A filter takes input from one command, does some processing, and gives an output.
- Regular expressions (regex) are used for pattern matching and can be used by other commands and tools, such as `sed` and `grep`.
- The `grep` command can be used to find strings and values in a text file.
- Piping through `grep` is one of the most common uses.
- The most common use of the stream editor (`sed`) is text substitution.
