In this unit, you're introduced to regular expressions. Regular expressions are handy to do text pattern matching. They're equally used by developers and data scientists.

Regular expressions (regex) are tremendously helpful, and chances are you've come across them at some point. This esoteric, miniature language can help with complex pattern matching and might look a bit intimidating at first. But regular expressions can be found in most text editors and languages, along with tools such as Python, SQL, Go, and Scala, among many others. They're definitely worth learning about.

A useful online tool to have in your bookmarks is [Regular Expressions 101](https://regex101.com/), which allows you to test a regex against test inputs.

## Literals and special characters

In brief, regex is an accessible way to define a pattern of characters and is mostly used in pattern identification, text mining, or input validation. The pattern specified can be broad or specific and is *strictly* read left to right. Its input is a text string.

Most characters (alphabetic and numeric) don't have a special functionality and literally match that character. For example, a regex of SSH will only match the string SSH.

```output
REGEX: SSH
INPUT: SSH
MATCH: true

REGEX: SSH
INPUT: ZSH
MATCH: false
```

If you completed the previous unit, you should now have a sample of the open dataset `NASA-software-API.txt`. We'll use this dataset to do some pattern matching with regex in the Azure Cloud Shell sandbox.

1. Open the `NASA-software-API.txt` file in Cloud Shell by using `code <filename>`.

     ```bash
     code NASA-software-API.txt
     ```

1. Next, open the search box by using the key combinations <kbd>Cmd+F</kbd> in macOS or <kbd>Ctrl+F</kbd> in Windows and Linux.

1. Make sure that the **regex** option is switched on, as shown in the following screenshot.

      :::image type="content" source="../media/cloud-shell-sandbox-search-regex-selected.png" alt-text="Screenshot showing the Cloud Shell search box and regex option selected.":::

1. Enter the words **Open Source** in the search box. Cloud Shell matches all of the string instances. You can use the keyboard arrow keys to navigate to the matches in the file.

      :::image type="content" source="../media/cloud-shell-sandbox-search-open-source.png" alt-text="Screenshot showing Cloud Shell search results in a text file.":::

This technique might not seem any different from any other use of a search box. But the true power of regex comes when we start using special characters, ranges, and anchors.

### Character matching and ranges

So far you've learned that you can use regex to make a literal matching of characters. Let's say you want to find the versions of the software specified in the file. You're interested in those versions that have a format similar to `v1`.

You already know that all versions should start with `v`, so you can enclose the rest of the search in brackets (`[]`). The brackets mean "any character in this list." For example, `v[12345]`.

Using regex like this one is simple enough to do because we only have five digits we're looking for (1-5) in the list. But how would you go about matching the entire alphabet or digits without having to write every single character?

You can define a consecutive range of letters or numbers. For example, for all digits, you would create a range `[0-9]`. For lowercase alphabetic characters, you can write `[a-z]`.

For example, if you wanted to find all versions that contain any digits, you would modify the regex to `v[1-9]`.

### Wildcards

The `.` character is a special character type called a *wildcard*. It can be used to represent any character, such as letters, numbers, white spaces, newlines, punctuation, and symbols.

For example, to find all the combinations of three characters starting with `g` and ending with `t`, you would use the regex `g.t`.

A common pattern used in regex is `.*`, which allows you to match any character zero or more times. Let's say you want to find all the texts that contain the word *NASA*. You can use the following regex `NASA.*`.

Some results from this pattern matching in the file are:

```output
NASA Root Cause Analysis Tool
NASA Lewis Research Center General Multi-Block Navier-Stokes Heat Transfer
NASA/NESSUS 6.2c Probabilistic Structural Analysis
```

### Anchors

When you match sequences that appear at a specific part of a line of characters or a word, it's called *anchoring*. You use the caret (`^`) symbol to indicate the search pattern should consider a character sequence a match only if it appears at the start of a line. The `$` symbol is used to indicate that the search pattern should consider a match only if it appears at the end of a line.

You can now write a regex that will match numbers at the beginning of a line, `^[0-9]`, or the end of a line, `[0-9]$`.

### Escaping characters

Let's say we want to find lines in which a period (`.`) is the last character. We know the dollar sign (`$`) is the end-of-line anchor, so we might enter `.$` in the search box.

But this regex won't return what we want. As we covered earlier, the period (`.`) matches any single character. Because every line ends with a character, every line was returned in the results.

How do you prevent a special character from doing its regex function when you want to search for that actual character? You use a backslash (`\`) to escape the character. For example, enter `\.$` in the search box.

## Regex cheat sheet

This unit was a brief introduction to regular expressions and what you can accomplish with them. There are many other complex patterns you can build with regular expressions. In the meantime, here's a handy regex cheat sheet for you:

| Regex | Definition |
| --- | --- |
| ^ | Matches the beginning of a line |
| $ | Matches the end of the line |
| . | Matches any character |
| \s | Matches whitespace |
| \S | Matches any non-whitespace character |
| \* | Repeats a character zero or more times |
| *? | Repeats a character zero or more times (non-greedy) |
| + | Repeats a character one or more times |
| +? | Repeats a character one or more times (non-greedy) |
| [aeiou] | Matches a single character in the listed set |
| [^XYZ] | Matches a single character not in the listed set |
| [a-z0-9] | The set of characters can include a range |
| ( | Indicates where string extraction is to start |
| ) | Indicates where string extraction is to end |

You can also learn more about Visual Studio Code and regular expressions in the [Visual Studio Code documentation](https://docs.microsoft.com/visualstudio/ide/using-regular-expressions-in-visual-studio?view=vs-2019).
