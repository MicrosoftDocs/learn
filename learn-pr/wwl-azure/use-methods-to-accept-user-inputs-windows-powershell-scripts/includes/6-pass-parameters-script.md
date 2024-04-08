You can configure your scripts to accept parameters in the same way that cmdlets do. This is a good method for users to provide input because it's consistent with how users provide input for cmdlets. The consistency makes it easier for users to understand.

To identify the variables that will store parameter values, you use a **Param()** block. The variable names are defined between the parentheses. The syntax for using a **Param()** block is:

```powershell
Param(
   [string]$ComputerName ,
   [int]$EventID
)
```

The variable names defined in the **Param()** block are also the names of the parameters. In the previous example, the script containing this **Param()** block has the *-ComputerName* and *-EventID* parameters that can be used. When you enter the parameter names for the script, you can use tab completion just as you can for cmdlet parameters. The syntax for running a script with parameters is:

```powershell
.\GetEvent.ps1 -ComputerName LON-DC1 -EventID 5772
```

> [!NOTE] 
> Parameters are positional by default. If the parameter names aren't specified, then the parameter values are passed to the parameters in order. For example, the first value after the script name is placed in the first parameter variable.

> [!NOTE] 
> If you don't put a **Param()** block in your script, you can still pass data into the script by using unnamed parameters. The values that are provided after the script name are available inside the script in the `$args` array.

## Defining variable types

It's a best practice to define variable types in a **Param()** block. When you define the variable types, if a user enters a value that can't be converted to that variable type, an error is generated. This is one method for you to validate the data that users enter.

You can use the switch variable type for a parameter when there's an option that you want to be on or off. When the script is run, the parameter’s presence sets the variable to `$true`. If the parameter isn't present, then the value for a variable is `$false`. For example, in a script that typically displays some status information to users, you could create a *-quiet* parameter that suppresses all output to screen.

A switch variable is generally preferred over a boolean variable for parameters because the syntax for users is simpler. The users don't need to include a `$true` or `$false` value.

## Default values

You can define default values for parameters in the **Param()** block. The default values that you define are only used if the user doesn't provide a value for the parameter. This ensures that every necessary parameter has a value.

The following example depicts how to set a default value:

```powershell
Param(
   [string]$ComputerName = "LON-DC1"
)
```

## Requesting user input

You can also prompt for input if the user doesn't provide a parameter value. This ensures that the user provides a value for a parameter when there isn't a logical default value that you can specify.

The following example depicts how to prompt users for input:

```powershell
Param(
   [int]$EventID = Read-Host "Enter event ID"
)
```

> [!NOTE] 
> You can configure additional advanced options for parameters in a script, such as making a parameter mandatory, by using the **Parameter()** attribute in the **Param()** block.

> **Additional reading:** For more information about the **Parameter()** attribute, refer to [about_Functions_Advanced_Parameters](https://aka.ms/about-functions-advanced-parameters).

