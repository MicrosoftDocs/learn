So far, you've learned commands to inspect files, find matches by using regular expressions, and work with the stream editor.

We reviewed that commands like `cat` and `grep` send output to the monitor screen by default (`stdout`). In many cases, it can be helpful to redirect this output to another file by using the greater than (`>`) operator, or to another program that transforms data for further processing. In UNIX, we refer to this type of redirection as a [filter](http://www.linfo.org/filters.html?azure-portal=true).

By now, you might have guessed that it's possible to construct a *pipeline of commands* by stringing together multiple filters. To create this combination, we use the pipe (`|`) symbol to form [pipes](http://www.linfo.org/pipes.html?azure-portal=true). Pipes are a type of redirection that allows us to send the output of one program (or filter) to another program for further processing. 

A pipe is often used to merge the `stdout` and `stderr` streams and display the output on the terminal. Another use of pipes and filters is to save command results to a file to examine build issues. 

Let's try some examples of pipes and filters with commands you learned in the previous units.

1. Use a pipe to add line numbers to the output from the `cat` command:

    ```bash
    cat NASA-software-API.txt | nl
    ```

    The `nl` command adds line numbers to the output. Notice the last line is numbered 700:

   ```output
   ...
   698  GSC-14732-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Tool For Interactive Plotting, Sonification, And 3D Orbit Display (TIPSOD)"
   699  GSC-14730-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Space Physics Data Facility Web Services"
   700  GSC-14726-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Earth Observing System (EOS) Clearinghouse (ECHO)"
   ```

1. Count the number of lines in all .txt files in a directory, and use a pipe to sort the output in ascending order:

    ```bash
    wc -l  *.txt | sort -n
    ```

    The `wc` command counts the number of lines in the content. The `sort` command presents the output in the specified sort order. Notice the asterisk (`*`) wildcard in our input stream `*.txt`, which indicates `all files that end in .txt`.

    There are three text (.txt) files in the **data** directory. The `sort` command shows the three text files in ascending order according to the number of lines in each file. After the list of files, the `wc` command shows the total number of lines for all files reviewed.

    ```output
        26 NASA-replaced.txt
       703 NASA-software-API.txt
    200000 NASA-logs-1995.txt
    200729 total
    ```

1. Run the same command, and add a second pipe to show only the first line of the output:

    ```bash
    wc -l  *.txt | sort -n | head -n 1
    ```

    The `head` command shows the specified number of lines in the content starting from the top of the stream or file.
    
    In this example, only the first line of the output is displayed:

    ```output
        26 NASA-replaced.txt
    ```

1. Use pipes to number the lines in the output, show only the first five lines, and sort the output in reverse order:

    ```bash
    nl -s = NASA-replaced.txt | head -n 5 | sort -r
    ```

    > [!Note]
    > In this example, we use the file created in the previous unit, where we replaced the abbreviation "NASA" with "National Aerospace Agency." In that exercise, we named the file **NASA-replaced.txt**. If you used a different name for your file in that exercise, run this step with your file name.

    Here's the output:

    ```output
    5=ARC-16054-1 ARC 2007-09-28T00:00:00.000 "Open Source" "National Aerospace Agency VisionWorkbench Version 1.2"
    4=ARC-15761-1A ARC 2012-06-04T00:00:00.000 "Open Source" "National Aerospace Agency Vision Workbench (VW) v3 "
    3=ARC-15166-1A ARC 2008-05-02T00:00:00.000 "Open Source" "National Aerospace Agency World Wind Java (WWJ) Software Development Kit (SDK) & 
    2=ARC-15166-1 ARC 2004-01-12T00:00:00.000 "Open Source" "National Aerospace Agency WorldWind Interactive 3D Virtual Globe Software"
    1=ARC-15150-1 ARC 2005-05-23T00:00:00.000 "General Public" "National Aerospace Agency Task Load Index (TLX)"
    ```

    You can try a variation of this example by using the `cat` command and three pipes:

    ```bash
    cat NASA-replaced.txt | nl | head -n 5 | sort -r
    ```

    Do you notice the difference in the output?

1. Create a complex pipeline that uses a `sed` command filter:

    - Use the `grep` command to find the first 10 lines that contain the abbreviation "NASA" in the **NASA-logs-1995.txt** file.
    - Sort the output in reverse order.
    - Replace the "NASA" abbreviation with the full title "National Aerospace Agency," which replicates the action we completed in the previous unit by using the `grep` command.

    ```bash
    grep -m10 'NASA' NASA-logs-1995.txt | sort -r | sed -n s'/NASA/National Aerospace Agency/p'
    ```

    Here's the output:

    ```output
    ***.novo.dk 807951864 GET /images/National Aerospace Agency-logosmall.gif 200 786
    ***.novo.dk 805465157 GET /images/National Aerospace Agency-logosmall.gif 200 786
    ***.novo.dk 805465054 GET /images/National Aerospace Agency-logosmall.gif 200 786
    01-dynamic-c.wokingham.luna.net 809570230 GET /images/National Aerospace Agency-logosmall.gif 304 0
    01-dynamic-c.wokingham.luna.net 806878949 GET /images/National Aerospace Agency-logosmall.gif 304 0
    01-dynamic-c.wokingham.luna.net 805378672 GET /images/National Aerospace Agency-logosmall.gif 200 786
    007.thegap.com 807996997 GET /images/National Aerospace Agency-logosmall.gif 200 786
    007.thegap.com 806532057 GET /images/National Aerospace Agency-logosmall.gif 200 786
    007.thegap.com 805072932 GET /images/National Aerospace Agency-logosmall.gif 200 786
    007.thegap.com 805065766 GET /images/National Aerospace Agency-logosmall.gif 200 786
    ```

These examples show how we can build many different pipelines with just a few commands.


### Command and tool review

In this module, we briefly learned different kinds of tools and commands. This introduction should be enough to get you started with data wrangling in the UNIX shell.

Here's a summary of the commands and tools we reviewed:

- The `cat` command allows you to display, concatenate, and append files.
- Pipes (`|`) send the output of one command as input of another command.
- A filter takes input from one command, does some processing, and gives an output.
- Regular expressions (regex) are used for pattern matching and can be used by other commands and tools, such as `sed` and `grep`.
- The `grep` command can be used to find strings and values in a text file.
- Piping through `grep` is one of the most common uses.
- The most common use of the stream editor (`sed`) is text substitution.
