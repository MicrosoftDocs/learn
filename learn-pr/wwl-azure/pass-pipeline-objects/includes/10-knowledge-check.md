Use the following questions to check what you’ve learned in this module.

## Multiple Choice

1. Which technique does Windows PowerShell always try to use first when the command-line interface passes objects from one command to another in the pipeline?

(x)ByValue{{Correct. Windows PowerShell always tries to use ByValue first for pipeline parameter binding. The second technique, named ByPropertyName, is used only when ByValue fails.}}

( )ByPropertyName{{Incorrect. Windows PowerShell always tries to use ByValue first for pipeline parameter binding. The second technique, named ByPropertyName, is used only when ByValue fails.}}

( )Neither is preferred over the other{{Incorrect. Windows PowerShell always tries to use ByValue first for pipeline parameter binding. The second technique, named ByPropertyName, is used only when ByValue fails.}}


---

2. How can you determine the pipeline input capability of each parameter and the technique/s the parameter supports?

( )All parameters accept pipeline input and support both techniques{{Incorrect. You will find the the pipeline input capability of each parameter, and a list of techniques it supports, in the full Help for a command.}}

( )Use the **Get-PSSessionCapability** cmdlet {{Incorrect. The **Get-PSSessionCapability** cmdlet lists the capabilites of a user in a constrained PowerShell session.}}

(x)Read the full Help for each command{Correct. You will find the the pipeline input capability of each parameter, and a list of techniques it supports, in the full Help for a command.}}