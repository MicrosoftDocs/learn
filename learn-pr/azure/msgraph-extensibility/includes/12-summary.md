You needed to allow the employees to share their public LinkedIn profile URL, Skype ID, and Xbox gamertag through the team bonding app. Microsoft Graph extensions was recommended as a suitable option that wouldn't introduce additional overheads like a new database system.

You explored the four extension options provided by Microsoft Graph and identified the following patterns for working with each extension option:
+ Ability to customize extension names and properties
+ Permissions required by users to manage their data
+ Syntax of REST API requests for each extension type and their associated data
+ Ease of managing the extensions by grouping extension properties and applying query parameters
+ Additional Azure AD scenarios that the extension types support
+ Considerations, limitations, and restrictions for each extension type

From your learnings and hands-on prototyping, you can now select an option that's best fit for the current needs of the team bonding app or future needs of the organization.

Microsoft Graph extensions provide you with a lightweight option to store custom user data without an external data store. Because the organization already uses Azure AD as an Identity and Access Management (IAM) solution, using extensions allows it to leverage functionality that's already available with its license at no additional cost.

Apart from users, other Microsoft Graph resource types may support some of the extensions.

## References

+ [Add custom data to resources using extensions](/graph/extensibility-overview)
+ [Microsoft Graph directory extensions](/graph/api/resources/extensionproperty)
+ [Microsoft Graph open type extensions](/graph/api/resources/opentypeextension)
+ [Microsoft Graph schema extensions](/graph/api/resources/schemaextension)
+ [Customize claims using directory extensions](/azure/active-directory/develop/active-directory-schema-extensions)