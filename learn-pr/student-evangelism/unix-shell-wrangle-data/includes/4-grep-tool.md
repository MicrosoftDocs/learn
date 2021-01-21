So far, you've learned about basic file inspection and regular expressions. In this unit, you'll be introduced to the `grep` command. The `grep` command searches specified files or `stdin` for patterns that match a given regular expression. As with other commands we've seen before, the `grep` command has many flags to control the output and its behavior. We'll learn more about these flags later on in this unit.

Let's get started with the basic usage of `grep`. The basic syntax for `grep` is `grep 'pattern' [file_to_search]`.

Let's say you want to find all the lines that contain the pattern `*.novo.dk` in the `NASA-logs-1995.txt` file. We know from the previous unit that the regular expression for this pattern is `\*\.novo\.dk`. Notice how we're escaping the special symbols with a back slash (`\`).

> [!Tip]
>
> Close the Cloud Shell editor to see the entire output in the terminal.

Run the following command to match the regular expression by using `grep`:

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

You can also pass multiple files to the command `grep`. So let's say you want to find all occurrences of the word `NASA` and their line numbers in the NASA-logs-1995.txt and NASA-software-API.txt files. To add the line numbers to the output, you'll need to pass the `-n` flag to the grep command.

Run the following command in your command line:

```bash
grep -n 'NASA' NASA-logs-1995.txt NASA-SOFTWARE-API.TXT
```

You'll get many more results than in the previous search because we passed two files as an argument to the command. The `grep` command is powerful. You can use it to match complex regular expressions and tailor the output to your needs. Here are some useful flags to remember:

- `grep -c`: Counts the number of lines that match the pattern (equivalent to `grep 'pattern' file | wc -l`).
- `grep -n`: Indicates the line number and the matched pattern.
- `grep -i`: Allows case-insensitive matches.
- `grep -w`: Matches entire words.
- `grep -H`: Includes file names, which are useful when you're passing multiple files.
- `grep -m<max number lines>`: Limits the number of matches to be displayed. For example, to limit to only the first four matches, you would use `-m4`.
