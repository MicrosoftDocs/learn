A PowerShell drive, or *drive*, is a connection to a data store. Each PowerShell drive uses a single PowerShell provider to connect to a data store. The PowerShell drive has all the capabilities of the PowerShell provider that it uses to make the connection.

Names identify drives in Windows PowerShell. Drives can consist of a single letter. Single-letter drive names typically connect to a **FileSystem** drive. For example, drive **C** connects to the physical drive **C** of a computer. However, names also can consist of more than one character. For example, the drive **HKCU** connects to the **HKEY_CURRENT_USER** registry hive.

To create a new connection, you use the **New-PSDrive** cmdlet. You must specify a unique drive name, the root location for the new drive, and the PowerShell provider that will make the connection. Depending on the PowerShell provider's capabilities, you might also specify alternative credentials and other options.

Windows PowerShell always starts a new session with the following drives:

- Registry drives **HKLM** and **HKCU**
- Local hard drives, such as drive **C**
- Windows PowerShell storage drives **Variable**, **Function**, and **Alias**
- Web Services for Management (WS-Management) settings drive **WSMan**
- Environment variables drive **Env**
- Certificate store drive **CERT**

You can review a list of drives by running the **Get-PSDrive** cmdlet.

> [!NOTE]
> Drive names don't include a colon. Drive name examples include **Variable** and **Alias**. However, when you want to refer to a drive as a path, include a colon. For example, **Variable:** refers to the path to the **Variable** drive, just as **C:** refers to the path to drive **C**. Cmdlets such as **New-PSDrive** require a drive name, but when using these commands, don't include a colon in the drive name.
