You can use the **Read-Host** cmdlet to obtain input from users while a script is running. The request for user input could be a prompt to start the script or based on results from processing that's already happened in the script. For example, after performing a query for Active Directory Domain Services (AD DS) user objects and displaying the number of objects retrieved, the script could prompt a decision on whether to continue or stop. Alternatively, the script could request the specific event ID for which to search. The syntax for the **Read-Host** cmdlet is:

```powershell
$answer = Read-Host "How many days"
```

The previous example stops processing the script and prompts the user with text as follows:

```powershell
How many days:
```

At the prompt, the user enters a response and then selects Enter. The response that the user provides is placed in the variable `$answer`.

When you display text as part of using **Read-Host**, a colon (`:`) is always appended to the end of the text. There's no parameter to suppress the behavior. However, if you use **Read-Host** without displaying text, no colon is displayed. You can combine a **Write-Host** command with **Read-Host** to display text and avoid a colon being appended, as the following example depicts:

```powershell
Write-Host "How many days? " -NoNewline
$answer = Read-Host
```

> [!NOTE]
> Input from **Read-Host** is limited to 1022 characters.

You can mask the input users enter at the prompt by using the *-MaskInput* or *-AsSecureString* parameters. Both parameters cause the characters entered by the user to display as asterisks (`*`). When *-MaskInput* is used, the response is collected as a String object. When *-AsSecureString* is used, the response is collected as a SecureString object. A SecureString object is required for scenarios such as setting passwords, where data shouldn't be stored as clear text in memory.

