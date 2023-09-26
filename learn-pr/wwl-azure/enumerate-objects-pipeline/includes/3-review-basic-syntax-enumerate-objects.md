The **ForEach-Object** command performs enumeration. It has two common aliases: **ForEach** and **%**. Like **Where-Object**, **ForEach-Object** has a basic syntax and an advanced syntax.

In the basic syntax, you can run a single method or access a single property of the objects that were piped into the command. Here's an example:

```powershell
Get-ChildItem –Path C:\Encrypted\  -File | ForEach Object  -MemberName Encrypt
```

With this syntax, you don't include the parentheses after the member name if the member is a method. Because this basic syntax is meant to be short, you'll frequently notice it without the *-MemberName* parameter name, and you might notice it with an alias instead of the full command name. For example, both of the following commands perform the same action:

```powershell
Get-ChildItem –Path C:\Encrypted\ -File | ForEach Encrypt

Get-ChildItem –Path C:\Encrypted\ -File | % Encrypt
```

> [!NOTE]
> You might not run into many scenarios that require enumeration. Each new operating system and version of PowerShell introduces new PowerShell commands. Newer operating systems typically introduce new commands which perform actions that previously required enumeration.

## Limitations of the basic syntax

The basic syntax can access only a single property or method. It can't perform logical comparisons that use **-and** or **-or**; it can't make decisions; and it can't run any other commands or code. For example, the following command doesn't run, and it produces an error:

```powershell
Get-Service | ForEach -MemberName Stop -and -MemberName Close
```
