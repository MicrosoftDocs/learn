So far, you've seen how adding parameters and flow-control constructs can make your scripts flexible and safer to use. But sometimes, you'll get errors in your scripts. You need a way to handle those errors. 

Here are some factors to consider:

- **How to handle the error**. Sometimes you get errors you can recover from, and sometimes it's better to stop the script. It's important to think about the kinds of errors that can happen and how to best manage them.

- **How severe the error is**. There are various kinds of error messages. Some are more like warnings to the user that something isn't OK. Some are more severe, and the user really needs to pay attention. Your error-handling approach depends on the type of error. The approach could be anything from presenting a message to raising the severity level and potentially stopping the script.

## Errors

 A cmdlet or function, for example, might generate many types of errors. We recommend that you write code to manage each type of error that might occur, and that you manage them appropriately given the type. For example, say you're trying to write to a file. You might get various types of errors depending on what's wrong. If you're not allowed to write to the file, you might get one type of error. If the file doesn't exist, you might get another type of error, and so on.

There are two types of errors you can get when you run PowerShell:

- **Terminating error**. An error of this type will stop execution on the row where the error occurred. You can handle this kind of error using either `Try-Catch` or `Trap`. If the error isn't handled, the script will quit at that point and no statements will run.

   > [!NOTE]
   > The `Trap` construct is outside the scope of this module. If you're interested, see [About Trap](/powershell/module/microsoft.powershell.core/about/about_trap?preserve-view=true&view=powershell-7.1).

- **Non-terminating error**. This type of error will notify the user that something is wrong, but the script will continue. You can upgrade this type of error to a terminating error.

### Managing errors by using `Try/Catch/Finally`

You can think of a terminating error as an unexpected error. These errors are severe. When you deal with one, you should consider what type of error it is and what to do about it.

There are three related constructs that can help you manage this type of error:

- `Try`. You'll use a `Try` block to encapsulate one or more statements. You'll place the code that you want to run &mdash; for example, code that writes to a data source &mdash; inside braces. A `Try` must have at least one `Catch` or `Finally` block. Here's how it looks:


   ```powershell
   Try {
     # Statement. For example, call a command.
     # Another statement. For example, assign a variable.
   }
   ```

- `Catch`. You'll use this keyword to *catch* or *manage* an error when it occurs. You'll then inspect the exception object to understand what type of error occurred, where it occurred, and whether the script can recover. A `Catch` follows immediately after a `Try`. You can include more than one `Catch` &mdash; one for each type of error &mdash; if you want. Here's an example:

   ```powershell
   Try {
     # Do something with a file.
   } Catch [System.IO.IOException] {
     Write-Host "Something went wrong"
   }  Catch {
     # Catch all. It's not an IOException but something else.
   }
   ```

   The script tries to run a command that does some I/O work. The first `Catch` catches a specific type of error: `[System.IO.IOException]`. The last `Catch` catches anything that's not a `[System.IO.IOException]`.

- `Finally`. The statements in this block will run regardless of whether anything goes wrong. You probably won't use this block much, but it can be useful for cleaning up resources, for example. To use it, add it as the last block:

   ```powershell
   Try {
     # Do something with a file.
   } Catch [System.IO.IOException] {
     Write-Host "Something went wrong"
   }  Catch {
     # Catch all. It's not an IOException but something else.
   } Finally {
     # Clean up resources.
   }
   ```

### Inspecting errors

We've talked about exception objects in the context of catching errors. You can use these objects to inspect what went wrong and take appropriate measures. An exception object contains:

- **A message**. The message tells you in a few words what went wrong.

- **The stacktrace**. The stacktrace tells you which statements ran before the error. Imagine you have a call to function A, followed by B, followed by C. The script stops responding at C. The stacktrace will show that chain of calls.

- **The offending row**. The exception object also tells you which row the script was running when the error occurred. This information can help you debug your code.

So how do you inspect an exception object? There's a built-in variable, `$_`, that has an `exception` property. To get the error message, for example, you would use `$_.exception.message`. In code, it might look like this:

```powershell
Try {
     # Do something with a file.
   } Catch [System.IO.IOException] {
     Write-Host "Something IO went wrong: $($_.exception.message)"
   }  Catch {
     Write-Host "Something else went wrong: $($_.exception.message)"
   }
```

## Raising errors

In some situations, you might want to cause an error:

- **Non-terminating errors**. For this type of error, PowerShell just notifies you that something went wrong, by using the `Write-Error` cmdlet, for example. The script continues to run. That might not be the behavior you want. To raise the severity of the error, you can use a parameter like `-ErrorAction` to cause an error that can be caught with `Try/Catch`, like so:

   ```powershell
   Try {
     Get-Content './file.txt' -ErrorAction Stop
   } Catch {
     Write-Error "File can't be found"
   }
   ```

   By using the `-ErrorAction` parameter and the value `Stop`, you can cause an error that `Try/Catch` can catch.

- **Business rules**. You might have a situation where the code doesn't actually stop responding, but you want it to for business reasons. Imagine you're sanitizing input and you check whether a parameter is a path. A business requirement might specify only certain paths are allowed, or the path needs to look a certain way. If the checks fail, it makes sense to *throw* an error. In a situation like this, you can use a `Throw` block:

   ```powershell
   Try {
     If ($Path -eq './forbidden') 
     {
       Throw "Path not allowed"
     }
     # Carry on.
     
   } Catch {
     Write-Error "$($_.exception.message)" # Path not allowed.
   }
   
   ```

   > [!NOTE]
   > In general, don't use `Throw` for parameter validation. Use [validation attributes](/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?preserve-view=true&view=powershell-7.1#parameter-and-variable-validation-attributes) instead. If you can't make your code work with these attributes, a `Throw` might be OK.
