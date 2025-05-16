When configuring user rights, it's important to follow the principle of least privilege. This means granting users only the rights and privileges they need to perform their tasks, and no more. As a result, if an unauthorized user compromises an account, they gain access only to the limited set of privileges assigned to that account. IT staff should also have separate accounts for day-to-day activities such as answering email, separate from the privileged accounts used to perform administrative tasks.

Additional reading: For more information about implementing the principle of least privilege, see [Implementing Least-Privilege Administrative Models](https://aka.ms/implementing-least-privilege-administrative-models).

| User rights assignment policy| Function|
| :--- | :--- |
| Access Credential Manager as a trusted caller| Used by Credential Manager during backup and restore. You shouldn't assign this privilege to user accounts.|
| Access this computer from the network| Determines which users and groups can connect to the computer from the network. This right doesn't affect Remote Desktop Services.|
| Act as part of the operating system| Allows a process to impersonate a user without authentication. You typically would assign the LocalSystem account to processes that require this privilege.|
| Add workstations to a domain| Allows you to join workstations to the domain.|
| Adjust memory quotas for a process| Determines which security principals can adjust the maximum amount of memory assigned to a process.|
| Allow sign in locally| Determines which users can sign in locally to a computer. Alter this policy on Privileged Access Workstations to remove members of the Users group as a way of limiting which accounts can sign in to a computer. By default, any authenticated user can sign in to any workstation or server except for a Domain Controller, which is limited to members of certain groups.|
| Allow sign in through Remote Desktop Services| Determines which users and groups can sign in remotely by using a Remote Desktop Service connection.|
| Back up files and directories| Gives permission to back up files, directories, registry, and other objects to which the user normally wouldn't have permission. Assigning this right gives indirect access to all data on a computer because the person with that right can back that data up and then recover it in an environment over which they have complete control.|
| Bypass traverse checking| Allows the user with this right to traverse directories on which they don’t have permission. It doesn't allow the user to list the contents of that directory though.|
| Change the system time| Allows the user with this right to alter the system time, which is separate from the time zone.|
| Change the time zone| Allows the user with this right to alter the time zone, but not the system time.|
| Create a page file| Allows the user with this right to create and modify a page file.|
| Create a token object| Determines which user accounts that processes can use to create tokens that allow access to local resources. Don't assign this right to any user you don’t want to have complete system control, because they can use it to leverage local Administrator privileges.|
| Create global objects| Determines which user accounts can create global objects that are available to all sessions. Don't assign this right to any user you don’t want to give complete system control, because they can use it to leverage local Administrator privileges.|
| Create permanent shared objects| Determines which user accounts can create directory objects by using the object manager.|
| Create symbolic links| Determines which user accounts can create symbolic links from the computer they're signed in to. You should assign this right only to trusted users because symbolic links can expose security vulnerabilities in apps that aren’t configured to support them.|
| Debug programs| Determines which user accounts can attach a debugger to processes within the operating system kernel. Only developers who are writing new system components require this ability. Developers who are writing applications don't.|
| Deny access to this computer from the network| Blocks specified users and groups from accessing the computer from the network. This setting overrides the policy that allows access from the network.|
| Deny sign in as a batch job| Blocks specified users and groups from signing in as a batch job. This overrides the sign-in as a batch job policy.|
| Deny sign in as a service| Blocks service accounts from registering a process as a service. This policy overrides the sign in as a service policy. However, it doesn't apply to Local System, Local Service, or Network Service accounts.|
| Deny sign in locally| Blocks accounts from signing on locally. This policy overrides the Allow sign in locally policy.|
| Deny sign in through Remote Desktop Services| Blocks accounts from signing in by using Remote Desktop Services. This policy overrides the Allow sign in through Remote Desktop Services policy.|
| Enable computer and user accounts to be trusted for delegation| Determines whether you can configure the Trusted for Delegation setting on a user or a computer object.|
| Force shutdown from a remote system| Users assigned this right can shut down computers from remote network locations.|
| Generate security audits| Determines which accounts processes can use to add items to the security log. Because this right allows interaction with the security log, it presents a security risk when you assign this to a user account.|
| Impersonate a client after authentication| Allows apps that are running on behalf of a user to impersonate a client. This right can be a security risk, and you should assign it only to trusted users.|
| Increase a process working set| Accounts assigned this right can increase or decrease the number of memory pages available for the process to use to the process in random access memory (RAM).|
| Increase scheduling priority| Accounts assigned this right can change the scheduling priority of a process.|
| Load and unload device drivers| Accounts assigned this right can dynamically load and unload device drivers into kernel mode. This right is separate from the right to load and unload plug and play drivers. Assigning this right is a security risk because it grants access to the kernel mode.|
| Lock pages in memory| Accounts assigned this right can use a process to keep data stored in physical memory, blocking that data from paging to virtual memory.|
| Sign in as a batch job| Users with accounts that have this permission can sign in to a computer through a batch-queue facility. This right is only relevant to older versions of the Windows operating system, and you shouldn't use it with newer versions, such as Windows 10 and Windows Server 2016 or later.|
| Sign in as a service| Allows a security principal to sign in as a service. You need to assign this right when any service that you configure to use a user account, rather than one of the built-in service accounts.|
| Manage auditing and security log| Users assigned this right can configure object access auditing options for resources such as files and AD DS (Active Directory) objects. Users assigned this right can also review events in the security log and clear the security log. Because unauthorized users are likely to clear the security log as a way of hiding their tracks, you shouldn't assign this right to user accounts to which you wouldn't assign local Administrator permissions on a computer.|
| Modify an object label| Users with this permission can modify the integrity level of objects, including files, registry keys, or processes that other users own.|
| Modify firmware environment values| Determines which users can modify firmware environment variables. This policy is primarily for modifying the boot-configuration settings of non-x86-based computers|
| Perform volume maintenance tasks| Determines which user accounts can perform maintenance tasks on a volume. Assigning this right is a security risk because users who have this permission might access data stored on the volume.|
| Profile single process| Determines which user accounts can leverage performance-monitoring tools to monitor nonsystem processes.|
| Profile system performance| Determines which user accounts can leverage performance-monitoring tools to monitor system processes.|
| Remove computer from docking station| When assigned, a user account can remove a portable computer from a docking station without signing in.|
| Replace a process-level token| When assigned, a user account can call the **CreateProcessAsUser** API so that one service can trigger another.|
| Restore files and directories| Allows users assigned this right to bypass permissions on files, directories, and the registry and overwrite these objects with restored data. This right is a security risk, as a user account with this right can overwrite registry settings and replace existing permissions.|
| Shut down the system| Assigns the ability for a locally signed-in user to shut down the operating system.|
| Synchronize directory service data| Assigns the ability to synchronize AD DS data.|
| Take ownership of files or other objects| When assigned, this user account can take ownership of any securable object, including AD DS objects, files, folders, registry keys, processes, and threads. This represents a security risk because it allows the user to take control of any securable object.|

You can also configure additional account security options that limit how and when an account can be used, including:

- **Logon Hours**. Use this setting to configure when users can use an account.

- **Logon Workstations**. Use this setting to limit the computers an account can sign in to. By default, users can use an account to sign in to any computer in the domain.

- **Password Never Expires**. You should never configure this option for privileged accounts because it exempts the account from the domain password policy.

- **Smart card is required for interactive logon**. In high-security environments, you can enable this option to ensure that only an authorized person that has both the smart card and the account credentials can use the privileged account.

- **Account is sensitive and cannot be delegated**. When you enable this option, you ensure that trusted applications can't forward an account’s credentials to other services or computers on the network. You should enable this setting for highly privileged accounts.

- **Use only Kerberos Data Encryption Standard (DES) encryption types for this account**. This option configures an account to use only DES encryption, which is a weaker form of encryption than Advanced Encryption Standard (AES). You shouldn't configure this option on a secure network.

- **This account supports Kerberos AES 128-bit encryption**. When you enable this option, you're allowing Kerberos AES 128-bit encryption to occur.

- **This account supports Kerberos AES 256-bit encryption**. When possible, you should configure this option for privileged accounts and have them use this form of Kerberos encryption over the AES 128-bit encryption option.

- **Do not require Kerberos preauthentication**. Kerberos preauthentication reduces the risk of replay attacks. Therefore, you shouldn't enable this option.

- **Account expires**. Allows you to configure an end date for an account so that it doesn't remain in AD DS after it's no longer used.

