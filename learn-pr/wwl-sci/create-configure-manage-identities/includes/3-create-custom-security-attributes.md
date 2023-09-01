:::image type="content" source="../media/custom-security-attributes-2ef80fb3-ada4249a.png" alt-text="Screenshot of the Azure A D new feature Custom Security Attributes.  You get to the feature in the base menu of Azure A D.  You have the ability to create new security attributes of type String, Integer, or Boolean.":::


## What is a custom security attribute?

Custom security attributes in Azure Active Directory (Azure AD) are business-specific attributes (key-value pairs) that you can define and assign to Azure AD objects. These attributes can be used to store information, categorize objects, or enforce fine-grained access control over specific Azure resources.

### Why use custom security attributes?

 -  Extend user profiles, such as add Employee Hire Date and Hourly Salary to all my employees.
 -  Ensure only administrators can see the Hourly Salary attribute in my employees' profiles.
 -  Categorize hundreds or thousands of applications to easily create a filterable inventory for auditing.
 -  Grant users access to the Azure Storage blobs belonging to a project.

### What can I do with custom security attributes?

 -  Define business-specific information (attributes) for your tenant.
 -  Add a set of custom security attributes on users, applications, Azure AD resources, or Azure resources.
 -  Manage Azure AD objects using custom security attributes with queries and filters.
 -  Provide attribute governance so attributes determine who can get access.

### Features of custom security attributes

 -  Available tenant-wide
 -  Include a description
 -  Support different data types: Boolean, integer, string
 -  Support single value or multiple values
 -  Support user-defined free-form values or predefined values
 -  Assign custom security attributes to directory synced users from an on-premises Active Directory
