It can be useful to restrict administrative scope by using administrative units in organizations that are made up of independent divisions of any kind.

## Example

Consider the example of a large university that's made up of many autonomous schools (School of Business, School of Engineering, and so on). Each school has a team of IT admins who control access, manage users, and set policies for their school.

A central administrator could:

 -  Create a role with administrative permissions over only Azure AD users in the business school administrative unit.
 -  Create an administrative unit for the School of Business.
 -  Populate the administrative unit with only the business school students and staff.
 -  Add the business school IT team to the role, along with its scope.

## Considerations

 -  You can manage administrative units by using the Azure portal, PowerShell cmdlets and scripts, or Microsoft Graph.
 -  In the portal, you can manage administrative units if you are a Global Administrator or a Privileged Role Administrator.
 -  Administrative units apply scope only to management permissions. They don't prevent members or administrators from using their default user permissions to browse other users, groups, or resources outside the administrative unit.
