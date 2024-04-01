To start filtering, you need a way to let PowerShell know which objects you want to keep and which ones you want to remove from the pipeline. You can do this task by specifying criteria for the objects that you want to keep. You do so by using one of the PowerShell comparison operators to compare a particular property of an object to a value that you specify. PowerShell keeps the object if the comparison is true and removes it if the comparison is false.

The following table lists the basic comparison operators and what they mean.

*Table 1: Comparison operators*

| Operator | Description              |
| -------- | ------------------------ |
| **-eq**  | Equal to                 |
| **-ne**  | Not equal to             |
| **-gt**  | Greater than             |
| **-lt**  | Less than                |
| **-le**  | Less than or equal to    |
| **-ge**  | Greater than or equal to |

These operators are case-insensitive when used with strings. This means that the results are the same whether the letters are capitalized or not. A case-sensitive version of each operator is available and begins with the letter **c**, such as **-ceq** and **-cne**.

PowerShell also contains the **-like** operator and its case-sensitive companion, **-clike**. The **-like** operator resembles **-eq** but supports the use of the question mark (?) and asterisk (*) wildcard characters in string comparisons.

Other, more advanced operators exist that are beyond the scope of this course. These operators include:

- The **-in** and **-contains** operators, which test whether an object exists in a collection.
- The **-as** operator, which tests whether an object is of a specified type.
- The **-match** and **-cmatch** operators, which compare a string to a regular expression.

PowerShell also contains many operators that reverse the logic of the comparison, such as **-notlike** and **-notin**.

You can make comparisons directly at the command prompt, which returns either True or False. Here's an example:

```powershell
PS C:\> 100 -gt 10
True
PS C:\> 'hello' -eq 'HELLO'
True
PS C:\> 'hello' -ceq 'HELLO'
False
```

This technique makes it easy to test comparisons before you use them in a command.
