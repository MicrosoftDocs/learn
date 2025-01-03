Before you can begin modifying Windows PowerShell scripts or creating your own, you must know how to run a Windows PowerShell script. You might be familiar with the idea of double-clicking an executable file or selecting it and then selecting Enter to run it, but that process doesn't work for Windows PowerShell scripts.

One of the problems with many scripting languages is that running the scripts by accident is too easy. Users can accidentally run a script by double-clicking it or selecting it and then selecting Enter. This action is especially problematic when the file extension is hidden, and malware is included as an email attachment. For example, an attached file named **receipt.txt.vbs** would display as **receipt.txt** and users would run it accidentally, thinking it's a simple text file. This setting isn't a concern for Windows PowerShell scripts because of the actions required to run a script.

## Integration with File Explorer

To make Windows PowerShell scripts more secure, the .ps1 file extension is associated with Notepad. Therefore, when you double-click a .ps1 file or select it and then select Enter, it opens in Notepad. This setting means that users can’t be tricked into running a Windows PowerShell script by double-clicking it or selecting it and then selecting Enter.

When you right-click a Windows PowerShell script or activate its context menu, you have three options:

- **Open**. This option opens the script in Notepad.
- **Run with PowerShell**. This option runs the script, but the Windows PowerShell prompt doesn't remain open when the script completes.
- **Edit**. This option opens the script in the Windows PowerShell ISE.

In most cases, you want the Windows PowerShell prompt to remain open when you run a script. To do this task, run the script from a Windows PowerShell prompt that's already open.

## Running scripts at the PowerShell prompt

When you run an executable file at a command prompt, you can enter its name to run it in the current directory. For example, when the current directory is **C:\\app**, you can enter **app.exe** to run **C:\\app\\app.exe**. You can't use this process to run Windows PowerShell scripts, because it doesn't search the current directory.

To run a Windows PowerShell script at the Windows PowerShell prompt, you can use the following methods:

- Enter the full path to the script; for example, **C:\\Scripts\\MyScript.ps1**.
- Enter a relative path to the script; for example, **\\Scripts\\MyScript.ps1**.
- Reference the current directory; for example, **.\\MyScript.ps1**.

## The script execution policy

You can control whether Windows PowerShell scripts can be run on Windows computers. You do this task by setting the execution policy on the computer. The default execution policy on a computer varies depending on the operating system version. To be sure of the current configuration, you can use the **Get-ExecutionPolicy** cmdlet.

The options for the execution policy are:

- **Restricted**. No scripts are allowed to be run.
- **AllSigned**. Scripts can be run only if they're digitally signed.
- **RemoteSigned**. Scripts that are downloaded can only be run if they're digitally signed.
- **Unrestricted**. All scripts can be run, but a confirmation prompt displays when running unsigned scripts that are downloaded.
- **Bypass**. All scripts are run without prompts.

> [!NOTE]
> Setting the script execution policy provides a safety net that can prevent untrusted scripts from being run accidentally. However, the execution policy can always be overridden.

You can set the execution policy on a computer by using the **Set-ExecutionPolicy** cmdlet. However, this setting is difficult to manage across many computers. When you configure the execution policy for many computers, you can use the **Computer Configuration\\Policies\\Administrative Templates\\Windows Components\\Windows PowerShell\\Turn on Script Execution** Group Policy setting to override the local setting.

You can override the execution policy for an individual Windows PowerShell instance. This setting is useful if company policy requires the execution policy to be set as **Restricted**, but you still must run scripts occasionally. To override the execution policy, run **PowerShell.exe** with the *-ExecutionPolicy* parameter.

```powershell
Powershell.exe -ExecutionPolicy ByPass
```

If you've modified a script downloaded from the internet, the script still has the attributes that identify it as a downloaded file. To remove that status from a script, use the **Unblock-File** cmdlet.

