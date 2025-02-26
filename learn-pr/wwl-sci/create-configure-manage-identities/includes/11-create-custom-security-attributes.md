:::image type="content" source="../media/custom-security-attributes.png" alt-text="Screenshot of the Custom Security Attributes dialog. Create new security attributes of type String, Integer, or Boolean.":::

## What is a custom security attribute?

Custom security attributes in Microsoft Entra ID are business-specific attributes (key-value pairs) that you can define and assign to Microsoft Entra objects. These attributes can be used to store information, categorize objects, or enforce fine-grained access control over specific Azure resources.

### Why use custom security attributes?

- Extend user profiles, such as add Employee Hire Date and Hourly Salary to all my employees.
- Ensure only administrators can see the Hourly Salary attribute in my employees' profiles.
- Categorize hundreds or thousands of applications to easily create a filterable inventory for auditing.
- Grant users access to the Azure Storage blobs belonging to a project.

### What can I do with custom security attributes?

- Define business-specific information (attributes) for your tenant.
- Add a set of custom security attributes on users, applications, Microsoft Entra resources, or Azure resources.
- Manage Microsoft Entra objects using custom security attributes with queries and filters.
- Provide attribute governance so attributes determine who can get access.

### Features of custom security attributes

 -  Available tenant-wide
 -  Include a description
 -  Support different data types: Boolean, integer, string
 -  Support single value or multiple values
 -  Support user-defined free-form values or predefined values
 -  Assign custom security attributes to directory synced users from an on-premises Active Directory
