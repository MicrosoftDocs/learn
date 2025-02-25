Parameters modify the actions that a cmdlet performs. You can specify no parameters, one parameter, or many parameters for a cmdlet.

## Parameter format

Parameter names begin with a dash (-). A space separates the value that you want to pass from the parameter name. If the value that you're passing contains spaces, you need to wrap the text in quotation marks. Some parameters accept multiple values, which you must separate by commas and no spaces.

## Optional vs. required parameters

Parameters can be optional or required. If a parameter is required, and you run the cmdlet without providing a value for that parameter, Windows PowerShell prompts you to provide a value for it. For example, if you run the command **Get-Item**, you receive the following message from Windows PowerShell, which includes a prompt to provide a value for the *-Path* parameter:

`PS C:\> Get-Item`
`cmdlet Get-Item at command pipeline position 1`
`Supply values for the following parameters:`
`Path[0]:`

If you enter the text **C:\\** at the prompt and then press the Enter key twice, the command runs successfully. You must press the Enter key twice because this parameter can accept multiple values. Windows PowerShell continues prompting for a new value until you press the Enter key without actually providing it.

In some cases, entering the parameter name is optional and you can just enter the parameter's value. If you run the command **Get-ChildItem C:\\**, it's the same as running the command **Get-ChildItem -Path C:\\** because the parameter *-Path* is defined as the first parameter in the cmdlet definition. This is known as a positional parameter. You notice these throughout this course. Omitting the parameter name only works when a parameter position has been defined. Not all commands have positional parameters.

## Switches

*Switches* are a special case. They're basically parameters that accept a Boolean value (**true** or **false**). They differ from actual Boolean parameters in that the value is only set to **true** if the switch is included when running the command. An example is the *-Recurse* parameter or switch of the **Get-ChildItem** cmdlet. The command **Get-ChildItem c:\ -Recurse** returns not just the items in the C:\ directory, but also those in all of its subdirectories. Without the **-Recurse** switch, only the items in the C:\ directory are returned.

