PowerShell Scripting is the action of writing a set of statements in the PowerShell language and stores those statements in a text file. Why would you do that? After using PowerShell for a while, you find yourself repeating certain tasks like producing log reports, or managing users for example. When you've repeated something often enough, it's probably a good idea to automate it, to store it in such a way that's easy to reuse.

The steps making out your task is usually a mixture of calls to cmdlets, functions, variables and more. To store all these steps, create a file ending in _.ps1_ and save it, now you have a script that you can run.

Before you start learning to script, lets get a mile-high view of the features of the PowerShell as a scripting language:

- **Variables**, you can use variables to store values and the variables can be used as arguments to commands for example.
- **Functions**, functions  consist of a list of statements and is something you can associate a name to. Functions can produce an output, that can be displayed in the console, or used as input for other commands for example.

   > [!NOTE]
   > Many of the tasks PowerShell is used for is about side-effects or modifications to system state (local or otherwise). Often the output is a secondary concern (reporting data or otherwise)
- **Flow control**, flow control is the way you control various execution paths using constructs such as IF, ELSEIF, and ELSE.
- **Loops**, loops are constructs that allow you to operate on arrays and inspect each item and perform some kind of operation. Loops are about more than array iteration however - there's also _conditionally continue to execute_ in the form of do/while [see get-help about_do](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.1&preserve-view=true)

- **Error handling**, it's important to author scripts that are robust and is able to handle different types of errors. There are terminating and non terminating errors and constructs like `Try` and `Catch` that's involved in this process. This topic will be covered in the last concept part of this module.
- **Expressions**, you use expressions often when scripting in PowerShell, for example to create custom columns or custom sort expressions. Expressions are representations of values in PowerShell syntax.
- **.NET/.NET Core integration**. PowerShell is able to integrate with .NET and .NET Core. It's a powerful but out of scope for this module.

## Run a script

You need to be aware that not all scripts you intend to run might be safe. If you find a script out there on the Internet, it might not be a good idea to run it on your machine unless you understand exactly what it does. Even with scripts you consider safe, there might be a risk. Consider a scenario where you have a script that cleans things up in a test environment. Such a script might be harmful in a production environment. The takeaway is that it's important to understand what a script does, whether it's authored by you, your colleague or by someone on the Internet.

PowerShell has the notion of wanting to protect you from doing things unintentionally. It has two major mechanisms for this approach:

- **Scripts need to be run using a full path or relative path**. When you run a script, you always need to do so by providing the path to the script. Providing the path is a way for you to know exactly what you run. There could, for example, be commands and aliases located somewhere on your machine that you don't intend to run that has the same name as your script. By providing the path to the script, it's an extra check for you, to ensure you run exactly what you intended.
- **Execution policy**. An execution policy is a safety feature and like asking for the path of a script when running it, the policy stops you from doing unintentional things. The policy can be set on different levels like, local computer, current user, or for a particular session. You can also use a Group Policy setting to set execution policies for computers and users.  

With these two mechanisms in place, nothings stops you from opening a file, copy its content and place that in a text file of your creation, and run it, or run it via the console. It's worth stressing that these mechanisms stop you only from doing something unintentional, it's not a security system.  

Creating and running a script involves the following steps:

