So far, you've learned about basic file inspection and regular expressions. In this unit, we introduce the `grep` command to search specific files or `stdin` for patterns that match a regex. As with other commands we've reviewed, the `grep` command has many flags to control the output and its behavior. 

## Basic usage

Let's get started with the basic usage of the command. The common syntax for `grep` is `grep 'pattern' [file_to_search]`, where the pattern value is enclosed in apostrophe (`'`) characters.

To find all lines in the file that contain the pattern `*.novo.dk`, we specify the regex as follows:
- Start with the asterisk (`*`) to look for lines that match any character zero or more times.
- Follow the asterisk with the string `.novo.dk`. In this example, the period (`.`) is literal and not used as a wildcard.
- Use the back slash (`\`) escape character for the special symbols in the pattern: asterisk and period.

## Use grep on a file

We're going to look for all lines in the **NASA-logs-1995.txt** file that contain the `grep` pattern `'*.novo.dk'`.

1. First, close the Cloud Shell editor so you have the full space in the terminal to see command output.

   There are two ways to close the editor:
   - Press Ctrl + Q.
   - Select the ellipsis (...), and then select **Close Editor**.

   :::image type="content" source="../media/close-cloud-shell-sandbox-editor.png" alt-text="Screenshot showing the Close Editor option on the ellipsis context menu." lightbox="../media/close-cloud-shell-sandbox-editor.png":::

1. Run the `grep` command to match the `\*\.novo\.dk` regular expression in the file:

   ```bash
   grep '\*\.novo\.dk' NASA-logs-1995.txt
   ```

   Here are the last few lines of the output:

   ```output
   ...
   ***.novo.dk 807951981 GET /shuttle/countdown/video/livevideo2.gif 200 69067
   ***.novo.dk 807952044 GET /htbin/cdt_clock.pl 200 543
   ***.novo.dk 807952060 GET /shuttle/countdown/lps/fr.html 200 1879
   ***.novo.dk 807952078 GET /shuttle/countdown/lps/fr.gif 200 30232
   ***.novo.dk 807952102 GET /shuttle/countdown/lps/back.gif 200 1289
   ```


## Use grep on multiple files

You can also pass multiple files to the `grep` command.

Let's find all occurrences of the word "NASA" in both NASA dataset files. We expect many more results this time, so rather than look at all the results, we'll instruct the command to report how many lines matched the pattern. To do this counting and reporting, we pass the `-c` flag to the `grep` command.

- Run the following `grep` command on the two dataset files:

   ```bash
   grep -c 'NASA' NASA-logs-1995.txt NASA-software-API.txt
   ```

   You should see this output:

   ```output
   NASA-logs-1995.txt:17277
   NASA-software-API.txt:26
   ```

   There are 17,277 instances of "NASA" in the log dataset and 26 instances in the API dataset.


## Grep flags

The `grep` command is powerful. You can use it to match complex regular expressions and tailor the output to your needs. Here are some useful flags to remember:

| Flag | Definition |
| --- | --- |
| `grep -c` | Counts the number of lines that match the pattern (equivalent to `grep 'pattern' file | wc -l`). |
| `grep -n` | Indicates the line number and the matched pattern. |
| `grep -i` | Allows case-insensitive matches. |
| `grep -w` | Matches entire words. |
| `grep -H` | Includes file names, which are useful when you're passing multiple files. |
| `grep -m <max number lines>` | Limits the number of matches to be displayed. To limit the display to only the first four matches, use `-m4`. |
