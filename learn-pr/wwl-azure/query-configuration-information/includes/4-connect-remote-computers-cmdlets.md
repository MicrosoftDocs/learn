You can use Windows Management Instrumentation (WMI) and Common Information Model (CIM) cmdlets to query and manage remote computers. When you connect to a remote computer, you can specify alternative credentials for the connection, but alternative credentials are optional. WMI and CIM cmdlets have different capabilities and different syntaxes for remote connections.

## Remote connections using WMI cmdlets

For the WMI commands, use the *-ComputerName* parameter to specify a remote computer’s name or IP address. You can specify multiple computer names to run the command on multiple computers in a single statement. You can provide the computer names as a comma-separated list, an array containing multiple computer names, or a parenthetical command that produces a collection of computer names as string objects.

Use the *-Credential* parameter to specify an alternative username. If you specify only a username, then you're prompted for the password. If you use the **Get-Credential** cmdlet to store the username and password in a variable, then you can reference that variable to eliminate the password prompt. In the following example, you'll be prompted for the password:

```powershell
Get-WmiObject -ComputerName LON-DC1 -Credential ADATUM\Administrator -Class Win32_BIOS
```

When you specify multiple computer names, Windows PowerShell contacts them one at a time in the order that you specify. If connectivity to one computer fails, the command produces an error message and continues to try the remaining computers.

## Remote connections using CIM cmdlets

The CIM cmdlets also provide support for ad hoc connections to remote computers by using the *-ComputerName* parameter. However, the CIM cmdlets don't have a *-Credential* parameter to specify alternate credentials. If you want to use alternate credentials, you need to create a CIM session.

You can run the following CIM command to retrieve the same information as the **Get-WmiObject** command in the previous code example:

```powershell
Get-CimInstance -ComputerName LON-DC1 -Classname Win32_BIOS
```

Remember that CIM commands use the WS-MAN protocol for ad hoc connections. This protocol has specific authentication requirements. When establishing a connection between computers in the same domain or in trusting domains, you typically have to provide a computer’s name as it displays in Active Directory Domain Services (AD DS). You can't provide an alias name or an IP address because that will result in a failure of Kerberos authentication. You'll learn more about these and other restrictions in Module 8, “Administering remote computers with Windows PowerShell.” You'll also learn how to work around these restrictions.
