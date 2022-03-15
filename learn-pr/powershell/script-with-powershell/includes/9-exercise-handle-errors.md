In this unit, you'll use Azure Cloud Shell on the right side of your screen as your Linux terminal. Azure Cloud Shell is a shell you can access through the Azure portal or at https://shell.azure.com. You don't have to install anything on your computer to use it.

In this exercise, you'll use a `Try/Catch` block to ensure the script stops responding early if a certain condition isn't met. You'll again work with your backup script.

Say you've noticed that you sometimes specify an erroneous path, which causes backup of files that shouldn't be backed up. You decide to add some error management.

> [!NOTE]
> Run the following commands *only* if you haven't completed any of the previous exercises in this module. We're assuming you've completed the previous exercises. If you haven't done so, you need a few files.

1. If you haven't completed the previous exercises in this module, run the following bash commands in a terminal:

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

    Now that you have an editor running, add the required code. Paste this code into the editor and save the file:

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
    
    $DestinationFile = "$($DestinationPath + 'backup-' + $date + '.zip')"
    If (-Not (Test-Path $DestinationFile)) 
    {
      Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
      Write-Host "Created backup at $($DestinationPath + 'backup-' + $date + '.zip')"
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

1. Open _Backup.ps1_. In the `Param` section, add a comma after the last parameter, and then add the following parameter:

   ```powershell
   [switch]$PathIsWebApp
   ```

   You've added a _switch parameter_. If this parameter is present when the script is invoked, you perform the check on the content. After that, you can determine if a backup file should be created.

1. Under the `Param` section, add this code, then save the file:

   ```powershell
   If ($PathIsWebApp -eq $True) {
      Try 
      {
        $ContainsApplicationFiles = "$((Get-ChildItem $Path).Extension | Sort-Object -Unique)" -match  '\.js|\.html|\.css'
        
        If ( -Not $ContainsApplicationFiles) {
          Throw "Not a web app"
        } Else {
          Write-Host "Source files look good, continuing"
        }
      } Catch {
       Throw "No backup created due to: $($_.Exception.Message)"
      }
   }
   ```

   The preceding code first checks if the parameter `$PathIsWebApp` is provided at runtime. If it is, the code continues to get a list of file extensions from the directory specified by `$Path`. In our case, if you run that part of the code on the _webapp_ directory, the following code will print a list of items:

   ```powershell
   (Get-ChildItem $Path).Extension | Sort-Object -Unique
   ```

   Here's the output:

   ```output
   .html
   .js
   ```

   In the full statement, we're using the `-match` operator. The `-match` operator expects a regular expression pattern. In this case, the expression states "do any of the file extensions match `.html`, `.js`, or `.css`?" The result of the statement is saved to the variable `$ContainsApplicationFiles`.

   Then the `If` block checks whether the `$ContainsApplicationFiles` variable is `True` or `False`. At this point, the code can take two paths:

   - **If the source directory is for a web app**, the script writes out "Source files look good, continuing."
   - **If the source directory isn't for a web app**, the script throws an error that states "Not a web app." The error is caught in a `Catch` block. The script stops, and you rethrow the error with an improved error message.

1. Test the script by providing the switch `$PathIsWebApp`:

   > [!NOTE]
   > Before you run the script, make sure there are no .zip files present. They might have been created when you completed previous exercises in this module. Use `Remove-Item *zip` to remove them.

   ```powershell
   ./Backup.ps1 -PathIsWebApp -Path './webapp'
   ```

   The script should print output that looks similar to this text:

   ```output
   Source files looks good, continuing
   Created backup at ./backup-2021-12-30.zip
   ```

1. Using your terminal, create a directory named _python-app_. In the new directory, create a file called _script.py_:

   ```bash
   mkdir python-app
   cd python-app
   touch script.py
   cd ..
   ```

   Your directory should now look like this:

   ```output
   -| webapp/
   ---| app.js
   ---| index.html
   -| python-app/
   ---| script.py
   -| Backup.ps1
   ```

1. In the PowerShell shell, run the script again, but this time change the `-Path` value to point to `./python-app`:

   ```powershell
   ./Backup.ps1 -PathIsWebApp -Path './python-app'
   ```  

   Your script should now print this text:

   ```output
   No backup created due to: Not a web app
   ```

   The output indicates that the check failed. It should have, because there are no files in the directory that have an .html, .js, or .css extension. Your code raised an exception that was caught by your `Catch` block, and the script stopped early.

   Congratulations! You've implemented a business requirement.
