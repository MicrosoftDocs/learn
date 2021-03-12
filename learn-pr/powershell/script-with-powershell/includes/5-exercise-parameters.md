In this unit, you use Azure Cloud Shell on the right as your Linux terminal. Azure Cloud Shell is a shell that you can access through the Azure portal or at https://shell.azure.com. You don't have to install anything on your PC or laptop to use it.

A way to make the scripts flexible is to ensure they rely on parameters so that input can be provided when you execute the script. You will take a backup script and add parameters to it.

## Create a backup script

A common task is to create a _backup_. A backup is usually a compressed file storing all the files belonging to, for example,  an app. When you installed PowerShell, you got the cmdlet `Compress-Archive` that can help you solve this task.

1. In a terminal, run the following commands:

   ```bash
   mkdir app
   cd app
   touch index.html app.js
   cd ..
   ```

   You should now have an _app_ directory and you're ready to work with PowerShell next.

1. In the same terminal, start a PowerShell shell (if it's not already started) by running `pwsh`:

   ```bash
   pwsh
   ```

1. Create a script file _Backup.ps1_:

   ```bash
   touch Backup.ps1
   ```

   and give it the following content:

   ```powershell
   $date = Get-Date -format "yyyy-MM-dd"
   Compress-Archive -Path './app' -CompressionLevel 'Fastest' -DestinationPath "./backup-$date"
   Write-Host "Created backup at $('./backup' + $date).zip"
   ```

   The script invokes the `Compress-Archive` and use three parameters:

   - `-Path`, is the source directory, where the files live that you want to compress.
   - `-CompressionLevel`, is how much it should compress the files.
   - `-DestinationPath`, represents where the compressed file will end up.

1. Run the script by typing the following:

   ```powershell
   ./Backup.ps1 
   ```

   Ensure the script outputs the following text:

   ```output
   Created backup at ./backup<today's date as YYMMDD>.zip
   ```

## Add parameters to your script

Your script might benefit from using parameters. That way you can provide values when you execute the script. You will add parameters to your backup script to ensure you can configure things like where the source files are located or where to store the resulting zip file.

1. Ensure you have the _Backup.ps1_ file open and add the following code to the top of the file:

   > [!NOTE]
   > Open with the command `code Backup.ps1`, if the editor is not showing.
   ```powershell
   Param(
     [string]$Path = './app',
     [string]$DestinationPath = './'
   )
   ```

   What you've done is to add two parameters `$Path` and `$DestinationPath` to your script. You've also provided default values so the user doesn't need to provide these values but is able to override them, if needed.  You also need to adjust the script to use these parameters, so that's you will do next.

1. Change the content of the file to use the parameters. Ensure _Backup.ps1_ looks like so:

   ```powershell
   Param(
     [string]$Path = './app',
     [string]$DestinationPath = './'
   )
   $date = Get-Date -format "yyyy-MM-dd"
   Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
   Write-Host "Created backup at $( $DestinationPath + 'backup-' + $date).zip"
   ```

1. Lets rename your _app_ directory to **webapp** by running the command:

   ```bash
   mv app webapp
   ```

   Renaming the app directory simulates the fact that not all directories you will need to back up will be called **app**.

   You can no longer rely on the default values for `$Path` and will need to provide a value via the console when you run the script.

1. Remove your backup file:

   ```bash
   rm backup-<todays date as YYYYMMDD>.zip
   ```

   You do this to ensure it shows you the problem with your `$Path` value not existing, otherwise it would complain about the zip file already existing and hide the problem we're looking to fix.

1. Run your script using no parameters (script will use default values for your parameters).

   ```bash
   ./Backup.ps1
   ```

   You will now see an error message similar to the following:

   ```output
      8 |  Compress-Archive -Path $Path -CompressionLevel 'Fastest' -Destination …                                                     |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                                                       | The path './app' either does not exist or is not a valid file system path.
   Created backup at ./backup-<YYYY-MM-DD>.zip
   ```

   The script complains about not being able to find the directory _./app_. Now it's time to provide a value to the `$Path` parameter and see the value of having added parameters to your script.

1. Test your script by running the script like so:

   ```powershell
   ./Backup.ps1 -Path './webapp'
   ```

   You will see an output similar to the one you got before:

   ```output
   Created backup at ./backup<today's date as YYMMDD>.zip
   ```

   Great, thanks to the change you've made, you can now use parameters if the directory you are looking to back up isn't called _./app_ or you want to place the compressed somewhere else than the directory you are standing in.

Congrats, you've managed to create a backup script you can use whenever you want to create backup for an app or other important directory. You then identified parts of the script that might need to change often and replaced static values with parameter values. That way, you most likely won't need to change the script itself when your requirements change (i.e the name of the app changes or you need to call the destination file something else).