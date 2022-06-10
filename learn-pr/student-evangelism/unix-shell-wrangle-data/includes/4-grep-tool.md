So far, you've learned about basic file inspection and regular expressions. In this unit, we introduce the `grep` command. The `grep` command searches specified files or `stdin` for patterns that match a given regular expression. As with other commands we've reviewed, the `grep` command has many flags to control the output and its behavior. 

## Basic usage

Let's get started with the basic usage of the `grep` command. The common syntax for `grep` is `grep 'pattern' [file_to_search]`. The pattern value is enclosed in apostrophe (`'`) characters.

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

   Your output should look something like this:

   ```output
   ***.novo.dk 805465029 GET /ksc.html 200 7067
   ***.novo.dk 805465031 GET /images/ksclogo-medium.gif 200 5866
   ***.novo.dk 805465051 GET /images/MOSAIC-logosmall.gif 200 363
   ***.novo.dk 805465053 GET /images/USA-logosmall.gif 200 234
   ***.novo.dk 805465054 GET /images/NASA-logosmall.gif 200 786
   ***.novo.dk 805465058 GET /images/WORLD-logosmall.gif 200 669
   ***.novo.dk 805465068 GET /shuttle/missions/missions.html 200 8678
   ***.novo.dk 805465071 GET /images/launchmedium.gif 200 11853
   ***.novo.dk 805465153 GET /images/KSC-logosmall.gif 200 1204
   ***.novo.dk 805465157 GET /images/NASA-logosmall.gif 200 786
   ***.novo.dk 805465323 GET /images/launch-logo.gif 200 1713
   ```


## Use grep on multiple files

You can also pass multiple files to the `grep` command.

Let's find all occurrences of the word "NASA" and show the line numbers where the matches occur in both NASA dataset files. To add line numbers to the output, you need to pass the `-n` flag to the `grep` command.

- Run the following `grep` command on the two dataset files:

   ```bash
   grep -n 'NASA' NASA-logs-1995.txt NASA-software-API.txt
   ```

You'll get many more results than the previous search because we passed two files as an argument to the command.


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
