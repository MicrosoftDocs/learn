Tab completion is a PowerShell feature that improves the speed and ease of finding and entering cmdlets and parameters. To use it, enter a few characters of a cmdlet or a parameter in the console, Windows PowerShell ISE, or Visual Studio Code with the PowerShell extension, and then press the Tab key. PowerShell will automatically provide the missing part of the name for you based on the match on the characters you entered. If there are multiple matches, just press the Tab key multiple times until you are presented with the one you intended to use. This works for cmdlets and parameters, variable names, object properties, and file paths.

> [!NOTE]
> The Windows PowerShell ISE is no longer in active feature development and is not supported in PowerShell 7. Microsoft recommends **Visual Studio Code with the PowerShell extension** as the modern scripting environment for both Windows PowerShell and PowerShell 7. Tab completion works the same way in all three environments.

## Improving speed and accuracy

Tab completion enables you to enter commands much faster and makes your code less prone to errors. Some cmdlet names can be lengthy and complicated. For example, you might accidentally miss or reverse letters when entering the name such as **Get-DnsServerResponseRateLimitingExceptionList**. 

## Discovering cmdlet and parameter names

Tab completion also helps you discover cmdlet and parameter names. For example, if you know that you want a **Get** cmdlet that works on an Active Directory resource, you can enter the text **Get-AD** in the console and press the Tab key to review the available options. For parameters, just enter a dash (-) and you can press the Tab key multiple times to review all parameters for a cmdlet.

Tab completion even works with wildcards. If you know you want a cmdlet that operates on services, but aren't sure which one you want, enter the text ***-service** in the console, and then press the Tab key to review all cmdlets that contain the text **-service** in their names.

