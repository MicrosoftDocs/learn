The **Enter-PSSession** and **Invoke-Command** commands support several parameters that you can use to change common connection options. These parameters include:

- *–Port*. Specifies an alternate TCP port for the connection. Use this parameter when the computer to which you're connecting is listening on a port other than the default 5985 (HTTP) or 5986 (HTTPS). Be aware that you can, locally or through Group Policy, configure a different port as a permanent new default.
- *–UseSSL*. Instructs Windows PowerShell to use HTTPS instead of HTTP.
- *–Credential*. Specifies an alternative credential for the connection. This credential will be validated by the remote computer and must have sufficient privileges and permissions to perform whatever tasks you intend to perform on the remote computer.
- *–ConfigurationName*. Connects to an endpoint (session configuration) other than the default endpoint. For example, you can specify microsoft.powershell32 to connect to the remote computer’s 32-bit Windows PowerShell endpoint.
- *–Authentication*. Specifies an authentication protocol. The default is Kerberos authentication, but other options include Basic, CredSSP, Digest, Negotiate, and NegotiateWithImplicitCredential. The protocol that you specify must be enabled in the WS-Management configuration on both the initiating and receiving computers.

You can configure additional session options by using **New-PSSessionOption** to create a new session option object, and then passing it to the *–SessionOption* parameter of **Enter-PSSession** or **Invoke-Command**. Review the Help file for **New-PSSessionOption** to learn about its capabilities. You can modify the default values, such as the port number and enabled authentication protocols in the WSMan PowerShell drive.
