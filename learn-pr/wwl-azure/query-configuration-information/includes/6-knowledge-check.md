Use the following questions to check what you’ve learned in this module.

### Multiple Choice

1.	When you perform a wildcard match in a filter for a Common Information Model (CIM) or Windows Management Instrumentation (WMI) cmdlet, which character is used as the wildcard?

( ) `?` {{Incorrect. When you use LIKE in a filter for CIM or WMI, the `%` character is used as the wildcard character. Typically, Windows PowerShell uses the `*` character.}}

( ) `=` {{Incorrect. When you use LIKE in a filter for CIM or WMI, the `%` character is used as the wildcard character. Typically, Windows PowerShell uses the `*` character.}}

( ) `*` {{Incorrect. When you use LIKE in a filter for CIM or WMI, the `%` character is used as the wildcard character. Typically, Windows PowerShell uses the `*` character.}}

(x) `%` {{Correct. When you use LIKE in a filter for CIM or WMI, the `%` character is used as the wildcard character. Typically, Windows PowerShell uses the `*` character.}}

---

2. Which cmdlet allows you to create a DCOM connection to query CIM objects from a remote computer?

(x) `New-CimSession` {{Correct. By default, the CIM cmdlets use WS-MAN for connectivity to remote computers. You can force a remote connection to use DCOM by creating a CIM session object with the DCOM setting and then using the CIM session to perform the query.}}

( ) `Get-CimInstance` {{Incorrect. The `new-CimSession` cmdlet allows you to create a DCOM connection to query CIM objects from a remote computer. By default, the CIM cmdlets use WS-MAN for connectivity to remote computers. You can force a remote connection to use DCOM by creating a CIM session object with the DCOM setting and then using the CIM session to perform the query.}}

( ) `Get-WmiObject` {{Incorrect. The `new-CimSession` cmdlet allows you to create a DCOM connection to query CIM objects from a remote computer. By default, the CIM cmdlets use WS-MAN for connectivity to remote computers. You can force a remote connection to use DCOM by creating a CIM session object with the DCOM setting and then using the CIM session to perform the query.}}

( ) `Get-CimClass` {{Incorrect. The `new-CimSession` cmdlet allows you to create a DCOM connection to query CIM objects from a remote computer. By default, the CIM cmdlets use WS-MAN for connectivity to remote computers. You can force a remote connection to use DCOM by creating a CIM session object with the DCOM setting and then using the CIM session to perform the query.}}
