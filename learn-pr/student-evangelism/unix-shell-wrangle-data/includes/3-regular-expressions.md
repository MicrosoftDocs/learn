In this unit, you're introduced to regular expressions. Regular expressions are handy when you need to do text pattern matching. They're equally used by developers and data scientists.

Regular expressions (regex) are tremendously helpful, and chances are you've come across them at some point. This esoteric, miniature language can help with complex pattern matching and might look a bit intimidating at first. But regular expressions can be found in most text editors and languages, along with tools such as Python, SQL, Go, and Scala, among many others. They're definitely worth learning about.

A useful online tool to have in your bookmarks is [Regular Expressions 101](https://regex101.com/?azure-portal=true), which allows you to test a regex against test inputs.

## Literals and special characters

In brief, regex is an accessible way to define a pattern of characters and is mostly used in pattern identification, text mining, or input validation. The pattern specified can be broad or specific and is *strictly* read left to right. The regex input is always a text string.

Most characters (alphabetic and numeric) don't have a special functionality and literally match that character. A regex of `SSH` only matches the string "SSH." If the input string is "ZSH," the regex pattern wouldn't find a match.

If you completed the previous unit, you should have a sample of the open NASA dataset. We'll use this dataset to do some pattern matching with regex in the Azure Cloud Shell sandbox.

1. Use the `code` command to open the **NASA-software-API.txt** file in the Cloud Shell editor:

    ```bash
    code NASA-software-API.txt
    ```

    The file opens in the integrated editor above the Cloud Shell prompt.

1. Open the search box for the integrated editor:

   1. Click the mouse anywhere in the editor.
   
   1. Press Ctrl + F (on Windows and Linux) or Cmd + F (on macOS).

   The search box opens in the integrated editor.

1. Select the **regex** icon (**`.*`**) to enable regex pattern match searching for the file in the editor:

    :::image type="content" source="../media/cloud-shell-sandbox-search-regex-selected.png" alt-text="Screenshot showing the Cloud Shell search box and regex option selected." lightbox="../media/cloud-shell-sandbox-search-regex-selected.png":::

1. In the search box, enter the string `Open Source`.

    With the **regex** option enabled, Cloud Shell highlights all instances in the content that match the input string. The number of matched instances is shown in the search box.

    :::image type="content" source="../media/cloud-shell-sandbox-search-open-source.png" alt-text="Screenshot showing Cloud Shell search results in a text file." lightbox="../media/cloud-shell-sandbox-search-open-source.png":::

    You can use the **left** (previous) and **right** (next) arrow icons on the search box to see each matched instance in the file.

This technique might not seem different from any other use of a search box. The true power of regex comes when we start using special characters, ranges, and anchors.


### Character matching and ranges

So far you've learned you can use regex to make a literal matching of characters. Let's say you want to find the versions of the software specified in a file. You're interested in versions that have a format similar to "v1."

You know all versions should start with the letter "v." You can enclose the rest of the search string to match in square brackets `[]`. The square brackets mean "any character in this list." To search for versions that start with the numbers 1 through 5, you can search with a regex of `v[12345]`.

Let's try this type of regex pattern in the NASA-software-API.txt file.

1. In the search box, enter `ARC-14[456]` to look for content that matches "ARC-14" followed by the numbers 4, 5, or 6.
   
    You should see 12 results.
    
1. Use the left and right arrow icons on the search box to see each matched instance in the file.

Using a regex like this example is simple because we only have three digits to look for (4, 5, 6) in the content. But how would you go about matching the entire alphabet or many digits without having to write every single character?

You can define a consecutive range of letters or numbers. For all digits, you would create a range `[0-9]`. For lowercase alphabetic characters, you can use the range `[a-z]`.

Let's find all instances of "ARC-14" followed by any digit.

- In the search box, enter `ARC-14[0-9]` to look for content that matches "ARC-14" followed by any number.
   
    You should see 22 results.
    
    Here are some of the lines in the file that match this pattern:

    ```output
    ARC-14293-1 ARC 2005-09-19T00:00:00.000 "Open Source" "Genetic Graphs (JavaGenes)"
    ...
    ARC-14400-1 ARC 2001-01-29T00:00:00.000 "General US" "PLOT3D Version 4.0"
    ...
    ARC-14837-1GS ARC 1999-07-13T00:00:00.000 "General US" "FOMOCO Utilities "
    ...
    ARC-14932-1 ARC 2005-01-12T00:00:00.000 "Open Source" "Mission Simulation Toolkit (MST)"
    ```


### Wildcards

The period (`.`) character is a special character type called a *wildcard*. It can be used to represent any character, such as letters, numbers, white spaces, newlines, punctuation, and symbols. For example, to find all combinations of three characters that start with the letter "g" and end with the letter "t," you would use the regex `g.t`.

A common pattern used in regex is the period followed by an asterisk (`.*`). This regex syntax allows you to match any character zero or more times. 

Let's try this regex wildcard pattern to look for text that matches "NASA" followed by any other character.

- In the search box, enter `NASA.*` to look for matching text.
   
    You should see 26 results.
    
    Here are some of the lines in the file where the pattern was matched:

    ```output
    NASA Root Cause Analysis Tool
    ...
    NASA's Moderate Resolution Imaging Spectrometer (MODIS)-Combined Ocean Color
    ...
    NASA, Average-Passage Multistage Turbomachinery Flow Field Analysis Code
    ...
    NASA -  Average Passage Flow Solver)
    ...
    NASA/NESSUS 6.2c Probabilistic Structural Analysis Software
    ```


### Anchors

When you match sequences that appear at a specific part of a line of characters or a word, it's called *anchoring*. There are two types of anchors:

- **Start of line**: Use the caret (`^`) symbol when the search pattern should consider a character sequence to be a match only if the matching portion appears at the *start* of a line.
- **End of line**: Use the dollar (`$`) symbol when the search pattern should consider a character sequence to be a match only if the matching portion appears at the *end* of a line.

You can now write a regex to match numbers at the beginning of a line, `^[0-9]`, or at the end of a line, `[0-9]$`.

Let's try the regex anchor patterns to search for matches where "A" is the first or last character in the input string.

1. In the search box, enter `^[A-G]` to look for text that starts with the letters A through G.
   
    You should see 258 results.    

1. Enter `[A-G]$` to look for text that ends with the letters A through G.

    There are three results:

    ```output
    LAR-16939-GS LaRC 2000-11-07T00:00:00.000 "General Public" DeMAID1m.sea
    ...
    GSC-16207-1 GSFC 2011-04-12T00:00:00.000 "Open Source" "Goddard Mission Services Evolution Center Architecture Application Programming Interface (GMSEC
    ...
    LEW-16018-1 GRC 2003-01-05T00:00:00.000 "General US" CARES/LIFE
    ```


### Escaping characters

Let's say we want to find lines where a period (`.`) is the last character. We know the dollar sign (`$`) is the end-of-line anchor, so we might enter `.$` in the search box. But this regex won't return the matches we're looking for. As we covered earlier, the period (`.`) matches **any** single character. Because every line ends with a character, every line is returned in the results.

How do you prevent a special character from doing its regex function when you want to search for that actual character? You use a backslash (`\`) to escape the character that you want to search for. To find lines where a period (`.`) is the last character, we use the regex `\.$`.

Let's try using the escape character in a regex pattern search of our NASA file.

1. In the search box, enter `\.$` to look for text that ends with a period (`.`).
   
    There are zero results. No lines in the file end with a period.

1. In the search box, enter `\*\*` to look for instances of a double asterisk (`**`) in the file.    

    One line in the file matches the search pattern:

    ```output
    LLEW-17324-1 GRC 2001-01-05T00:00:00.000 "General US" "CANCELLED ** Same As LEW-16855-1 (APNASA -  Average Passage Flow Solver)"
    ```


## Regex cheat sheet

This unit was a brief introduction to regular expressions and what you can accomplish with them. There are many other complex patterns you can build with regular expressions. In the meantime, here's a handy regex cheat sheet for you:

| Regex | Definition |
| --- | --- |
| ^ | Matches the beginning of a line. |
| $ | Matches the end of the line. |
| . | Matches any character. |
| \s | Matches whitespace. |
| \S | Matches any non-whitespace character. |
| \* | Repeats a character zero or more times. |
| *? | Repeats a character zero or more times (non-greedy). |
| + | Repeats a character one or more times. |
| +? | Repeats a character one or more times (non-greedy). |
| [aeiou] | Matches a single character in the listed set. |
| [^XYZ] | Matches a single character not in the listed set. |
| [a-z0-9] | The set of characters can include a range. |
| ( | Indicates where string extraction is to start. |
| ) | Indicates where string extraction is to end. |

You can learn more about Visual Studio Code and regular expressions in the [Visual Studio Code documentation](/visualstudio/ide/using-regular-expressions-in-visual-studio?azure-portal=true).
