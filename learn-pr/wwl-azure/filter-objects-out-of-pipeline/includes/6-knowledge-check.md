Use the following questions to check what you’ve learned in this module.

### Multiple Choice
1. Which of the following commands provides a more efficient way to produce a list of services that have names beginning with svc?

(x) Get-Service –Name svc*{{Correct. The command Get-Service –Name svc\* is a better approach, as it filters the names as part of the Get-Service command.}}

( )Get-Service \| Where Name –like svc\* {{Incorrect. The command Get-Service –Name svc\* is a better approach, as it filters the names as part of the Get-Service command.}}

---

2.  Of the variables `$_` and `$PSItem`, which one would many experienced Windows PowerShell users prefer to use?

(x)`$_`{{Correct. Many experienced Windows PowerShell users use the `$_` variable instead of `$PSItem`, because only `$_` is allowed in Windows PowerShell 1.0 and Windows PowerShell 2.0.}}

( )`$PSItem`{{Incorrect. Many experienced Windows PowerShell users use the `$_` variable instead of `$PSItem`, because only `$_` is allowed in Windows PowerShell 1.0 and Windows PowerShell 2.0.}}

( )Without exception, both can be used interchangeably{{Incorrect. Many experienced Windows PowerShell users use the `$_` variable instead of `$PSItem`, because only `$_` is allowed in Windows PowerShell 1.0 and Windows PowerShell 2.0.}}
