You needed to allow the employees to share their public LinkedIn profile URL, Skype ID, and Xbox gamertag through the team bonding app. Microsoft Graph extensions was recommended as a suitable option that would help the organization avoid an overhead like a new database system.

You explored the four extension options provided by Microsoft Graph and identified the following patterns for working with each extension option:
+ Ability to customize extension names and properties
+ Permissions required by users to manage their data
+ Syntax of REST API requests for each extension type and their associated data
+ Ease of managing the extensions by grouping extension properties and applying query parameters
+ Azure AD scenarios that the extension types support
+ Considerations, limitations, and restrictions for each extension type

From your learnings and hands-on prototyping, you can now select an option that's best fit for the current needs of the team bonding app or future needs of the organization.

Without Microsoft Graph extensions, you would need to explore alternative options to store the three pieces of data in the user's profile information. If the options are outside Azure AD and Microsoft 365, you need to integrate your app to the separate data source and manage the data. This introduces a cost overhead for you as a developer and to the organization.

By using Microsoft Graph extensions, the organization uses an existing capability of Azure AD that's available through its license at no additional cost. All the data is stored securely and availability is guaranteed in line with Microsoft's service-level agreements. In addition, the organization doesn't need to invest in a database system.

Apart from the **user** resource, other Microsoft Graph resource types may support some of the extensions. For example, the **device** resource type supports all the extension options while the **group** resource type supports schema, directory, and open extensions. To learn more, visit the links below.

## References

+ [Add custom data to resources using extensions](/graph/extensibility-overview)
+ [Microsoft Graph directory extensions](/graph/api/resources/extensionproperty)
+ [Microsoft Graph open type extensions](/graph/api/resources/opentypeextension)
+ [Microsoft Graph schema extensions](/graph/api/resources/schemaextension)
+ [Customize claims using directory extensions](/azure/active-directory/develop/active-directory-schema-extensions)