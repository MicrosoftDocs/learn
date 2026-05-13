In this module, you learned about adding more troubleshooting information to scripts, configuring breakpoints for troubleshooting, and describing error actions in Windows PowerShell. Key takeaways:

- Errors can occur for reasons such as:

    - You made a mistake while entering code.
    - You queried an object that doesn't exist.
    - You attempted to communicate with a computer that's offline.

- When errors occur, they're stored in the $Error array; each new error is inserted at $Error[0], shifting older errors to higher indexes.

- Use **Write-Host** to display additional information while a script runs.

- Use **Write-Warning** instead of **Write-Host** to make troubleshooting output more easily identifiable.

- A breakpoint pauses a script at a specific point and provides an interactive prompt for troubleshooting.

- At a Windows PowerShell prompt, set breakpoints by using the **Set-PSBreakPoint** cmdlet. 

- PowerShell errors are either terminating (the command stops) or non-terminating (processing continues).


## Additional reading

To learn more, go through the following documents:

- [About Preference Variables](/powershell/module/microsoft.powershell.core/about/about_preference_variables)

- [About Error Handling](/powershell/module/microsoft.powershell.core/about/about_error_handling)

- [Set-PSBreakpoint](/powershell/module/microsoft.powershell.utility/set-psbreakpoint)
