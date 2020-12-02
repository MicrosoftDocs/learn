In this unit, you'll be introduced to regular expressions. Regular expressions are handy to do text pattern matching and are equally used by developers and data scientists.

# Introduction to regular expressions

Regular expressions are massively helpful and chances are, you've come across them at some point. This esoteric, miniature language can help with complex pattern matching and might look a bit intimidating at first. However, regular expressions can be found in most text editors and languages and tools such as Python, SQL, Go, and Scala among many others. So they're definitely worth learning.

A useful online tool to have in your bookmarks is [Regular Expressions 101](https://regex101.com/), which allows you to test a regex against test inputs.

## Literals and special characters

In brief, regex is an easy way to define a pattern of characters and is mostly used in pattern identification, text mining, or input validation.
The pattern specified can be broad or specific and is **strictly** read left-to-right. Its input is a text string.

Most characters (alphabetic and numeric) don't have a special functionality and literally match that character.


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