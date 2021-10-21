Session configuration files are used to register a JEA (Just Enough Administration) endpoint. The session configuration file is responsible for naming the JEA endpoint. It also controls:

- Who can access the JEA endpoint.

- What roles the user is assigned.

- Which identity is used by JEA's virtual account.

Session configuration files use the .pssc file extension, and you create new session configuration files by using the **New-PSSessionConfigurationFile** cmdlet.

You can also use session configuration files to define which cmdlets and functions are available in a JEA session, just like you can with role capabilities files. In addition, you can configure the following settings unique to session configure files:

- Sessiontype. This setting allows you to configure the sessions default settings. The Sessiontype of RestrictedRemoteServer is used for sessions used by JEA for secure management.

- RoleDefinitions. This setting is used to assign role capabilities to specific security groups.

- RunAsVirtualAccount. This setting allows JEA to use the privileged virtual account created just for the JEA session. This account is a member of the local Administrators group and the Domain Admins group on domain controllers.

- TranscriptDirectory. This setting specifies where JEA activity transcripts are stored.

- RunAsVirtualAccountGroup. This setting allows you to specify the groups that the virtual account is a member of, instead of the default Administrators or Domain Admins groups.

For a list of all the options when creating session configuration files, refer to the [New-PSSessionConfigurationFile](/powershell/module/microsoft.powershell.core/new-pssessionconfigurationfile?view=powershell-7.1) documentation page on docs.microsoft.com.

## Check your knowledge

Choose the best response for each of the questions below. Then select **Check your answers**.

## Multiple Choice
Which of the following settings should be configured in a session configuration file to ensure that a special account with local administrative credentials is used during a JEA session instead of the connecting users account?
()SessionType{{Incorrect. The SessionType setting allows you to configure the sessions default settings but does not allow you to assign a special virtual account that has local administrative privileges.}}
(x)RunAsVirtualAccount{{Correct. The RunAsVirtualAccount setting allows you to have the JEA session use a special virtual account with local administrative privileges.}}
()RunAsVirtualAccountGroup{{Incorrect. The RunAsVirtualAccountGroup allows you to have the JEA session use a special virtual account that is a member of a specified security group, but unless this specified security group has been granted administrative privileges, does not provide any extra privileges to the virtual account.}}
