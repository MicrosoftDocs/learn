PowerShell scripting is the process of writing a set of statements in the PowerShell language and storing those statements in a text file. Why would you do that? After you use PowerShell for a while, you find yourself repeating certain tasks, like producing log reports or managing users. When you repeat something frequently, it's probably a good idea to automate it: to store it in such a way that makes it easy to reuse.

The steps to automate your task usually include calls to cmdlets, functions, variables, and more. To store these steps, you create a file that ends in *.ps1* and save it. You then have a script you can run.

Before you start learning to script, let's get an overview of the features of the PowerShell scripting language:

- **Variables**. You can use variables to store values. You can also use variables as arguments to commands.
- **Functions**. A function is a named list of statements. Functions produce an output that display in the console. You can also use functions as input for other commands.

   > [!NOTE]
   > Many of the tasks you'd use PowerShell for are about side effects or modifications to system state (local or otherwise). Often the output is a secondary concern (reporting data, for example).
- **Flow control**. Flow control is how you control various execution paths by using constructs like `If`, `ElseIf`, and `Else`.
- **Loops**. Loops are constructs that let you operate on arrays, inspect each item, and do some kind of operation on each item. But loops are about more than array iteration. You can also conditionally continue to run a loop by using `Do-While` loops. For more information, see [About Do](/powershell/module/microsoft.powershell.core/about/about_do?preserve-view=true&view=powershell-7.1).

- **Error handling**. It's important to write scripts that are robust and can handle various types of errors. You need to know the difference between terminating and nonterminating errors. You use constructs like `Try` and `Catch`. We cover this topic in the last conceptual unit of this module.
- **Expressions**. You frequently use expressions in PowerShell scripts. For example, to create custom columns or custom sort expressions. Expressions are representations of values in PowerShell syntax.
- **.NET and .NET Core integration**. PowerShell provides powerful integration with .NET and .NET Core. This integration is beyond the scope of this module.

## Run a script

You need to be aware that some scripts aren't safe. If you find a script on the internet, you probably shouldn't run it on your computer unless you understand exactly what it does. Even with scripts you consider safe, there might be a risk. For example, imagine a script that cleans things up in a test environment. That script might be harmful in a production environment. You need to understand what a script does, whether it was written by you or by a colleague or if you got it from the internet.

PowerShell attempts to protect you from doing things unintentionally in two main ways:

- **Requirement to run scripts by using a full path or relative path**. When you run a script, you always need to provide the script's path. Providing the path helps you to know exactly what you're running. For example, there could be commands and aliases on your computer you don't intend to run, but that have the same name as your script. Including the path provides an extra check to ensure you run exactly what you want to run.
- **Execution policy**. An execution policy is a safety feature. Like requiring the path of a script, a policy can stop you from doing unintentional things. You can set the policy on various levels, like the local computer, current user, or particular session. You can also use a Group Policy setting to set execution policies for computers and users.  

These two mechanisms don't stop you from opening a file, copying its contents, placing the contents in a text file, and running the file. They also don't stop you from running the code via the console. These mechanisms help to stop you from doing something unintentional. They aren't a security system.  

To create and run a script:

