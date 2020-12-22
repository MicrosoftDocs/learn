So far you've learned about basic file inspection and regular expressions. In this unit, you will be introduced to the `grep` command.
The `grep` command searches specified files or `stdin` for patterns matching a given regular expression.
As other commands we've seen before, the command `grep` has a number of flags to control the output and its behavior. We'll learn more about these flags later on in this unit.

Let's get started with the basic usage of `grep`. The basic syntax for `grep` is:

```bash
grep 'pattern' [file_to_search]
```

Let's say you want to find all the lines that contain the pattern `*.novo.dk` in the `NASA-logs-1995.txt` file. We know from the previous unit that the regular expression for this pattern is `\*\.novo\.dk`. Notice how we're escaping the special symbols with a back slash (`\`).

Run the following command to match the regular expression using `grep`:

```bash
grep -i '\*\.novo\.dk' NASA-logs-1995.txt
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

You can also pass multiple files to the command `grep`. So let's say you want to find all occurrences and their line numbers of the word `NASA` in the NASA-logs-1995.txt and NASA-software-API.txt files.
To add the line numbers to the output, you'll need to pass the `-n` flag to the grep command.

Run the following command in your command line:

```bash
grep -n 'NASA' NASA-logs-1995.txt NASA-SOFTWARE-API.TXT
```

You'll get many more results than in the previous search as we passed two files as an argument to the command.
`grep` is a powerful command, which allows you to match complex regular expressions and tailor the output much to your needs. Here are some useful flags to remember:

- `grep -c`: counts the number of lines that matches the pattern (equivalent to `grep 'pattern' file | wc -l`)
- `grep -n`: indicated the line number and the matched pattern
- `grep -i`: allows case-insentitive matches
- `grep -w`: matches entire words
- `grep -H`: include filename (useful when passing multiple files)
- `grep -m<max number lines>`: limit the number of matches to be displayed, for example to limit to only the first four matches you'd use `-m4`
