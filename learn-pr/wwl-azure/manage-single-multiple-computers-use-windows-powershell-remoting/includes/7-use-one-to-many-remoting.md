*One-to-many remoting* lets you send a single command to multiple computers in parallel. Each computer will run the command that you transmit, serialize the results into XML, and transmit those results back to your computer. Your computer then deserializes the XML into objects and puts them into the Windows PowerShell pipeline. When doing this, several properties are added to each object, including a **PSComputerName** property that indicates which computer each result came from. That property lets you sort, group, and filter based on computer name.

You can use one-to-many remoting using two different techniques:

- **Invoke-Command –ComputerName name1,name2 –ScriptBlock { command }**. This technique sends the command (or commands) contained in the script block to the computers that you list. This technique is useful for sending one or two commands; multiple commands are separated by a semicolon.
- **Invoke-Command –ComputerName name1,name2 –FilePath filepath**. This technique sends the contents of a script file with a .ps1 file name extension to the computers that you list. The local computer opens the file and reads its contents. However, the remote computers don't have to have direct access to the file. This technique is useful for sending a large file of commands, such as a complete script.

> [!NOTE]
> Within any script block (including the script block provided to the *–ScriptBlock* parameter) you can use a semicolon to separate multiple commands. For example, `{ Get-Service ; Get-Process }` will run **Get-Service**, and then run **Get-Process**.

## Throttling

To help you manage the resources on your local computer, PowerShell includes a per-command throttling feature that lets you limit the number of concurrent remote connections established for each command. By default, Windows PowerShell will connect to only 32 computers at once. If you list more than 32 computers, the connections to the other computers will be queued. Once sessions to some of the computers from the first batch complete and return their results, connections to the computers in the next batch will be initiated.

You can alter this behavior by using the *–ThrottleLimit* parameter of **Invoke-Command**. Raising the number doesn't put an extra load on the remote computers. However, it does put an extra load on the computer where **Invoke-Command** was invoked. It also utilizes more bandwidth. Each concurrent connection is basically a thread of Windows PowerShell. Therefore, raising the number of computers consumes memory and processor speed on the local computer.

## Passing values

The script block or file contents are transmitted as literal text to the remote computers that run them exactly as is. The computer doesn't parse the script block or file on which the **Invoke-Command** was run. Consider the following command example:

```powershell
$var = 'BITS'
Invoke-Command –ScriptBlock { Get-Service –Name $var } –Computer LON-DC1
```

In this scenario, the variable `$var` is being set on the local computer rather than being included into the script block to be run on **LON-DC1**. In other words, `$var` is not defined or set in the PowerShell remoting session to **LON-DC1**, which is a common mistake that administrators new to Windows PowerShell often make.

## Running commands locally and remotely

Pay close attention to the commands that you enclose in the script block, which will be passed to the remote computer. Remember that your local computer won't process any script block contents, but simply pass it to the remote computer. For example, consider the following command:

```powershell
Invoke-Command –ScriptBlock { Do-Something –Credential (Get-Credential) } -ComputerName LON-DC1
```

This command will run the **Get-Credential** cmdlet on the remote computer. If you try running **Get-Credential** on a local computer, it will use a graphical dialog box to prompt for the credential.

> **Question:** Will that command work when run on a remote computer? For example, if you ran the preceding command on 100 remote computers, would you be prompted for 100 credentials?

Now consider this modified version of the command:

```powershell
Invoke-Command –ScriptBlock { Param($c) Do-Something –Credential $c }
               -ComputerName LON-DC1
               -ArgumentList (Get-Credential)
```

This command runs **Get-Credential** on the local computer and runs it only once. The resulting object is passed into the `$c` parameter of the script block, enabling each computer to use the same credential.

These examples illustrate the importance of writing remoting commands carefully. By using a combination of running commands remotely and locally, you can achieve various useful goals.

## Persistence

Using the techniques outlined here, every time you use **Invoke-Command**, the remote computer creates a new *wsmprovhost* process, and runs the command or commands. It then returns the results, and then closes that Windows PowerShell instance. Each successive **Invoke-Command**, even if made to the same computer, is akin to opening a new Windows PowerShell window. Any work done by a previous session won't exist unless you save it to a disk or some other persistent storage. For example, consider the following command:

```powershell
Invoke-Command –ComputerName LON-DC1 –ScriptBlock { $x = 'BITS' }
Invoke-Command –ComputerName LON-DC1 –ScriptBlock { Get-Service –Name $x }
```

In this example, the **Get-Service** would fail, because it's dependent on the value of a variable created as part of the previous wsmprovhost process. When the first script invoked by the **Invoke-Command** completes, its variables are cleared from memory. To address this issue, you can create a wsmprovhost process on a remote computer so that you can successfully send successive commands to it.

## Multiple computer names

The *–ComputerName* parameter of **Invoke-Command** can accept any collection of string objects as computer names. The following list describes different techniques that can be used to create such collections:

- **-ComputerName ONE,TWO,THREE**. A static, comma-separated list of computer names.
- **-ComputerName (Get-Content Names.txt)**. Reads names from a text file named **Names.txt**, assuming the file contains one computer name per line.
- **-ComputerName (Import-Csv Computers.csv | Select –ExpandProperty Computer)**. Reads a comma-separated value (CSV) file that's named **Computers.csv** and contains a column named **Computer** that contains computer names.
- **-ComputerName (Get-ADComputer –Filter * | Select –ExpandProperty Name)**. Queries every computer object in AD DS, which can take a significant amount of time in a large domain.

## Common mistakes when using computer names

Be careful where you specify a computer name. For example, review the following command:

```powershell
Invoke-Command –ScriptBlock { Get-Service –ComputerName ONE,TWO }
```

This command doesn't provide a *–ComputerName* parameter to **Invoke-Command**. Therefore, the command runs on the local computer. The local computer will run **Get-Service** targeting computers named **ONE** and **TWO**. The protocols used by **Get-Service** will be used instead of Windows PowerShell remoting. Compare this with the following command:

```powershell
Invoke-Command –ScriptBlock { Get-Service } –ComputerName ONE,TWO
```

This command will use Windows PowerShell remoting to connect to computers named **ONE** and **TWO**. Each of these computers will run **Get-Service** locally, returning their results using remoting.

For more interactive Windows PowerShell remoting situations, you can manage individual sessions as separate entities. To do this, you first create a session by using the **New-PSSession** command. The benefit of using the **New-PSSession** command is that the session will persist throughout multiple **Invoke-Command** instances, allowing you to pass variables and objects to other commands in your script. You can create persistent sessions by using the **New-PSSession** command and assigning it to a variable. You then can reference the variable later by using the **Invoke-Command** command. When finished, you can close persistent sessions by using the **Remove-PSSession** command.
