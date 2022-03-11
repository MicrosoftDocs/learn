In this unit, you'll use Azure Cloud Shell on the right side of your screen as your Linux terminal. Azure Cloud Shell is a shell you can access through the Azure portal or at https://shell.azure.com. You don't have to install anything on your computer to use it.

First, you'll learn how to set up a profile so you can customize your working environment the way you want it. You'll then write some basic scripts and get a feeling for interpolation and scope.

## Set up a profile

A profile is a script that runs when you start a new session. Having a customized environment can make you more productive.

1. Enter `pwsh` in a terminal window to start a PowerShell session:

   ```bash
   pwsh
   ```

1. Run this command:

   ```powershell
   $Profile | Select-Object *
   ```

   The output will display something similar to this text:

   ```output
   CurrentUserAllHosts                        CurrentUserCurrentHost
   -------------------                        ----------------------
   /home/<user>/.config/PowerShell/profile.ps1 /home/<user>/.config/PowerShell/Microsoft.…
   ```

1. Create a profile for the current user and the current host by running the command `New-Item`:

   ```powershell
   New-Item `
     -ItemType "file" `
     -Value 'Write-Host "Hello <replace with your name>, welcome back" -foregroundcolor Green ' `
     -Path $Profile.CurrentUserCurrentHost -Force
   ```

   The `-Force` switch will overwrite existing content, so be careful if you run this locally and have an existing profile.

1. Run `pwsh` to create a new shell. You should now see the following (in green):

   ```output
   Hello <your name>, welcome back
   ```

## Create and run a script

Now that you have a profile set up, it's time to create and run a script.

1. Ensure you have an existing PowerShell session running. In the console window, enter this code:

   ```powershell
   $PI = 3.14
   ```

1. Create a file named *PI.ps1* in the current directory and open it in your code editor:

   ```powershell
   New-Item -Path . -Name "PI.ps1" -ItemType "file"
   code PI.ps1
   ```

1. Add the following content to the file and save it. You can use **CTRL+S** on Windows and Linux or **CMD+S** on Mac to save your file.

   ```powershell
   $PI = 3
   Write-Host "The value of `$PI is now $PI, inside the script"
   ```

1. Run the script by specifying the path to it:

   ```bash
   ./PI.ps1
   ```

   Your output displays the following text:

   ```output
   The value of $PI is now 3, inside the script
   ```

   Your script does two things. First, it creates a script-local variable `$PI` that shadows the `$PI` variable defined in the local scope. Next, the second row in the script interpolates the `$PI` variable because you used double quotation marks. It escapes interpolation the first time because you used a back tick.

1. Enter `$PI` in the console window:

   ```output
   3.14
   ```

   The value is still 3.14. The script didn't change the value.
