There are thousands of Windows PowerShell cmdlets built into the Windows operating systems and other Microsoft products. Memorizing the names and the syntax for all these commands isn't possible. Fortunately, cmdlet creators build cmdlets by using a common format that helps you predict both a cmdlet's name and its syntax. This common format makes it much easier to discover and use cmdlets.

> [!NOTE]
> The common format that PowerShell cmdlets use is the *Verb-Noun* notation.

## Cmdlet verbs

The verb portion of a cmdlet name indicates what the cmdlet does. There's a set of approved verbs that cmdlet creators use, which provides consistency in cmdlet names. Common verbs include:

- **Get**. Retrieves a resource, such as a file or a user.
- **Set**. Changes the data associated with a resource, such as a file or user property.
- **New**. Creates a resource, such as a file or user.
- **Add**. Adds a resource to a container of multiple resources.
- **Remove**. Deletes a resource from a container of multiple resources.

This list represents just some of the verbs that cmdlets use. Additionally, some verbs perform similar functions. For example, the **Add** verb can create a resource, similar to the **New** verb. Some verbs might seem similar, but have different functions. For example, the **Read** verb retrieves information that a resource contains, such as a text file's content, whereas the **Get** verb retrieves the actual file.

## Cmdlet nouns

The noun portion of a cmdlet name indicates what kinds of resources or objects the cmdlet affects. All cmdlets that operate on the same resource should use the same noun. For example, the **Service** noun is for cmdlets that work with Windows services and the **Process** noun is for managing processes on a computer.

Nouns can also have prefixes that help the grouping of related nouns into families. For example, the Active Directory nouns start with the letters **AD** (such as **ADUser**, **ADGroup**, and **ADComputer**). Microsoft SharePoint Server cmdlets begin with the prefix **SP**, and Microsoft Azure cmdlets begin with the prefix **Az**.

> [!NOTE]
> Windows PowerShell uses the generic term *command* to refer to cmdlets, functions, workflows, applications, and other items. These items differ in terms of creation method. However, for now, you should consider them as all working in the same way. This module uses the terms *command* and *cmdlet* interchangeably.
