When working with variable values, you use the standard mathematical operators that you're already familiar with, such as equal (`=`), plus (`+`), and minus (`–`).

To assign a value to a variable, you use the equal (`=`) operator. For example:

```powershell
$num1 = 10
$logFile = "C:\Logs\log.txt"
```

You can also assign a value to a variable by using a command that's evaluated. The result of the command is placed in the variable. For example:

```powershell
$user = Get-ADUser Administrator
$service = Get-Service W32Time
```

> [!NOTE]
> If a command returns multiple results, then the variable becomes an array containing multiple values. You'll learn about arrays later in this module.

You can display the value of a variable by entering the variable name and then pressing the Enter key. You can also display the value as part of a command by using **Write-Host**. For example:

```powershell
$user
Write-Host "The location of the log file is $logFile"
```

> [!NOTE]
> When you display a variable by using **Write-Host** and you place the variable name in double quotes ("), that variable is evaluated and its value is displayed. If you use single quotes ('), that variable is not evaluated, resulting in its name being displayed instead. 

To remove all values from a variable, you can set the variable equal to `$null`. The `$null` variable is automatically defined by Windows PowerShell as nothing. For example:

```powershell
$num1 = $null
$str1 = $null
```

> [!NOTE]
> To clear a variable, you can also use **Clear-Variable**.

You can use mathematical operators with variables, as the following example depicts:

```powershell
$area = $length * $width
$sum = $num1 + $num2
$path = $folder + $file
```

You can set the value of a variable by using the **Set-Variable** cmdlet. When you use this cmdlet, you don't include the `$` symbol when referring to the name, as the following example depicts:

```powershell
Set-Variable -Name num1 -Value 5
```

**Additional reading:** For more information about assignment operators, refer to [about_Assignment_Operators](https://aka.ms/lewact).

## Assigning a type to a variable

All variables are assigned a type. The variable type determines the data that can be stored in it. In most cases, Windows PowerShell automatically determines the type of a variable during assignment of its value. Automatic assignment of the variable type works well most of the time. However, in some cases, the data type is ambiguous, and you might prefer to set the variable type explicitly.

The following table lists the common variable types used in Windows PowerShell.

*Table 1: Common variable types used in Windows PowerShell*

| Type     | Description                                                  |
| -------- | ------------------------------------------------------------ |
| String   | A string variable stores text that can include special characters. For example, **"This is a string."** |
| Int      | A 32-bit integer variable stores a number without decimal places. For example, **228**. |
| Double   | A 64-bit floating point variable stores a number that can include decimal places. For example, **128.45**. |
| DateTime | A DateTime variable stores a date object that includes a date and time. For example, **January 5, 2022 10:00 AM**. |
| Bool     | A Boolean variable can store only the values `$true` or `$false`. |

If you don't assign a variable type, Windows PowerShell assigns a type automatically based on the value you assign to the variable. When the value is contained in quotes, it's generally interpreted as a string. For example, Windows PowerShell would interpret **5** as an integer but **"5"** would be interpreted as a string.

You can force a variable to accept only a specific type of content by defining the type. When you define the type, Windows PowerShell attempts to convert the value you provide into the correct type. If Windows PowerShell is unable to convert the value into the correct type, it returns an error.

The following examples depict the `$num2` variable being defined as a 32-bit integer and the `$date` variable being defined as **DateTime**.

```powershell
[Int]$num2 = "5"
[DateTime]$date = "January 5, 2022 10:00AM"
```

You can review a variable’s type by appending the **GetType()** method to the name of the variable. For example:

```powershell
$date.GetType()
```

