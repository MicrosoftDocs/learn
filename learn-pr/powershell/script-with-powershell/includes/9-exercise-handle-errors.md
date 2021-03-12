In this unit, you use Azure Cloud Shell on the right as your Linux terminal. Azure Cloud Shell is a shell that you can access through the Azure portal or at https://shell.azure.com. You don't have to install anything on your PC or laptop to use it.

The idea with this exercise is to add `Try/Catch` and ensure the script crashes early if a certain condition is not met. You will again work with your backup script. You've noticed that you sometimes specify an erroneous path, by mistake, resulting files being backed up that shouldn't have been. Therefore you decide to add some error management.

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

1. Lastly you need a file _Backup.ps1_, run the following commands:

    ```bash
    touch Backup.ps1
    code Backup.ps1
    ```

    Now you've got an editor up and running, lets add the needed code. In the editor, paste the following code:

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

## Implement a business requirement using `Try/Catch`

Your company mostly build web apps, apps consisting of html, css, and JavaScript files. You therefore decide to _optimize_ the script to recognize web apps.

1. Use an existing PowerShell shell, if you have, otherwise, start one by typing `pwsh` in a terminal:

   ```bash
   pwsh
   ```

1. Open _Backup.ps1_, in the params section, add the following parameter:

   ```powershell
   [switch]$PathIsWebApp
   ```

   You've added a so called _switch parameter_. The idea is that if this parameter is present, when the script is invoked, you then perform the check on the content. Thereafter you can determine if a backup file should be produced.

1. Under the `Param` section, add the following code:

   ```powershell
    If($PathIsWebApp -eq $True) {
      Try 
      {
        $ContainsApplicationFiles = "$((Get-ChildItem $Path).Extension | Sort-Object -Unique)" -match  '\.js|\.html|\.css'
        
        If ( -Not $ContainsApplicationFiles) {
          Throw "Not a webapp"
        } Else {
          Write-Host "Source files looks good, continuing"
        }
      } Catch {
       Throw "No backup created due to: $($_.Exception.Message)"
      }
     }
   ```

   The code above first check if the parameter `$PathIsWebApp` was provided at execution time. If so, the code continues to get a list of file extensions from the directory pointed to by `$Path`. In your case, if you run that part of the code again the _webapp_ directory the code:

   ```powershell
   (Get-ChildItem $Path).Extension | Sort-Object -Unique
   ```

   will produce a list consisting of two items:

   ```output
   .js
   .html
   ```

   In the full statement, the `-match` operator is added. The `-match` operator expects a Regular Expression pattern. In your case that expression stated, does any of the file extensions _match_ either `.html`, `.js` or `.css`. The result of the statement is saved to the variable `$ContainsApplicationFiles`.

   Then the `If` block checks whether the `$ContainsApplicationFiles` variable is `True` or `False`. At this point, the code can take two paths:

   - **The source directory is a webapp**. If that was the case, the script writes out **Source files looks good, continuing**.
   - **The source directory is not a webapp**. If that isn't the case, then the script _throws_ an error stating **"Not a webapp"**. The error ends up being caught in a `Catch` block and the script shuts down, as you rethrow the error with an improved error text.

1. Try out the script by providing the switch `$PathIsWebApp`, like so:

   > [!NOTE]
   > Before you run the script, ensure there are no _.zip_ files present created when running previous exercises in this module. By running `Remove-Item *zip`
   ```powershell
   ./Backup.ps1 -PathIsWebApp -Path './webapp'
   ```

   The script should output text similar to:

   ```output
   Source files looks good, continuing
   Created backup at ./backup-2021-01-21.zip
   ```

1. Create a directory _python-app_ and create a file within called _script.py_:

   ```bash
   mkdir python-app
   cd python-app
   touch script.py
   cd ..
   ```

Your directory should now look like so:

   ```output
   -| webapp/
   ---| app.js
   ---| index.html
   -| python-app/
   ---| script.py
   -| Backup.ps1
   ```

1. Run the script again, but this time change the `-Path` value to point to **./python-app**:

   ```powershell
   ./Backup.ps1 -PathIsWebApp -Path './python-app'
   ```  

   Your script should now say:

   ```output
   No backup created due to: Not a webapp
   ```

   The text means that the check failed, and it should, there was no files in there matching `.html`, `.js`, or `.css`. Your code raised an exception that was caught by your `Catch` block and the script excited early.

   Congrats! You've managed to implement a business-specific requirement.