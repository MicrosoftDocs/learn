You needed to allow the employees to share their public LinkedIn profile URL, Skype ID, and Xbox gamertag through the team bonding app. Microsoft Graph extensions was fronted as a suitable option that wouldn't introduce additional overheads like a new database system.

You explored the four extensibility options provided by Microsoft Graph and identified the following patterns for working with each extensibility option:
+ Ability to customize extension names and properties
+ Permissions required by users to manage their data
+ Syntax of REST API requests for each extension type and their associated data
+ Ease of managing the extensions by grouping extension properties and applying query parameters
+ Additional Azure AD scenarios that the extension types support
+ Considerations, limitations, and restrictions for each extension type

From your learnings and hands-on prototyping, you can now select an option that's best fit for the current needs of the team bonding app or future needs of the organization.

Microsoft Graph extensions provide you with a lightweight option to store custom user data without an external data store. Because the organization already uses Azure AD as an Identity and Access Management (IAM) solution, using extensions allows it to leverage functionality that's already available with its license at no additional cost.

Apart from users, other Microsoft Graph resource types may support some of the extensions. 

<!--
The following table summarizes the capabilities provided by the extension options.

| Capability | Extension attributes 1-15 | Directory extensions | Schema extensions | Open extensions |
|--|--|--|--|--|
| Supported resource types | [user][] <br/>[device][] | [user][] <br/> [group][] [administrativeUnit][] <br/> [application][] <br/>[device][] <br/> [organization][] | [user][] <br/> [group][] [administrativeUnit][] <br/> [contact][] <br/> [device][] <br/> [event][] (both user and group calendars) <br/> [message][] <br/> [organization][] <br/> [post][] <br/> [todoTask][] <br/> [todoTaskList][] | [user][] <br/> [group][]  <br/> [contact][] <br/> [device][] <br/> [event][]<sup>1</sup> (both user and group calendars) <br/> [message][] <br/> [organization][] <br/> [post][] |
| Strongly-typed | No | Yes | Yes | No |
| Filterable | Yes | Yes | Yes | No |
| Managed via | Microsoft Graph <br/> Exchange admin center | Microsoft Graph | Microsoft Graph | Microsoft Graph |
| Sync data from on-premises to extensions using [AD connect][] | Yes, for users | [Yes][ADConnect-YES] | No | No |
| Create [dynamic membership rules][] using custom extension properties and data | [Yes][DynamicMembership-YES] | [Yes][DynamicMembership-YES] | No | No |
| Usable for customizing token claims | Yes | [Yes][DirectoryExt-CustomClaims] | No | No |
| Available in Azure AD B2C | Yes | [Yes][B2CDirectoryExt] | Yes | Yes |
| Limits | <li>15 predefined attributes per user or device resource instance | <li>100 extension values per resource instance | <li>Maximum of five definitions per owner app <br/><li> 100 extension values per resource instance (directory objects only) | <li>Two open extensions per creator app per resource instance<sup>2</sup> <br/><li> Max. of 2Kb per open extension<sup>2</sup><li> For Outlook resources, each open extension is stored in a [MAPI named property][MAPI-named-property]<sup>3</sup> |


> [!NOTE]
> 
> <sup>1</sup> Due to an existing service limitation, delegates cannot create open extension-appended events in shared mailbox calendars. Attempts to do so will result in an `ErrorAccessDenied` response.
>
> <sup>2</sup> These limits on open extensions apply to the following directory resources: **user**, **group**, **device**, and **organization**.
>
> <sup>3</sup> Each open extension is stored in a [MAPI named property](/office/client-developer/outlook/mapi/mapi-named-properties), which are a limited resource in a user's mailbox. This limit applies to the following Outlook resources: **message**, **event**, and **contact**
>
> You can manage all extensions when you're signed in with a work or school account. Additionally, you can manage open extensions for the following resources when signed-in with a personal Microsoft account: **event**, **post**, **group**, **message**, **contact**, and **user**.

-->
## References

+ [Add custom data to resources using extensions](/graph/extensibility-overview)
+ [Microsoft Graph directory extensions](/graph/api/resources/extensionproperty)
+ [Microsoft Graph open type extensions](/graph/api/resources/opentypeextension)
+ [Microsoft Graph schema extensions](/graph/api/resources/schemaextension)


<!-- Links -->
[user]: /graph/api/resources/user
[group]: /graph/api/resources/group
[contact]: /graph/api/resources/contact
[administrativeUnit]: /graph/api/resources/administrativeunit
[application]: /graph/api/resources/application
[device]: /graph/api/resources/device
[event]: /graph/api/resources/event
[message]: /graph/api/resources/message
[organization]: /graph/api/resources/organization
[post]: /graph/api/resources/post
[todoTask]: /graph/api/resources/todotask
[todoTaskList]: /graph/api/resources/todotasklist
[servicePrincipal]: /graph/api/resources/serviceprincipal
[AD connect]: /azure/active-directory/hybrid/whatis-hybrid-identity?context=/azure/active-directory/enterprise-users/context/ugr-context
[ADConnect-YES]: /azure/active-directory/hybrid/how-to-connect-sync-feature-directory-extensions
[dynamic membership rules]: /azure/active-directory/enterprise-users/groups-dynamic-membership
[DynamicMembership-YES]: /azure/active-directory/enterprise-users/groups-dynamic-membership#extension-properties-and-custom-extension-properties
[DirectoryExt-CustomClaims]: /azure/active-directory/develop/active-directory-optional-claims#configuring-directory-extension-optional-claims
[B2CDirectoryExt]: /azure/active-directory-b2c/user-profile-attributes#extension-attributes
[MAPI-named-property]: /office/client-developer/outlook/mapi/mapi-named-properties