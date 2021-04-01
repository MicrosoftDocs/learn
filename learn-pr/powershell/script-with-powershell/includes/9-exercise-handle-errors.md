In this unit, you'll use Azure Cloud Shell on the right side of your screen as your Linux terminal. Azure Cloud Shell is a shell that you can access through the Azure portal or at https://shell.azure.com. You don't have to install anything on your computer to use it.

In this exercise, you'll use a `Try/Catch` to ensure the script stops responding early if a certain condition isn't met. You'll again work with your backup script. 

Say you've noticed that you sometimes specify an erroneous path, which causes backup of files that shouldn't be backed up. You decide to add some error management.

> [!NOTE]
> Run the following commands only if you haven't completed any of the previous exercises in this module. We're assuming you've completed the previous exercises. If you haven't done so, you need a few files.

1. If you haven't completed the previous exercises in this module, run the following commands:

    ```bash
    mkdir webapp
    cd webapp
    touch index.html app.js
    cd ..
    ```

   These commands will create a directory that contains files typically associated with web development.

1. You also need a file named _Backup.ps1_. Run these commands:

    ```bash
    touch Backup.ps1
    code Backup.ps1
    ```

    Now that you have an editor running, add the required code. Paste this code into the editor:

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
    If (-Not (Test-Path $DestinationFile)) 
    {
       Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
       Write-Host "Created backup at $( $DestinationPath + 'backup-' + $date).zip"
    } Else {
       Write-Error "Today's backup already exists"
    }
    ```

## Implement a business requirement by using `Try/Catch`

Assume your company mostly builds web apps. These apps consist of HTML, CSS, and JavaScript files. You decide to optimize the script to recognize web apps.

1. Use an existing PowerShell shell, if you have one running. Otherwise, start one by typing `pwsh` in a terminal:

   ```bash
   pwsh
   ```

1. Open _Backup.ps1_. In the `Param` section, add the following parameter:

   ```powershell
   [switch]$PathIsWebApp
   ```

   You've added a _switch parameter_. If this parameter is present when the script is invoked, you perform the check on the content. After that, you can determine if a backup file should be created.

1. Under the `Param` section, add this code:

   ```powershell
    If ($PathIsWebApp -eq $True) {
      Try 
      {
        $ContainsApplicationFiles = "$((Get-ChildItem $Path).Extension | Sort-Object -Unique)" -match  '\.js|\.html|\.css'
        
        If ( -Not $ContainsApplicationFiles) {
          Throw "Not a webapp"
        } Else {
          Write-Host "Source files look good, continuing"
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
