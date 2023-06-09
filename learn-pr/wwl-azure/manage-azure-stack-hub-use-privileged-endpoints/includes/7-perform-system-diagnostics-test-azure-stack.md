The Azure Stack Hub validation tool (Test-AzureStack) is a PowerShell cmdlet that lets you run a series of tests on your system to identify failures if present. You'll typically be asked to run this tool through the privileged end point (PEP) when you contact Microsoft Customer Services Support (Microsoft Support) with an issue. With the system-wide health and status information at hand, Microsoft Support can collect and analyze detailed logs, focus on the area where the error occurred, and work with you to fix the issue.

## Running the validation tool and accessing results

As stated above, the validation tool is run via the PEP. Each test returns a **PASS/FAIL** status in the PowerShell window. Here's an outline of the end-to-end validation testing process:

1.  Establish the trust. On an integrated system, run the following command from an elevated Windows PowerShell session to add the PEP as a trusted host on the hardened virtual machine running on the hardware lifecycle host or the Privileged Access Workstation.

```
winrm s winrm/config/client '@{TrustedHosts="<IP Address of Privileged Endpoint>"}'

```

If you're running the Azure Stack Development Kit (ASDK), sign in to the development kit host.

2.  Access the PEP. Run the following commands to establish a PEP session:

```
Enter-PSSession -ComputerName "<ERCS VM-name/IP address>" -ConfigurationName PrivilegedEndpoint -Credential $localcred

```

3.  Once you're in the PEP, run:

```
Test-AzureStack

```

4.  If any tests report FAIL, run **Get-AzureStackLog**.

The cmdlet gathers logs generated by Test-AzureStack. We recommend you don't collect logs and contact Microsoft Support instead if tests report **WARN**.

5.  If you're instructed to run the validation tool by the Microsoft Support, the Microsoft Support representative will request the logs you collected to continue troubleshooting your issue.
