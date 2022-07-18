<!-- 1. Restate the scenario problem --------------------------------------------------------------------------------

    Goal: Summarize the challenge(s) posed in the introduction scenario; be brief (1-2 sentences)

    Heading: none

    Example: "You are writing the instruction manual for a new model fire extinguisher. The instructions must be quickly read and understood by a wide variety of people."

    [Summary unit guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-module-summary-unit?branch=main)
-->

You want to allow the employees to share their public LinkedIn profile URL, Skype ID, and Xbox gamertag  through the team bonding app. You want to use Microsoft Graph extensions to avoid using a database system.

<!-- 2. Show how you solved the scenario problem(s)---------------------------------------------------

    Goal: Describe how you used the product to solve the problem(s) posed in the introduction scenario

    Heading: none; depending on length, you can put this in a separate paragraph or combine this with the previous section into a single paragraph

    Recommended: format this as lead-in sentence(s) followed by a list

    Example: "You did some research and found that Plain English is a good writing style for safety-critical communications. You applied several Plain English techniques to your instructions:
        * Removed unnecessary words, which made your sentences easier to read even in a stressful situation like a fire.
        * Made sure all sentences used the active voice, which made your content more direct.
        * Replaced fire-industry jargon with everyday words, which made the instructions accessible to a wider audience.
        * Replaced a comma-delimited list with a bulleted list, which made the steps to activate the fire extinguisher easier to follow."
 -->
TODO: add your lead-in sentence(s)
TODO: add your list of techniques used to solve the scenario problem

You explored the four extensibility options provided by Microsoft Graph to assess the best fit for your current and possible future data needs of the team bonding app. You identified the following patterns for working with each extensibility option:
+ Customization of extension names and properties
+ Permission requirements for users to managing their data via each extension type
+ Syntax of REST API requests for each extension type and their associated data
+ Ease of managing the extensions by grouping extension properties, applying query parameters
+ Additional Azure AD scenarios that the extension properties support
+ Considerations, limitations, and restrictions for each extension type


<!-- 3. Describe the experience without the product ---------------------------------------------------

    Goal: Describe what would be required to solve the problem without using the product; be brief (1-2 sentences)

    Heading: none; typically this will be a new paragraph

    Example: "Fire extinguishers are critical safety equipment for both homes and businesses. Despite their importance, many customers don't read the instructions ahead of time. Confusing instructions could mean customers don't use the extinguisher correctly when they're needed. This can result in loss of property or life."

 -->
TODO: describe the experience without the product

Microsoft Graph extensions provide you with a lightweight option to store custom user data without an external data store. The organization can choose one of the extension types that it considers easy to develop with or suitable for current and future needs. Apart from users, other Microsoft Graph resource types may support some of the extensions.

The following table provides a summary of the capabilities provided by the extension options.

| Capability | Extension attributes 1-15 | Directory extensions | Schema extensions | Open extensions |
|--|--|--|--|--|
| Supported resource types | [user][] <br/>[device][] | [user][] <br/> [group][] [administrativeUnit][] <br/> [application][] <br/>[device][] <br/> [organization][] | [user][] <br/> [group][] [administrativeUnit][] <br/> [contact][] <br/> [device][] <br/> [event][] (both user and group calendars) <br/> [message][] <br/> [organization][] <br/> [post][] <br/> [todoTask][] <br/> [todoTaskList][] | [user][] <br/> [group][] <!--<br/> [administrativeUnit][]--> <br/> [contact][] <br/> [device][] <br/> [event][]<sup>1</sup> (both user and group calendars) <br/> [message][] <br/> [organization][] <br/> [post][] |
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
> <sup>2</sup> These limits on open extensions apply to the following directory resources: **user**, **group**, **device**, <!--**administrativeUnit**,--> and **organization**.
>
> <sup>3</sup> Each open extension is stored in a [MAPI named property](/office/client-developer/outlook/mapi/mapi-named-properties), which are a limited resource in a user's mailbox. This limit applies to the following Outlook resources: **message**, **event**, and **contact**
>
> You can manage all extensions when you're signed in with a work or school account. Additionally, you can manage open extensions for the following resources when signed-in with a personal Microsoft account: **event**, **post**, **group**, **message**, **contact**, and **user**.

<!-- 4. Describe the business impact ----------------------------------------------------

    Goal: explain the business impact of using the product to solve the problem

    Heading: none; depending on length, you can put this in a separate paragraph or combine this with the previous section into a single paragraph

    Example: "The test for effective instructions is whether customers can use your extinguishers correctly during an emergency. Users that fail might blame the instructions or the product. In either case, it's not good for business. On the other hand, successful customers are likely to share their stories and become advocates for your product."
 -->
TODO: describe the business impact

<!-- 5. References (optional) ----------------------------------------------------

    Goal: Provide a few recommendations for further study via a bulleted list of links. This is optional and intended to be used sparingly.        - use the target page title as the text for your link
        - do not include other text such as a description
        - prefer other first-party sites like Docs reference pages
        - link to third-party sites only when they are trusted and authoritative
        - do not link to other Learn content ("next steps" recommendations are generated automatically)
        - avoid linking to opinion sites such as blog posts

    Heading: "## References"

    Example:
        "## References
          * [Administrator role permissions in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/users-groups-roles/directory-assign-admin-roles)
          * [What is Azure role-based access control (Azure RBAC)?](https://docs.microsoft.com/azure/role-based-access-control/overview)
          * [Manage access to billing information for Azure](https://docs.microsoft.com/azure/billing/billing-manage-access)"
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