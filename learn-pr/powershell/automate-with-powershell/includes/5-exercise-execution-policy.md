Managing the execution policy is about managing risk. A restrictive policy means you ensure that you don't run untrused scripts and risk introducing malware or similar to your system. Here you will run a command to check the execution policy. 

> [!NOTE]
> Setting the execution policy is currently only supported on Windows.  

## Check execution policy

Checking the execution policy is about knowing whether you are allowed to run PowerShell scripts or not. Instead of running interactive commands in the terminal you are running files ending with _.ps1_. Generally a script should not be trusted unless it comes from a trusted publisher, so its good idea to be restrictive with the execution policy.

Run the command `Get-ExecutionPolicy -List`:

```powershell
Get-ExecutionPolicy -List
```

Your output prints the policies at all scope levels and looks something like this:

|Scope         |ExecutionPolicy      |
|--------------|---------------------|
|MachinePolicy | Unrestricted        |
|UserPolicy    | Undefined           |
|Process       | Undefined           |
|CurrentUser   | AllSigned           |
|LocalMachine  | RemoteSigned        |

> [!NOTE]
> If your platform supports it, it's a good idea to ensure your execution policy is set to `RemoteSigned` with the command `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`.
