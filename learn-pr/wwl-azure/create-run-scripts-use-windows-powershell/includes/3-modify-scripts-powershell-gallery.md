Most administrators don't create their own scripts at first. Instead, they begin by using existing scripts, and if necessary, modifying those scripts to meet their needs. For example, you might start with a simple script that queries Active Directory Domain Services (AD DS) for users who haven't signed in for an extended period of time and then generates a report. You could modify that script to automatically disable those stale accounts in addition to generating the report.

Generally, modifying an existing script is easier and faster than creating your own. The more complex the tasks, the more likely this is to be true. However, you should review all scripts and test them in a non-production environment before using them. Even if the author isn't malicious, there could be a bug in the script, or you might be using the script in a way that the author didn't intend.

## PowerShell Gallery

Microsoft provides an organized set of scripts and modules in the PowerShell Gallery. The PowerShell Gallery contains content published by Microsoft and PowerShell Gallery members. You can use modules from the PowerShell Gallery to simplify building your scripts.

> **Additional reading:** For more information, refer to the [PowerShell Gallery](https://aka.ms/ue14hl).

## The internet

There are websites and blogs not associated with Microsoft that provide scripts and code samples. These resources are typically found by using a search engine with which you can search for how to complete a specific task by using Windows PowerShell. There are some useful resources in the blogs and articles, but you should be careful in your testing.

