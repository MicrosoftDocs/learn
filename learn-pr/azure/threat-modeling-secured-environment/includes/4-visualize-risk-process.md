### Process

![Process Element Image.](../media/elements/process-50.png)

#### What is process?

Process is a task that receives, modifies, or redirects input to output.

#### Process context to consider

|Context|Questions|
|-------|---------|
|Code|Is the process running in C#, C++, Objective C, Java, or a scripting language?|
|Permission level|Does the process need kernel, local, or administration level permissions to run?|
|Service isolation|Is the process running in a sandbox?|
|Input|Can the process accept input from everyone, local accounts, or just administrators?|
|Validation|How does the process parse, handle and accept input?|
|Authentication|Does the process rely on Azure Active Directory for authentication? If not, what does it rely on?|
|Authorization|Does the process rely on Access Control Lists (ACL) for authorization? If not, what does it rely on?|

#### Woodgrove process elements

- Azure AD service
- PAW service
- Fourth Coffee application
