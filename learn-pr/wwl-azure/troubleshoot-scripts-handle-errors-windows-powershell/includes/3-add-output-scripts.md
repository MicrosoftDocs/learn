When a script isn't operating as you expected, it can be useful to have the script display additional information. You can use that information to understand what the script is doing and why it's not operating as expected.

The **Write-Host** cmdlet is the most common way to display additional information while a script is running. You can use **Write-Host** to display text information that indicates specific points in a script and variable values. Variable values can be useful in most cases when a script isn't behaving as you expect it to behave, because a variable doesn't have a value that you expect.

If you want to make your troubleshooting text more easily identifiable, you can use the **Write-Warning** cmdlet instead of **Write-Host**. **Write-Warning** displays the text you specify in an alternate color.

If you want to slow down the running of a script to enable you to review the output better, you can add a **Start-Sleep** cmdlet and specify a few seconds to pause. Alternatively, if you want the script to pause until you're ready for it to continue, you can use **Read-Host**.

While you're in the process of troubleshooting, you can comment out the additional information. Then, if required, you can uncomment it to review the additional information again.

## Advanced script output

If you've configured your script as an advanced script by using **CmdletBinding()** in the **Param()** block, you can also use the cmdlets in the following table as part of your script for troubleshooting.

*Table 1: Cmdlets for troubleshooting*

| Cmdlet          | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| **Write-Verbose** | Text specified by **Write-Verbose** is displayed only when you use the `-Verbose` parameter when running the script. The value of `$VerbosePreference` specifies the action to take after the **Write-Verbose** command. The default action is **SilentlyContinue**. |
| **Write-Debug**   | Text specified by **Write-Debug** is displayed only when you use the `-Debug` parameter when running the script.  The value of `$DebugPreference` specifies the action to take after the **Write-Debug** command. The default action is **SilentlyContinue**, which displays no information to screen. You need to change this action to **Continue** so that debug messages are displayed. |

