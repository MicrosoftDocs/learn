In this unit, you'll use Azure Cloud Shell on the right side of your screen as your Linux terminal. Azure Cloud Shell is a shell you can access through the Azure portal or at https://shell.azure.com. You don't need to install anything on your computer to use it.

One way to make your scripts flexible is to use parameters, so users can provide input when the script runs. In this exercise, you'll create a backup script and add parameters to it.

## Create a backup script

A common task is to create a *backup*. A backup is usually a compressed file that stores all the files belonging to, for example, an app. When you installed PowerShell, you got the cmdlet `Compress-Archive`, which can help you complete this task.

1. In your Cloud Shell terminal, run these bash commands:

   ```bash
   mkdir app
   cd app
   touch index.html app.js
   cd ..
   ```

   You should now have a directory named *app*. You're ready to work with PowerShell.

1. In the same terminal, start a PowerShell shell (if it's not already started) by running `pwsh`:

   ```bash
   pwsh
   ```

1. Create a script file named _Backup.ps1_ in the current directory and open it in your code editor.

   ```bash
   touch Backup.ps1
   code Backup.ps1
   ```

1. Add this content to the file and save the file. You can use **CTRL-S** on Windows and Linux or **CMD+S** on Mac to save.

     ```powershell
     $date = Get-Date -format "yyyy-MM-dd"
     Compress-Archive -Path './app' -CompressionLevel 'Fastest' -DestinationPath "./backup-$date"
     Write-Host "Created backup at $('./backup-' + $date + '.zip')"
     ```

     The script invokes `Compress-Archive` and uses three parameters:

     - `-Path` is the directory of the files that you want to compress.
     - `-CompressionLevel` specifies how much to compress the files.
     - `-DestinationPath` is the path to the resulting compressed file.

1. Run the script:

   ```powershell
   ./Backup.ps1 
   ```

   You should see this output:

   ```output
   Created backup at ./backup-<current date as YYYY-MM-DD>.zip
   ```

## Add parameters to your script

If you add parameters to your script, users can provide values when it runs. You'll add parameters to your backup script to enable configuration of the locations of the source files and the resulting zip file.

1. Add the following code to the top of the *Backup.ps1* file.

   > [!NOTE]
   >  Use the `code Backup.ps1` command to open the file if the editor isn't open.

   ```powershell
   Param(
     [string]$Path = './app',
     [string]$DestinationPath = './'
   )
   ```

   You've added two parameters to your script: `$Path` and `$DestinationPath`. You've also provided default values so users don't need to provide the values. Users can override the default values if they need to. You need to adjust the script to use these parameters. You'll do so next.

1. Change the code in the file to use the parameters, then save the file. *Backup.ps1* should now look like this:

   ```powershell
   Param(
     [string]$Path = './app',
     [string]$DestinationPath = './'
   )
   $date = Get-Date -format "yyyy-MM-dd"
   Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
   Write-Host "Created backup at $($DestinationPath + 'backup-' + $date + '.zip')"
   ```

1. Rename your *app* directory to *webapp* by running this command:

   ```bash
   mv app webapp
   ```

   Renaming the *app* directory simulates the fact that not all directories you'll need to back up will be called *app*.

   You can no longer rely on the default value for `$Path`. You'll need to provide a value via the console when you run the script.

1. Remove your backup file, replacing `<current date as YYYY-MM-DD>` with the current date:

   ```bash
   rm backup-<current date as YYYY-MM-DD>.zip
   ```

   You're removing this file to make sure you get a message stating that your `$Path` value doesn't exist. Otherwise, you'd get a message about the zip file already existing, and the problem we're trying to fix would be hidden.

1. Run your script without providing parameters. (The script will use default values for the parameters.)

   ```bash
   ./Backup.ps1
   ```

   You'll see an error message similar to this one:

   ```output
   Line |
      8 |  Compress-Archive -Path $Path -CompressionLevel 'Fastest' -Destination …
        |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        | The path './app' either does not exist or is not a valid file system path.
   Created backup at ./backup-<current date as YYYY-MM-DD>.zip
   ```

   The script notifies you that it can't find the directory _./app_. Now it's time to provide a value to the `$Path` parameter and see the benefit of adding parameters to your script.

1. Test your script by running it:

   ```powershell
   ./Backup.ps1 -Path './webapp'
   ```

   You'll see a message similar to the one you got earlier:

   ```output
   Created backup at ./backup-<current date as YYYY-MM-DD>.zip
   ```

   You can now use parameters if the directory you want to back up isn't called _./app_ or if you want to put the compressed file somewhere other than the current directory.

Congratulations. You created a backup script that you can use whenever you want to create a backup for an app directory or any other important directory. You then identified parts of your script that might need to change often and replaced static values with parameter values. That way, you most likely won't need to change the script itself when your requirements change (for example, if the name of the app changes or you need to change the destination path).
