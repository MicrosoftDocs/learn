In this unit, you use Azure Cloud Shell on the right as your Linux terminal. Azure Cloud Shell is a shell that you can access through the Azure portal or at https://shell.azure.com. You don't have to install anything on your PC or laptop to use it.

When you author scripts, they might work as intended as long as you type in _reasonable_ values. However if time passes or someone else runs that script you wrote, there's a high likelihood someone will input an unintended value to the script, or some other precondition is not met. To avoid situations such as these you should _sanitize_ your input, meaning you should add logic to your script ensuring that it quits early if something is wrong and only continues to run if everything is fine.

> [!NOTE]
> Only carry out the below steps if you haven't run any of the previous exercises. This exercise assumes you've completed the previous ones in this module. If you haven't done so, you need a few files.
1. Run the following commands:

   ```bash
   mkdir webapp
   cd webapp
   touch index.html app.js
   cd ..
   ```

   These commands will create a directory with files typically associated with web development.

## Add checks to your script parameters

You've been working with a backup script so far. You've been adding parameters to it but you can make it even safer to use by adding checks that ensure the script only continues to do its thing if provided reasonable parameter input.

Let's have a look at the script so far, if you run the previous exercise you should have a file called _Backup.ps1_. If not, create such a file:  

```bash
touch Backup.ps1
```

and give it the following content:

```powershell
Param(
     [string]$Path = './app',
     [string]$DestinationPath = './'
   )
   $date = Get-Date -format "yyyy-MM-dd"
   Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
   Write-Host "Created backup at $( $DestinationPath + 'backup-' + $date).zip"
```

Since the previous exercise, you knew the script would crash if `$Path` pointed to a directory didn't exist.

1. Use an existing PowerShell shell, if you have, otherwise, start one by typing `pwsh` in a terminal:

   ```bash
   pwsh
   ```

1. Let's add a check for the `$Path` parameter by adding the following code right after the `Param` section:

   ```powershell
   If(-Not (Test-Path $Path)) 
   {
     Throw "The source directory $Path does not exist, please specify an existing directory"
   }
   ```

   You've added a check that checks if `$Path` exist. If it doesn't, you close down the script while providing the user with a reason why it went wrong so the user can fix it.

1. Ensure the script works as intended by running it:

   ```powershell
   ./Backup.ps1 -Path './app'
   ```

   You should see the following output from the script:

   ```output
   Throw "The source directory $Path does not exist, please specify  …
     |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | The source directory ./app does not exist, please specify an
     | existing directory
   ```

1. Next, test that the script still works as intended (Ensure you've removed any backup files from the last exercise before continuing)

    ```powershell
    ./Backup.ps1 -Path './webapp'
    ```

    You should see an output that says something similar to:

    ```output
    Created backup at ./backup-2021-01-19.zip 
    ```

    Where you to run that script again, it would crash, it would complain that the zip file already existed. Lets fix that by adding a check that only creates the script if no backup zip file, from today, already exist.

1. Change the code of the file to look like so:

   ```powershell
   Param(
     [string]$Path = './app',
     [string]$DestinationPath = './'
   )
   If(-Not (Test-Path $Path)) 
   {
     Throw "The source directory $Path does not exist, please specify an existing directory"
   }
   $date = Get-Date -format "yyyy-MM-dd"
   $DestinationFile = "$($DestinationPath + 'backup-')$date.zip"
   If(-Not (Test-Path $DestinationFile)) 
   {
     Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
     Write-Host "Created backup at $( $DestinationPath + 'backup-' + $date).zip"
   } Else {
     Write-Error "Today's backup already exist"
   }
   ```

   What you did was two things, you created a new variable `$DestinationFile`, to make it easy to check if this path already existed. Secondly, you defined logic that said, only create zip file if the file doesn't already exist, this code:

   ```powershell
   If(-Not (Test-Path $DestinationFile)) 
   {
     Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
     Write-Host "Created backup at $( $DestinationPath + 'backup-' + $date).zip"
   } Else {
     Write-Error "Today's backup already exist"
   }
   ```

1. Run the code to ensure it doesn't crash and that your logic is applied:

   ```bash
   ./Backup.ps1 -Path './webapp' 
   ```

   You should see the following output:

   ```output
   Write-Error: Today's backup already exist
   ```

Congrats, you've managed to make your script a little safer to run. It's still possible to provide less good input to `$DestinationPath` for example. The point of this exercise was to show how to add some checks. Depending on the environment the script will run in, you might have fewer checks or a lot more and even written tests, it all depends on the context.