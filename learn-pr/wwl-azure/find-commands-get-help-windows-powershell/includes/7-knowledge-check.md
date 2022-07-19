Use the following questions to check what you’ve learned in this module.

### Multiple Choice

1.  How would you search for a cmdlet that retrieves a computer's properties from Active Directory?

( )`Get-ComputerInfo`\{\{Incorrect. This cmdlet returns information about the local operating system, rather than searching for cmdlets that retrieve a computer's properties from Active Directory.\}\}

(x)`Get-Help Get-AD*`\{\{Correct. You can use what you know about cmdlet name structures to help you guess a cmdlet's name. You know that Get retrieves resources so that you can work with their properties. You also know that the nouns associated with Active Directory have the prefix AD. Based on this information, you can use the Get-Help command and a wildcard value for the cmdlet name to search for possible cmdlets by running the command `Get-Help Get-AD*`. Because you're searching for the cmdlets that operate specifically on computers, you could even check if Get-Help Get-ADComputer returns results.\}\}

( )`Get-Command -ParameterName Auth*` \{\{Incorrect. This command returns a list of all cmdlets that include a parameter whose name starts with `Auth`, rather than searching for cmdlets that retrieve a computer's properties from Active Directory.\}\}

---

2.  Which of the following are groups of related PowerShell capabilities that are bundled together into a single unit?

( )Parameters\{\{Incorrect. *Modules* are groups of related PowerShell capabilities that are bundled together into a single unit. They help with organizing cmdlets into distributable units.\}\}

( )Aliases\{\{Incorrect. *Modules* are groups of related PowerShell capabilities that are bundled together into a single unit. They help with organizing cmdlets into distributable units.\}\}

(x)Modules\{\{Correct. *Modules* are groups of related PowerShell capabilities that are bundled together into a single unit. They help with organizing cmdlets into distributable units.\}\}
