Security is maybe not the first on your mind as you take your first steps in PowerShell. Nonetheless, sooner or later, you will start to build out your knowledge and you start writing and running scripts. It's important to be vigilant of the fact that there are malicious scripts out there that can compromise your machine. Knowing that there are features in place helping to protect you from such situations is a good first step.

## Execution policy feature

PowerShell has a safety feature in place called _execution policy_ that is able to control under which conditions config files and scripts are able to run.

There are some things you should know about _execution policy_

- **Not a system but basic rules**. It's important to realize that execution policy isn't a full fledged security system. Instead it's meant to be seen as something that sets up some basic rules. It's relatively easy to bypass the policies by executing script content on the command line instead. At the end of the day, what you get is a system that stops you from doing thing unintentionally.

- **It behaves differently on Windows and OSs**. Being able to set the execution policy, and thereby control what scripts can run, is for now a Windows only feature. On other operating systems the policy is set to `Unrestricted` and is not possible to change. It may sound like running PowerShell on Unix or macOS would be more insecure but the fact is these OSs have an underlying security model, a _default deny_ behavior, where you need to be explicit on what can run.

   > [!NOTE] There are cmdlets available to both reading and changing the execution policy but non Windows systems will respond with an unsupported message, if you were to try changing the policy.  

- **Enables granular control**. It's important to be able to manage the policies around security in an efficient way. What's not efficient is having to set a policy on each and every machine separately. Fortunately PowerShell comes with a granular control mechanism that helps you to not only set a policy, but also enables you define on what level it's being applied, its _scope_.

## Execution policy scope

You can set an execution policy that is only applied in a specific scope. This fact enables you have a fine grained control over what can run at what level. A specific user, like an admin can for example be trusted to execute scripts that a _normal_ user wouldn't be able to, save for _trusted scripts_. Conversely a _development machine_ might need a different policy that a machine running in production, that might need to be highly restricted. All of these scenarios needs to different policies to be applied on different levels.

PowerShell is able to configure a policy at the following levels:

- **Local computer**. You can set a _group policy_ that would apply to all users on that computer.
- **Current user**. This policy applies to the current user of the computer.
- **Specific session**. This policy is only enforced throughout the session and session to exist when the session is closed.

### Scope levels

What you need to know about the values is that they have a precedence. This means that if you configure a policy at certain level this will override a policy set at a lower level. To display the values and their precedence you can run the command `Get-ExecutionPolicy -List`. It will produce a result similar to the below table:

|Scope         |ExecutionPolicy      |
|--------------|---------------------|
|MachinePolicy |       Unrestricted   |
|UserPolicy    |       Undefined     |
|Process       |       Undefined     |
|CurrentUser   |       AllSigned     |
|LocalMachine  |    RemoteSigned     |

To exemplify how the precedence work, where you to set a stricter policy on `LocalMachine` than what's set on `MachinePolicy` it would not work. The `MachinePolicy` is at a higher level of precedence and therefore decides.

## Managing the execution policy

There's a concept called execution policy. It governs whether you have the right to run a script or not. It does not stop you from running a command interactively. Scripts are seen as insecure. The recommendation is therefore to ensure that any scripts you run is signed by a trusted publisher.

There are cmdlets created to help you manage your execution policy, so that you can both query the current state as well as changing it to your liking.

### Default values per OS

Depending on what operating system you are on, it will return with different default values. For a Windows machine the default value is `Restricted`, which means no scripts are able to run. For a Windows server, the default value is `RemoteSigned` meaning that you can run scripts if it's signed by a trusted publisher. The default for non-Windows OS is `Unrestricted` even though it's more like the `ByPass` value. The `ByPass` value is a val

### Reading the policy

The **Get-ExecutionPolicy** reads the state of your policy. Here are some values you are likely to encounter:

- **Unrestricted**. This value is not recommended as it allows you to run scripts, whether it's created by a trusted publisher or not.
- **Restricted**. Getting this as a response means you cannot execute scripts at all.
- **RemoteSigned**. This response means you can run scripts if it's signed by a trusted publisher. Therefore setting this as your execution is a recommended thing to do.
- **Default**. This value will be different depending on the OS of your machine.
- **Undefined**. If all scope levels have this value, then it falls back to the default for Windows operating system, so you don't end up in an unprotected state.

## Setting an execution policy

The cmdlet **Set-ExecutionPolicy** enables you to set the execution policy. As part of a setting the policy you can also set its scope, even if the last part is optional. Here's an example of what invoking this cmdlet can look like:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```

   > [!NOTE]
   > This command is not supported on all platforms. If it is supported, consider running it to ensure you don't run malicious scripts.