For this module, you needed to allow your company's employees to share their public LinkedIn profile URL, Skype ID, and Xbox *gamertag* through the team-bonding app that your organization has deployed. We recommended that you use Microsoft Graph extensions as a suitable option to help your organization to store lightweight data without the overhead of a new database system.

You explored the four extension options provided by Microsoft Graph, and you identified the following considerations for working with each extension option:

+ Ability to customize extension names and properties.
+ Permissions required by users to manage their data.
+ Syntax of REST API requests for each extension type and their associated data.
+ Ease of managing the extensions by grouping properties and applying query parameters.
+ Azure Active Directory (Azure AD) scenarios that the extension types support.
+ Limitations and restrictions for each extension type.

From your learnings and hands-on prototyping, you can now select an option that best fits the current needs of your team-bonding app and the future needs of your organization.

Without Microsoft Graph extensions, you would need to explore alternative options for storing the three pieces of data in the user's profile information. If the options are outside Azure AD and Microsoft 365, you would need to integrate your app with the separate data source and manage the data. This alternative might introduce a needless cost overhead for you as a developer and to your organization.

By using Microsoft Graph extensions, the organization takes advantage of an existing Azure AD capability that's available through its license at no additional cost. All the data is stored securely and, in line with Microsoft service-level agreements, availability is guaranteed. In addition, your organization avoids having to invest in a database system.

Apart from the *user* resource, other Microsoft Graph resource types might support some of the extension options. For example, the *device* resource type supports all the extension options, and the *group* resource type supports schema, directory, and open extensions.

To learn more about these extension properties, including considerations and limitations for each type, see the following resources.

## References

+ [Add custom data to resources by using extensions](/graph/extensibility-overview)
+ [Microsoft Graph directory extensions](/graph/api/resources/extensionproperty)
+ [Microsoft Graph open type extensions](/graph/api/resources/opentypeextension)
+ [Microsoft Graph schema extensions](/graph/api/resources/schemaextension)
+ [Customize claims by using directory extensions](/azure/active-directory/develop/active-directory-schema-extensions)
