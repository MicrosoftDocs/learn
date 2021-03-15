You're at a point where you've created a few scripts and you start noticing your scripts aren't flexible. You need to actively go into your scripts and change them. There's a better way to handle changes, namely to use parameters.

Relying on parameters, makes your scripts flexible in that it allows users to select options or send input into the scripts. You will have less reason to change the scripts, it can in some cases be enough to just change a parameter value.

Cmdlets, functions, and scripts all accept parameters.

## Declare and use a parameter

To declare a parameter, you need to add the keyword `Param` with an open and close parenthesis like so:

```powershell
Param()
```

Inside of the parenthesis you define your parameters separated by a comma. A typical parameter declaration can look like so:

```powershell
# CreateFile.ps1
Param (
  $Path
)
New-Item $Path # creates a new file at $Path
Write-Host "File $Path was created"
```

The script has a parameter `$Path` that's later used in the script to create a file. This script has now been made more flexible.

### Using the parameter

To call a script with a parameter, you need to provide it with name and a value. Assume the above script is called `CreateFile.ps1` then you could call it like so:

```powershell
./CreateFile.ps1 -Path './newfile.txt' # File ./newfile.txt was created
./CreateFile.ps1 -Path './anotherfile.txt' # File ./anotherfile.txt was created
```

Thanks to the use of a parameter, you don't need to change the script file when you want to call the file something else.

> [!NOTE]
> This particular script might not benefit so much from using a parameter as it only call `New-Item`. However, as soon as your script is a few lines long it will pay off.
## Improve parameters

Adding parameters to your scripts is a great way to make them flexible. Because you created a script, you might remember exactly what a parameter is for and what reasonable values are for one or more parameters. However, as time passes you might forget these details and you might also want to give a script to a colleague for an example. The solution is to be explicit and thereby make your script easy to use. What you want from the script is to fail early if its passed unreasonable parameter values. Here's some things to consider when defining parameters:

- **Is it mandatory?**. Is a parameter optional or mandatory.
- **What's an allowed value?**. What are reasonable values?
- **Is it only one type of values?**. Does the parameter accept any type of values like string, boolean, integers, objects etc.?
- **Can the parameter rely on a default?**. Would it be ok to omit the value altogether and rely on a default value that's used instead?
- **Can you improve the user experience further?**. Can you be even clearer to the user by providing a help message?

## Select approach

All parameters are by default optional. That might work for some cases but sometimes you need the user to provide parameter values, reasonable values even. If the user doesn't provide a value, to a parameter, then the script should quit or tell the user how to fix it. The worst thing that can happen is that the script continuous to run and ends up doing things that weren't intended.

There are a couple of approaches you could use to make for a safer running script. Either you can write custom code to inspect the parameter value or you could use decorators that do roughly the same thing. Below is the two approaches described:

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