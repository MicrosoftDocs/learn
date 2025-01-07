The FSLogix Apps RuleEditor is a standalone application that creates FSLogix Rule Set files. FSLogix Apps Services (frxsvc) processes Rule Set files and can perform various actions that manage the end-user experience in virtual desktop environments. Rule Set files are a collection of rules that show, hide, redirect, or customize specific aspects of the registry, file system, applications or printers. A single Rule Set file can support any number of rules of varying types. In most cases, keeping the Rule Set files contained to a specific type of customization makes them easier to maintain and troubleshoot.

## Types of rules

You can create four types of rules:

 -  Hiding rule
 -  Redirection rule
 -  App container (VHD) rule
 -  Specify value rule

### Hiding rule

A hiding rule hides specific items from a user or group of users. Hiding rules can apply to files, folders, registry keys, registry values, printers, or fonts.

### Redirection rule

Redirection rules allow IT administrators to redirect non-profile or other specific data into the user profile container so it's available on subsequent sign-ins regardless of which virtual machine they sign into.

### App container (VHD) rule

You can contain applications with a large amount of read-only data (for example, Clip Art galleries, Java applications, and so on) within a VHD and mount them to a virtual machine. App container rules let you automate this process by automatically mounting these VHDs for specific users at sign-in.

### Specify value rule

The specify value rule will, at sign-in, set a registry value for a specific user or group of users. This rule is most commonly used when users need HKLM-based registry key values to change based on which users are signing in.

## Rule assignments

> [!IMPORTANT]
> FSLogix Apps Rule Set assignments don't support Microsoft Entra ID cloud-only accounts. To use the assignment functionality, you must sync the users and groups from an Active Directory domain controller. Additionally, the virtual machines must have line-of-sight to a domain controller to resolve SIDs.

Application Rule Sets are assigned to users, groups, and other entities using the RuleEditor. Newly created rules automatically have the Everyone group assigned with the Applies setting configured to No.

### Assignment order

The ordering of assignments affects how the Rule Set is applied. When the assignment file is processed, the Rule Set is applied from top to bottom. Assignment ordering is managed using the Move Up and Move Down buttons.

:::image type="content" source="../media/fsl-ruleset-assignment-everyone-top-0a161ab3.jpg" alt-text="Screenshot displays the Everyone group processed at top.":::


**Result:** Rule Set applies to CONTOSO\\Domain Users only.

:::image type="content" source="../media/fsl-ruleset-assignment-everyone-bottom-6f4d45be.jpg" alt-text="Screenshot displays the Everyone group processed at bottom.":::


**Result:** Rule Set **does not** apply to any user or group.<br>

### Assignment types

You can assign Rule Sets to the following entities:

 -  User
 -  Group
 -  Process
 -  Network Location (IP Address)
 -  Computer
 -  Directory container (distinguished name)
 -  Environment variable

> [!NOTE]
> Any environment variable present at user sign in can be used as part of an assignment.

### Assignment template

You can save the assignments and assignment order as a template for later use. This template becomes the default assignment configuration for any new Rule Sets you create on the same machine.

:::image type="content" source="../media/fsl-ruleset-assignment-template-warning-b6cb60a8.jpg" alt-text="Screenshot displays the Save as Template warning dialog.":::
