In this module, you learned about the advanced techniques that help overcome the shortcomings of the basic techniques of remoting. The following are the key takeaways:

- The **Enter-PSSession** and **Invoke-Command** commands support several parameters that you can use to change common connection options. These parameters are -Port, -UseSSL, -Credential, -ConfigurationName, and -Authentication.

- Windows PowerShell provides access protection to variables, aliases, functions, and Windows PowerShell drives by limiting where they can be changed and read.

- Windows PowerShell assumes that the variables used in remote commands are defined in the session in which the command runs.

- A challenge with remoting is related to delegating credentials across multiple remote connections. By default, credentials can be delegated across only one connection, or hop. This restrictions delegation prevents the remote computer from further delegating your credentials, since this could introduce an extra security risk.

- Just Enough Administration (JEA) is a security technology that enables delegated administration for anything managed by PowerShell. 