After you've created a few scripts, you might notice that your scripts aren't flexible. Going into your scripts to change them isn't efficient. There's a better way to handle changes: use parameters.

Using parameters makes your scripts flexible because it allows users to select options or send input to the scripts. You won't need to change your scripts as frequently because in some cases you'll just need to change a parameter value.

Cmdlets, functions, and scripts all accept parameters.

## Declare and use a parameter

To declare a parameter, you need to use the keyword `Param` with an open and close parenthesis, like so:

```powershell
Param()
```

Inside the parentheses, you define your parameters, separating them with commas. A typical parameter declaration might look like this one:

```powershell
# CreateFile.ps1
Param (
  $Path
)
New-Item $Path # Creates a new file at $Path
Write-Host "File $Path was created"
```

The script has a parameter `$Path` that's later used in the script to create a file. The script is now more flexible.

### Use the parameter

To call a script with a parameter, you need to provide a name and a value. Assume the above script is called `CreateFile.ps1`. You could call it like so:

```powershell
./CreateFile.ps1 -Path './newfile.txt' # File ./newfile.txt was created
./CreateFile.ps1 -Path './anotherfile.txt' # File ./anotherfile.txt was created
```

Because you used a parameter, you don't need to change the script file when you want to call the file something else.

> [!NOTE]
> This particular script might not benefit much from using a parameter because it only calls `New-Item`. But as soon as your script is a few lines long, using the parameter will pay off.

## Improve your parameters

When you first create a script with parameters, you might remember exactly what the parameters are for and what values are reasonable for them. As time passes, you might forget those details. You might also want to give a script to a colleague. The solution to these problems is to be explicit, which makes your scripts easy to use. You want a script to fail early if it's passed unreasonable parameter values. Here are some things to consider when you define parameters:

- **Is it mandatory?** Is the parameter optional or required?
- **What values are allowed?** What values are reasonable?
- **Does it accept more than one type of values** Does the parameter accept any type of value, like string, Boolean, integer, and object?
- **Can the parameter rely on a default?** Would it be OK to omit the value altogether and rely on a default value instead?
- **Can you further improve the user experience?** Can you be even clearer to your user by providing a Help message?

## Select an approach

All parameters are by default optional. That might work in some cases. But sometimes you need your user to provide parameter values, and the values need to be reasonable ones. If the user doesn't provide a value to a parameter, the script should quit or tell the user how to fix the problem. The worst thing that can happen is for the script to continue and do things that you don't want it to do.

There are a couple of approaches you can use to make your script safer. You can write custom code to inspect the parameter value. Or you can use decorators that do roughly the same thing. Let's look at both approaches.

- **Use `If/Else`**. By using an `If/Else` construct you can check the value of the parameter and then decide what to do, like the below script:

   ```powershell
   Param(
     $Path
   )
   If (-Not $Path -eq '') {
     New-Item $Path
     Write-Host "File created at path $Path"
   } Else {
     Write-Error "Path cannot be empty"
   } 
   ```

   The script will run `Write-Error` if you don't provide a value for `$Path`.

- **Use `Parameter[]` decorator**. A better way (less to type) is to use the `Parameter[]` decorator, like so:

   ```powershell
   Param(
     [Parameter(Mandatory)]
     $Path
   )
   New-Item $Path
   Write-Host "File created at path $Path"
   ```

   If you run this script, and omit a value for `$Path`, PowerShell ensures you end up in dialog where you're asked for the value of `$Path`:

   ```output
   cmdlet CreateFile.ps1 at command pipeline position 1
   Supply values for the following parameters:
   Path:
   ```

   You can improve this decorator further by providing a help message that the user will see when running the script.  

   ```powershell
   [Parameter(Mandatory, HelpMessage = "Please provide a valid path")]
   ```

   When you run the script you will get an output that tells you to type `!?` for more information, like so:

   ```powershell
   cmdlet CreateFile.ps1 at command pipeline position 1
   Supply values for the following parameters:
   (Type !? for Help.)
   Path: !?  # you type !?
   Please supply a valid path  # Your help message
   ```

- **Assign a type**. By assigning a type to a parameter you can say, for example,  that this parameter accepts only strings, no booleans. Thereby, you're giving the user a good understanding of what to expect. You can assign a type to a parameter by preceding it with a square bracket and the type, like so:

   ```powershell
   Param(
     [string]$Path
   )
   ```

These three approaches are not exclusionary, you can definitely combine them and make your script more intentional and more safe to run.