1. Create some PowerShell statements like the below and save them in a file ending with _.ps1_:

   ```powershell
   # PI.ps1
   $PI = 3.14
   Write-Host "The value of `$PI is $PI"
   ```

1. You run it by invoking it by name, and its path, like so:

   > [!NOTE]
   > To run the script, ensure the current shell is PowerShell. Alternatively, on Linux/MacOS you can put a shebang to define powershell as the script interpreter. at the top of the script file.
   ```bash
   ./PI.ps1
   ```

   It's recommended to include the file ending in the invocation, but not necessary.

### Execution policy

You can manage the execution policy using the following cmdlets:

- `Get-ExecutionPolicy`. This cmdlet returns the current execution policy. On Linux and macOS the value returned is `Unrestricted` and for these OSs the value cannot be changed. it doesn't make Linux and Mac any less safe, remember it's not a security feature but rather a safety mechanism.

- `Set-ExecutionPolicy`. With this cmdlet you can change the value, if you are on a Windows machine. It takes a parameter `-ExecutionPolicy` and there are a few possible values. You're well off setting `Default` as value, which sets the value `Restricted` on a Windows Client and the value `RemoteSigned` for Windows Server. `Restricted` means you can't run any scripts, only commands, which make sense on a client. `RemoteSigned` means that scripts can run, that are authored on the local computer. Scripts downloaded off the Internet however need to be signed by a digital signature from a trusted publisher.

> [!NOTE]
> There's some additional values you can set, with different meaning. If you're interested to learn more, have a read on this docs page [about Execution Policies](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.1&preserve-view=true)
  
## Introducing variables
Variables aren't something that is for scripts alone, but can be defined in the console as well. You are meant to store values in variables to be used in later execution. To define a variable, it needs to be preceded by `$` character. Here's an example of a variable being defined:

```powershell
$PI = 3.14
```

### Working with Variables, Quotes and Interpolation

When you output text via `Write-Host` or `Write-Output`, you do so using single quotes or double quotes. There is a difference between using the two types of quotes. The difference being if you want to interpolate values or not. Here's three mechanisms that's good to know about:

- `Single quote`. Single quotes are literals, it means that what you write is what you get. Here's an example:

   ```powershell
   Write-Host 'Here is $PI' # prints Here is $PI
   ```

   If you meant to _interpolate_, to get the value of `$PI` interpreted and written out, you need to use a double quote.

- `Double quote`. With double quotes you can interpolate variables in strings, like so:

   ```powershell
   Write-Host "Here is `$PI and its value is $PI" # prints Here is $PI and its value is 3.14
   ```

   There are two things going on here, the back tick helps you escape what would be an interpolation in the first case and in the second case the value is interpolated and written out.  

- `$()`. You can also write an expression while using a double quote. The expression goes within the `$()` construct. A good use case is using this construct to interpolate properties of objects. Here's an example of this mechanism in action:

   ```powershell
   Write-Host "An expression $($PI + 1)" # Prints An expression 4.14
   ```

## Scope

What are scopes? Scopes are PowerShell's way to protect constructs such as variables, alias, functions, and more where they can be read and changed. Why do you need to know about scope learning to script? Well, it's good to know what you have access to and what you can change and where. If you misunderstand how this works, your code might not work as expected.

### Types of scope

Let's talk about the different scopes that exist, to explain scopes further:

- **Global scope**. When you create things like variables for example in this scope, it continues to exist after your session ended. Anything that's present when you start a new PowerShell session can be said to be in this scope.

- **Script scope**. When you run a script file, a script scope is created. A variable or a function for example, defined in this file, exist in the script scope and will seize to exist once the file has finished executing. You can however create a variable, for example,  in the script file and target the global scope, but you have to be explicit about it and prepend it with a _global_ keyword.

- **Local scope**. It's the current scope, which can be either the global scope or any other scope.

### Scope rules

There are some rules that apply to scope. These rules help you understand what's values are visible at a given point. It also helps to understand how to change a value.

- **Scopes can nest**. There's a notion of a parent scope. It's an outer scope, outside of the scope you're in. So a local scope for example, can have the global scope as a parent scope. Conversely a scope can have a nested scope, also known as a child scope.

- **Visible in current and child scope**. An item, like a variable or a function, for example,  is visible in the scope it's created in. It's also visible in any child scopes by default. You can change that if you want, by making it private within that scope. An example of this can defining a variable in the console like so:

   ```powershell
   $test = 'hi'
   ```

   If you have a file Script.ps1 with the following content, then it will print **hi** when script is run:

   ```powershell
   Write-Host $test # prints hi
   ```

   What you're seeing is the variable `$test` being visible in both local scope and its child scope, in this case, the script scope.

- **Can only be changed in the created scope**. Normally you can only change the item in the scope it was created in. However, it's possible to change it if you explicitly specify a different scope.

## Profile

At the core of it, a profile is a script that runs when PowerShell starts. With a profile you can customize your environment and change, for example,  colors of background, errors, and more and do other types of customizations. These changes will be applied to each new session you start.

### Profile types

PowerShell supports several profile files and they can be applied on different levels like so:

|Description               |Path                                                               |
|--------------------------|-------------------------------------------------------------------|
|All Users, All Hosts      | $PSHOME\Profile.ps1                                               |
|All Users, Current Host   | $PSHOME\Microsoft.PowerShell_profile.ps1                          |
|Current User, All Hosts   | $Home\[My ]Documents\PowerShell\Profile.ps1                       |
|Current user, Current Host| $Home\[My ]Documents\PowerShell\Microsoft.PowerShell_profile.ps1  |

There are two variables mentioned here `$PSHOME` and `$Home`. `$PSHOME` is pointing on the installation directory for PowerShell and home is the current users home directory.

There are also other programs than PowerShell that supports profile like Visual Studio Code for example.

### Creating a profile

When you first install PowerShell, there are no profiles. However, a `$Profile` variable exists. It's an object pointing to the path of where each profile should be placed in order for the profile to be applied. What you do to create a profile is:

1. Decide on at what level you want to create a profile. You can run `$Profile | Select-Object *` to see what profile types exist and what path is associated with them.

1. Select a profile type and create a text file at its location, using a command like so  `New-Item -Path $Profile.CurrentUserCurrentHost`.

1. Add your customizations to the text file and save it. Next time you start a session you will see your changes being applied.
