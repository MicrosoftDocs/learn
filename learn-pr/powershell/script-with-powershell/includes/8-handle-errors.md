So far you've seen how adding parameters and flow control constructs, can make your scripts flexible and safer to use. However, sometimes you get errors in your script you need an approach to handle those errors. 

As you look at handling errors in your script, there are some factors to consider:

- **How to handle the error**. Sometimes you get errors that you can recover from and sometimes it's better to exit the script. It's important to think about what kind of errors that can happen and how to best manage them.

- **All errors are not the same**. There are different kinds of error messages, sometimes it's more of a warning to the user that something is not ok. Sometimes it's more severe and the user should really pay attention. Depending on what type of error it is, your approach to handling the error might be anything from showing some text to raise the severity level and potentially exit the script.

## Errors

 A cmdlet or function, for example,  might generate many different types of errors. It's recommended that you write code to manage each type of error that might occur and that it's managed differently. Consider a case where you try to write to a file, you might get different types of errors, depending on what's wrong. If you're not allowed to write to the file, you might get one type of error, if the file doesn't exist, you might get another type of error and so on.

There are two types of errors you can get, when running PowerShell:

- **Terminating error**. An error of this sort will stop execution on the row the error occurred. These kinds of errors can be handled either by using `Try/Catch` or by using `Trap`. If the error is not handled, the script will quit at this point and no statements are run.

   > [!NOTE] 
   > The `Trap` construct is outside the scope of this module, but if you are interested, you can [read about Trap here](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_trap?view=powershell-7.1&preserve-view=true).
- **Non terminating error**. This type of error will not notify the user is wrong somehow, but the script will continue to wrong. This type of error can be _upgraded_ to a terminating error.

### Managing errors with Try/Catch/Finally

A terminating error should be thought of as an unexpected error. The error itself is severe so when dealing with it you want to consider what type of error it is and what to do about it.
There are three  related constructs that help you manage such an error:

- `Try`, you encapsulate a statement or statements in a `Try` block, using curly braces. This is where you would place the code that you want to run like, for example,  writing to a data source. A `Try` must have at least one `Catch` or one `Finally` block.

   ```powershell
   Try {
     # Statement, e.g call a command
     # Another statement, e.g assign a variable for example
   }
   ```

- `Catch`, this keyword means it will _catch_ or _manage_ an error when it occurs. The idea is then to inspect the exception object to understand, what type of error you got, where it occurred and whether the script can recover from this error. A `Catch` follows immediately after a `Try` and thereby can be more than one `Catch`, one for each type of error if you wish it.

   ```powershell
   Try {
     # Doing something with a file
   } Catch [System.IO.IOException] {
     Write-Host "Something went wrong"
   }  Catch {
     # Catch all, it's not an IOException but something else
   }
   ```

   The script attempts to carry out a command that does some IO work. The first `Catch` catches a specific type of error `[System.IO.IOException]`. The last `Catch`, catches everything that's not a `[System.IO.IOException]`.

- `Finally`, What this block means, is that the statements run within this block will run regardless of if something went wrong or not. You won't see this block used so much but it can definitely be useful for cleaning up resources for example. To use it, place it as the last block, like so:

   ```powershell
   Try {
     # Doing something with a file
   } Catch [System.IO.IOException] {
     Write-Host "Something went wrong"
   }  Catch {
     # Catch all, it's not an IOException but something else
   } Finally {
     # Clean up resources
   }
   ```

### Inspect error

You've heard the mention of an exception object in the context of catching an error. The idea is for you to inspect what went wrong and take appropriate measures. So what does it contain:

  - **A message**. The message tells you in a few words what went wrong.

  - **The Stacktrace**. It tells you which statements were executed prior to ending up with an error. So imagine you had to call function A, followed by B, followed by C and then it crashes in C. The stacktrace would then show that chain of calls.

  - **Offending row**. The error object is also capable of telling you what row in the script the error happened. Knowing this information can help you delouse your code faster.

So how do you inspect the exception object? There's a built-in variable `$_` that has a property `exception`. To list the error message for example, you would have to drill down into it like so, `$_.exception.message`. Used in a piece of code it could look like so:

```powershell
Try {
     # Doing something with a file
   } Catch [System.IO.IOException] {
     Write-Host "Something IO went wrong: $($_.error.message)"
   }  Catch {
     Write-Host "Something else went wrong: $($_.error.message)"
   }
```

## Raising errors

You can have two different types of situations where you want to cause an error:

- **Non terminating error**. When you have an error like this, it just writes out that something went wrong, using for example the `Write-Error` cmdlet, and continues to run. That behavior might not be what you want. To raise the severity of the error, you can use a parameter like `-ErrorAction` to cause an error that can be caught using `Try/Catch`, like so:

   ```powershell
   Try {
     Get-Content './file.txt' -ErrorAction Stop
   } Catch {
     Write-Host "File can't be found"
   }
   ```

   By using the `-ErrorAction` parameter and the value `Stop`, you're able to _cause_ an error, that can be caught by `Try/Catch`.

- **A specific situation**. You might having a situation where the code doesn't actually crash but for maybe business reasons it should. Imagine you are sanitizing input and you try to check if a parameter is a path. A business requirement might then be that only certain paths are allowed or that the content of the path needs to look a certain way. If the checks fail, it makes sense to _throw_ an error. For a situation like this, you can use the `Throw` block like so:

   ```powershell
   Try {
     If ($Path -eq './forbidden') 
     {
       Throw "Path not allowed"
     }
     # Carry on
     
   } Catch {
     Write-Error "$($_.exception.message)" # Path not allowed
   }
   
   ```

   > [!NOTE]
   > In general, don't use `Throw` on parameter validation. There's a section in the docs that advocates [using validation attributes](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7.1#parameter-and-variable-validation-attributes&preserve-view=true) instead. If you can't make it work with any of these attributes then a `Throw` might be ok.