1. Create some PowerShell statements like the following and save them in a file that ends with *.ps1*:

   ```powershell
   # PI.ps1
   $PI = 3.14
   Write-Host "The value of `$PI is $PI"
   ```

1. Run the script by invoking it by its name and path:

   > [!NOTE]
   > Before you run the script, ensure the current shell is PowerShell. Alternatively, on Linux or macOS, you can put a shebang at the top of the script file to define PowerShell as the script interpreter.

   ```powershell
   ./PI.ps1
   ```

   We recommend you include the file extension in the invocation, but it's not required.

### Execution policy

You can manage execution policy using these cmdlets:

- `Get-ExecutionPolicy`. This cmdlet returns the current execution policy. On Linux and macOS, the value returned is `Unrestricted`. For these operating systems, you can't change the value. That limitation doesn't make Linux or Mac any less safe. Remember, an execution policy is a safety feature, not a security mechanism.

- `Set-ExecutionPolicy`. If you're using a Windows computer, you can use this cmdlet to change the value of an execution policy. It takes an `-ExecutionPolicy` parameter. There are a few possible values. It's a good idea to use `Default` as the value. That value sets the policy to `Restricted` on Windows clients and `RemoteSigned` on Windows Server. `Restricted` means you can't run scripts. You can run only commands, which makes sense on a client. `RemoteSigned` means that scripts written on the local computer can run. Scripts downloaded from the internet need to be signed by a digital signature from a trusted publisher.

   > [!NOTE]
   > There are other values you can use. To learn more, see [About execution policies](/powershell/module/microsoft.powershell.core/about/about_execution_policies?preserve-view=true&view=powershell-7.1).
  
## Variables

Variables aren't just for scripts. You can also define them on the console. You can store values in variables so you can use them later. To define a variable, precede it with the `$` character. Here's an example:

```powershell
$PI = 3.14
```

### Working with variables: Quotation marks and interpolation

When you output text via `Write-Host` or `Write-Output`, you can use single or double quotation marks. Your choice depends on whether you want to interpolate the values. There are three mechanisms you should know about:

- **Single quotation marks**. Single quotation marks specify literals; what you write is what you get. Here's an example:

   ```powershell
   Write-Host 'Here is $PI' # Prints Here is $PI
   ```

   If you want to *interpolate* &mdash; to get the value of `$PI` interpreted and printed &mdash; you need to use double quotation marks.

- **Double quotation marks**. When you use double quotation marks, variables in strings are interpolated:

   ```powershell
   Write-Host "Here is `$PI and its value is $PI" # Prints Here is $PI and its value is 3.14
   ```

   There are two things going on here. The back tick (\`) lets you escape what would be an interpolation of the first instance of `$PI`. In the second instance, the value is interpolated and is written out.  

- `$()`. You can also write an expression within double quotation marks. To do that, use the `$()` construct. One way to use this construct is to interpolate properties of objects. Here's an example:

   ```powershell
   Write-Host "An expression $($PI + 1)" # Prints An expression 4.14
   ```

## Scope

Scope is how PowerShell defines where constructs like variables, aliases, and functions can be read and changed. When you're learning to write scripts, you need to know what you have access to, what you can change, and where you can change it. If you don't understand how scope works, your code might not work as you expect it to.

### Types of scope

Let's talk about the various scopes:

- **Global scope**. When you create constructs like variables in this scope, they continue to exist after your session ends. Anything that's present when you start a new PowerShell session can be said to be in this scope.

- **Script scope**. When you run a script file, a script scope is created. For example, a variable or a function defined in the file is in the script scope. It will no longer exist after the file is finished running. For example, you can create a variable in the script file and target the global scope. But you need to explicitly define that scope by prepending the variable with the `global` keyword.

- **Local scope**. The local scope is the current scope, and can be the global scope or any other scope.

### Scope rules

Scope rules help you understand what values are visible at a given point. They also help you understand how to change a value.

- **Scopes can nest**. A scope can have a parent scope. A parent scope is an outer scope, outside of the scope you're in. For example, a local scope can have the global scope as a parent scope. Conversely, a scope can have a nested scope, also known as a *child scope*.

- **Items are visible in the current and child scopes**. An item, like a variable or a function, is visible in the scope in which it's created. By default, it's also visible in any child scopes. You can change that behavior by making the item private within the scope. Here's an example that uses a variable defined in the console:

   ```powershell
   $test = 'hi'
   ```

   If you have a *Script.ps1* file that contains the following content, it prints "hi" when the script runs:

   ```powershell
   Write-Host $test # Prints hi
   ```

   You can see that the variable `$test` is visible in both the local scope and its child scope, in this case, the script scope.

- **Items can be changed only in the created scope**. By default, you can change an item only in the scope in which it was created. You can change this behavior by explicitly specifying a different scope.

## Profiles

A profile is a script that runs when PowerShell starts. You can use a profile to customize your environment to, for example, change background colors and errors and do other types of customizations. PowerShell applies these changes to each new session you start.

### Profile types

PowerShell supports several profile files. You can apply them at various levels, as you see here:

|Description               |Path                                                               |
|--------------------------|-------------------------------------------------------------------|
|All users, all hosts      | $PSHOME\Profile.ps1                                               |
|All users, current host   | $PSHOME\Microsoft.PowerShell_profile.ps1                          |
|Current user, all hosts   | $Home\[My ]Documents\PowerShell\Profile.ps1                       |
|Current user, current host| $Home\[My ]Documents\PowerShell\Microsoft.PowerShell_profile.ps1  |

There are two variables here: `$PSHOME` and `$Home`. `$PSHOME` points to the installation directory for PowerShell. `$Home` is the current user's home directory.

Other programs also support profiles, like Visual Studio Code.

### Create a profile

When you first install PowerShell, there are no profiles, but there's a `$Profile` variable. It's an object that points to the path where each profile to apply should be placed. To create a profile:

1. Decide the level on which you want to create the profile. You can run `$Profile | Select-Object *` to see the profile types and the paths associated with them.

1. Select a profile type and create a text file at its location by using a command like this one: `New-Item -Path $Profile.CurrentUserCurrentHost`.

1. Add your customizations to the text file and save it. The next time you start a session, your changes will be applied.
