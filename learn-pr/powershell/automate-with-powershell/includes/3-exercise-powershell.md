Here you will run a command to verify your PowerShell installation. It's a good starting point to know that everything is installed correctly. Additionally you will also check the execution policy.

## Verify installation

To make sure you are correctly set up to work in PowerShell, running a command to verify your installation is a good idea.  

1. Run the command `$PSVersionTable`:

   ```powershell
   $PSVersionTable
   ```

    Your output resembles the below text:

   ```output
    Name                           Value
    ----                           -----
    PSVersion                      7.0.3
    PSEdition                      Core
    GitCommitId                    7.0.3
    OS                             Darwin 17.7.0 Darwin Kernel Version 17.7.0: Fri Jul  6 19:54:51 PDT 2018; root:xnu-4570.71.3…
    Platform                       Unix
    PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
    PSRemotingProtocolVersion      2.3
    SerializationVersion           1.1.0.1
    WSManStackVersion              3.0
   ```

   The output above is formatted as a table and gives you various information on not only what version of PowerShell you are running but what platform you are on, what edition and more. If you want to know what version of PowerShell you are running, you can narrow it down by running a modified version of `$PSVersionTable`.

1. Run `$PSVersionTable.PSVersion`:

   ```powershell
   $PSVersionTable.PSVersion
   ```

    Your output now resembles this text:

    ```output
    Major  Minor  Patch  PreReleaseLabel BuildLabel
    -----  -----  -----  --------------- ----------
    7      0      3  
    ```

    The information above is narrowed down to give you more information on the version of PowerShell you are running. The learning here is that running the command `$PSVersionTable` results in an output looking like a table but is an actuality an object. You can therefore you can use a dot, `.` to access a specific property like `PSVersion`.

## Check execution policy

Checking the execution policy is about knowing whether you are allowed to run PowerShell scripts or not. Instead of running interactive commands in the terminal you are running files ending with _.ps1_. Generally a script should not be trusted unless it comes from a trusted publisher, so its good idea to restrictive with the execution policy.

Run the command `Get-ExecutionPolicy`:

```powershell
Get-ExecutionPolicy
```

Your output prints either `Restricted`, `Unrestricted` or `RemoteSigned`, depending on how the execution pollicy is currently configured on your machine.

> [!NOTE]
> If your platform supports it, it's a good idea to ensure your execution policy is set to `RemoteSigned` with the command `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`.
