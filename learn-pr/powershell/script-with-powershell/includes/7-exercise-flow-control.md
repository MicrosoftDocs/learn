In this unit, you'll use Azure Cloud Shell on the right side of your screen as your Linux terminal. Azure Cloud Shell is a shell you can access through the Azure portal or at https://shell.azure.com. You don't have to install anything on your computer to use it.

When you write scripts, they might work as intended as long as you type in reasonable values. But if time passes or someone else runs the script, it's likely that someone will enter an unintended value or that some other precondition won't be met. To avoid situations like this, you should *sanitize* your input; that is, you should add logic to your script to ensure it quits early if something is wrong and continues to run only if everything is fine.

> [!NOTE]
> Run the following commands only if you haven't completed any of the previous exercises in this module. We're assuming you've completed the previous exercises. If you haven't done so, you need a few files.

- If you haven't completed the previous exercises in this module, run the following bash commands in a terminal:

   ```bash
   mkdir webapp
   cd webapp
   touch index.html app.js
   cd ..
   ```

   These commands will create a directory that contains files typically associated with web development.

## Add checks to your script parameters

You've been working with a backup script so far, and you've been adding parameters to it. You can make your script even safer to use by adding checks that ensure the script only continues if it's provided reasonable parameter inputs.

Let's look at the current script. If you completed the previous exercise, you should have a file called _Backup.ps1_. If not, create the file and open it in your code editor:  

```bash
touch Backup.ps1
code Backup.ps1
```

Add this code to the file:

```powershell
Param(
  [string]$Path = './app',
  [string]$DestinationPath = './'
)
$date = Get-Date -format "yyyy-MM-dd"
Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
Write-Host "Created backup at $($DestinationPath + 'backup-' + $date + '.zip')"
```

As you know, the script will stop responding if `$Path` points to a directory that doesn't exist.

1. Use an existing PowerShell shell if you have one running. Otherwise, start one by typing `pwsh` in a terminal:

   ```bash
   pwsh
   ```

1. Add a check for the `$Path` parameter by adding this code right after the `Param` section, then save the file:

   ```powershell
   If (-Not (Test-Path $Path)) 
   {
     Throw "The source directory $Path does not exist, please specify an existing directory"
   }
   ```

   You've added a test that checks if `$Path` exists. If it doesn't, you stop the script. You also explain to users what went wrong so they can fix the problem.

1. Ensure the script works as intended by running it:

   ```powershell
   ./Backup.ps1 -Path './app'
   ```

   You should see this output:

   ```output
   Throw "The source directory $Path does not exist, please specify  …
     |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | The source directory ./app does not exist, please specify an
     | existing directory
   ```

1. Test that the script still works as intended. (Be sure to remove any backup files from the previous exercise before you continue.)

    ```powershell
    ./Backup.ps1 -Path './webapp'
    ```

    You should see a message that looks similar to this one:

    ```output
    Created backup at ./backup-2021-01-19.zip 
    ```

    If you run the script again, it will stop responding. It will notify you that the zip file already exists. Let's fix that problem. We'll add code to ensure the backup is created only if no other backup zip file from the current day exists.

1. Replace the code in the file with this code, then save the file:

   ```powershell
   Param(
     [string]$Path = './app',
     [string]$DestinationPath = './'
   )
   If (-Not (Test-Path $Path)) 
   {
     Throw "The source directory $Path does not exist, please specify an existing directory"
   }
   $date = Get-Date -format "yyyy-MM-dd"
   $DestinationFile = "$($DestinationPath + 'backup-' + $date + '.zip')"
   If (-Not (Test-Path $DestinationFile)) 
   {
     Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
     Write-Host "Created backup at $($DestinationPath + 'backup-' + $date + '.zip')"
   } Else {
     Write-Error "Today's backup already exists"
   }
   ```

   You did two things here. First, you created a new variable, `$DestinationFile`. This variable makes it easy to check if the path already exists. Secondly, you added logic that says "create the zip file only if the file doesn't already exist." This code implements that logic:

   ```powershell
   If (-Not (Test-Path $DestinationFile)) 
   {
     Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
     Write-Host "Created backup at $($DestinationPath + 'backup-' + $date + '.zip')"
   } Else {
     Write-Error "Today's backup already exists"
   }
   ```

1. Run the code to make sure the script doesn't stop responding and that your logic is applied:

   ```bash
   ./Backup.ps1 -Path './webapp' 
   ```

   You should see this output:

   ```output
   Write-Error: Today's backup already exists
   ```

Congratulations. You've made your script a little safer. (Note that it's still possible to provide problematic input to `$DestinationPath`, for example.) The point of this exercise is to show how to add checks. Depending on the environment in which the script will run, you might want fewer or more checks. You might even want written tests; it all depends on the context.
