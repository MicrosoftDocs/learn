In this module, you learned about adding more troubleshooting information to scripts, configuring breakpoints for troubleshooting, and describing error actions in Windows PowerShell. The following are the key takeaways:

- Errors can occur for reasons such as:

    - You made a mistake while entering code.
    - You queried an object that doesn't exist.
    - You attempted to communicate with a computer that's offline.

- When errors occur, they're stored in the $Error array. When a new error is generated, it's inserted at $Error[0], and the index of other errors is increased by one. 

- The **Write-Host** cmdlet is the most common way to display additional information while a script is running.

- If you want to make your troubleshooting text more easily identifiable, you can use the **Write-Warning** cmdlet instead of **Write-Host**.

- A breakpoint pauses a script and provides an interactive prompt. Use breakpoints to troubleshoot scripts when they aren't behaving as expected.

- At a Windows PowerShell prompt, set breakpoints by using the **Set-PSBreakPoint** cmdlet. 

- When a PowerShell command generates an error, that error might be one of two types, either a terminating error or a non-terminating error. 

- A terminating error occurs when Windows PowerShell determines that it's not possible to continue processing after the error and the command stops. 

- A non-terminating error occurs when Windows PowerShell determines that it's possible to continue processing after the error. 


## Additional reading

To learn more, go through the following documents:

- [About Assignment Operators](https://aka.ms/lewact)

- [Hosting your own NuGet Feeds](https://aka.ms/vm0ys1)
