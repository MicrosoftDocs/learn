In this unit, you use Azure Cloud Shell on the right as your Linux terminal. Azure Cloud Shell is a shell that you can access through the Azure portal or at https://shell.azure.com. You don't have to install anything on your PC or laptop to use it.

In order to start scripting, you're going to first learn how to set up a profile so you can customize your working environment the way you want it. Then you'll move on to write some basic scripts and get a feeling for interpolation and scope.

## Set up a profile

A profile is a script that runs where you start a new session. Having a customized environment can make you more productive.

1. Type `pwsh` in a terminal window to start a PowerShell session:

   ```bash
   pwsh
   ```

1. Run the command `$Profile | Select-Object *`:

   ```powershell
   $Profile | Select-Object *
   ```

   The command will output something similar to this text:

   ```output
   CurrentUserAllHosts                        CurrentUserCurrentHost
   -------------------                        ----------------------
   /home/<user>/.config/PowerShell/profile.ps1 /home/<user>/.config/PowerShell/Microsoft.…
   ```

1. Select to create a profile for `Current User, Current Host` by running the command `Add-Content`, like so:

   ```powershell
   Add-Content -Value 'Write-Host "Hello <replace with your name>, welcome back" -foregroundcolor Green ' -Path $Profile.CurrentUserCurrentHost
   ```

   The `Add-Content` command will create a file, if it doesn't already exist, and add content to it.

1. Run `pwsh` to create a new shell. You should now see (in green):

   ```output
   Hello <replace with your name>, welcome back
   ```

## Exercise 1 - Should demo  

Now that you've got a profile set up it's time to learn to create and run a script.

1. Ensure you have an existing PowerShell session running. In the console, type:

   ```powershell
   $PI = 3.14
   ```

1. Create a file _PI.ps1_:

   ```powershell
   touch PI.ps1
   code PI.ps1
   ```

   and give it the following content and save the file:

   ```powershell
   $PI = 3
   Write-Host "The value of `$PI is now $PI, inside the script"
   ```

1. Run the script by specifying the path to it:

   ```bash
   ./PI.ps1
   ```

   Your script outputs the following text:

   ```output
   The value of $PI is now 3
   ```

   Your script is doing two things, first creating a script local variable $PI, that shadows the `$PI` variable defined in the local scope. Secondly the second row in the script interpolates the `$PI` variable by using double quotes. It additionally escapes the interpolation using a double tick.

1. Type `$PI` in the console:

   ```output
   3.14
   ```

   The value is still **3.14**, the script did not change the value.