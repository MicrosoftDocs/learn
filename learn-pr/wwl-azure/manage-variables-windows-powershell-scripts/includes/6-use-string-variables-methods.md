String variables are commonly used in scripts. You can use strings to store user input and other text data. There are many methods that you can use to manipulate strings. Many of these methods are seldom used, but it's good to be aware of them in case you ever need them.

The string variable has only one property, **Length**. When you review the length for a string variable, it returns the number of characters in the string. For example:

```powershell
$logFile.Length
```

 The following table lists some of the methods available for string variables.

*Table 1: Methods available for string variables*

| Method                                | Description                                                  |
| ------------------------------------- | ------------------------------------------------------------ |
| `Contains(string value)`              | Identifies whether the variable contains a specific string. The result is either `$true` or `$false`. |
| `Insert(int startindex,string value)` | Inserts a string of text at the character number specified.  |
| `Remove(int startindex,int count)`    | Removes a specified number of characters from the string beginning at the character number specified. If the count isn't specified, then the  string is truncated at the specified character number. |
| `Replace(string value,string value)`  | Replaces all instances of the first string with the second string. |
| `Split(char separator)`               | Splits a single string into multiple strings at points specified by a character. |
| `ToLower()`                           | Converts a string to lowercase.                              |
| `ToUpper()`                           | Converts a string to uppercase.                              |
