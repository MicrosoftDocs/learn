In this module, you learned about Windows PowerShell remoting architecture and Windows PowerShell remoting for single and multiple-computer management. You also learned about Windows PowerShell remoting security and privacy features.
The following are the key takeaways:

- Remoting starts with the WinRM service. It registers one or more listeners, with each listener accepting incoming traffic through either HTTP or HTTPS. 

- In a Windows PowerShell scenario, you would send commands to WinRM, which then runs the commands. The process is listed as **Wsmprovhost** in the remote computer’s process list.

- Remoting is a generalized way to transmit any command to a remote computer so it runs locally on that computer. The purpose of remoting is to reduce or eliminate the need for individual command authors to code their own communications protocols. 

- The *TrustedHosts* list is a locally configured setting that you also can configure by using a Group Policy Object (GPO). The *TrustedHosts* list enumerates the computers for which mutual authentication isn't possible.

- By default, remoting uses HTTP, which doesn't offer privacy or encryption of the content of your communication. 

- PowerShell remoting is enabled by default on Windows Server platforms. To manually enable Windows PowerShell remoting on a computer, run the Windows PowerShell Enable-PSRemoting cmdlet.

- Many organizations will prefer to centrally control Windows PowerShell remoting enablement and settings through GPOs. To enable remoting by using Group Policy, you should configure the Allow Remote Server Management Through WinRM policy setting in the appropriate GPO. 

- To help you manage the resources on your local computer, PowerShell includes a per-command throttling feature that lets you limit the number of concurrent remote connections established for each command. 
