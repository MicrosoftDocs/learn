In this unit, you'll be introduced to regular expressions. Regular expressions are handy to do text pattern matching and are equally used by developers and data scientists.

# Introduction to regular expressions

Regular expressions are massively helpful and chances are, you've come across them at some point. This esoteric, miniature language can help with complex pattern matching and might look a bit intimidating at first. However, regular expressions can be found in most text editors and languages and tools such as Python, SQL, Go, and Scala among many others. So they're definitely worth learning.

A useful online tool to have in your bookmarks is [Regular Expressions 101](https://regex101.com/), which allows you to test a regex against test inputs.

## Literals and special characters

In brief, regex is an accessible way to define a pattern of characters and is mostly used in pattern identification, text mining, or input validation.
The pattern specified can be broad or specific and is **strictly** read left-to-right. Its input is a text string.

Most characters (alphabetic and numeric) don't have a special functionality and literally match that character.
For example, a regex of 'SSH' will only match the string 'SSH'

```output
REGEX: SSH
INPUT: SSH
MATCH: true

REGEX: SSH
INPUT: ZSH
MATCH: false
```

If you completed the previous module, you should now have a sample of the pen dataset [CLAIR collection of fraud emails](https://www.kaggle.com/rtatman/fraudulent-email-corpus). We'll use this dataset to do some pattern matching with regex in VSCode.

First, open the `CLAIR_emails.txt` file in VSCode. And then open the search box using the key combinations <kbd>Cmd + F</kbd> in Mac and <kbd>Ctrl + F</kbd> in Windows and Linux.

Make sure that the `regex` option is switched on (see screenshot below, the regex option should be active)

:::image type="content" source="../media/clair_vscode_screenshot.png" alt-text="Screenshot showing VSCode search box and regex option":::

If you type the word *money* in the search box, VSCode will match all the string instances (12 in total) and you can use the arrow buttons to navigate to the matches in the file.

:::image type="content" source="../media/clair_emails_string_search.png" alt-text="Screenshot showing VSCode search results in a sample email text":::

This might not seem any different from any search box. But the true power of regex comes when you use special characters like `[\^$.|?*+()` and ranges. 

### Character matching and ranges

Let's say you want to find all instances of the words "him" and "his" in the emails file. 

The solution is to enclose part of our search pattern in brackets (`[]`). The brackets mean "any character in this list. Like so:

```bash
hi[sm]
```

Using regex like this one is simple enough to do as we only have the letters "s" and "m" in the list. But how would you go about matching the entire alphabet or digits? 

You can achieve this by defining a consecutive range of letters or numbers. for example for all digits you'd create a range [0-9] and for lowercase alphabetic characters you can write [a-z].

So if you wanted, for example finding all float numbers in the email you can use the following regex:

```bash
[0-9]\.[0.9]
```
### Wildcards

The `.` character is a special character type called a wildcard. It can be used to represent any character (letters, numbers, whitespaces, newlines, punctuation, and symbols).

For example, to find all the combinations of three characters starting with `g` and ending with `t` you'd use the regex `g.t`.

A common pattern is  , which allows you to match any character zero or more times. So let's say you want to find all email domains including the `@` character.
You'd need to type in `@.*` in the search box.

Some results from this pattern matching in the emails file are:

```output
@epatra.com
@aclweb.org
```

If you want to narrow the search even further, to domains finishing in `.com` you'd use the regex `@.*\.com`

Notice how we escape the second `.` with `\` to create a literal regex matching anything ending in `.com`.

## Regex cheatsheet

Here's a handy regex cheatsheet for you:

```
^        Matches the beginning of a line
$        Matches the end of the line
.        Matches any character
\s       Matches whitespace
\S       Matches any non-whitespace character
*        Repeats a character zero or more times
*?       Repeats a character zero or more times
         (non-greedy)
+        Repeats a character one or more times
+?       Repeats a character one or more times
         (non-greedy)
[aeiou]  Matches a single character in the listed set
[^XYZ]   Matches a single character not in the listed set
[a-z0-9] The set of characters can include a range
(        Indicates where string extraction is to start
)        Indicates where string extraction is to end
```