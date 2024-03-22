This unit describes best practices that you can apply to get the most out of Microsoft Graph and make your application more reliable for end users.

## Authentication

To access the data in Microsoft Graph, your application needs to acquire an OAuth 2.0 access token, and presents it to Microsoft Graph in either of the following methods:

* The HTTP *Authorization* request header, as a *Bearer* token
* The graph client constructor, when using a Microsoft Graph client library

Use the Microsoft Authentication Library API, [MSAL](/azure/active-directory/develop/active-directory-v2-libraries) to acquire the access token to Microsoft Graph.

## Consent and authorization

Apply the following best practices for consent and authorization in your app:

* **Use least privilege**. Only request permissions that are necessary, and only when you need them. For the APIs, your application calls check the permissions section in the method topics. For example, see [creating a user](/graph/api/user-post-users) and choose the least privileged permissions.

* **Use the correct permission type based on scenarios**. If you're building an interactive application where a signed in user is present, your application should use *delegated* permissions. If, however, your application runs without a signed-in user, such as a background service or daemon, your application should use application permissions.

    > [!CAUTION]
    > Using application permissions for interactive scenarios can put your application at compliance and security risk. Be sure to check user's privileges to ensure they don't have undesired access to information, or are circumnavigating policies configured by an administrator.

* **Consider the end user and admin experience**. Directly affects end user and admin experiences. For example:

    * Consider who will be consenting to your application, either end users or administrators, and configure your application to [request permissions appropriately](/azure/active-directory/develop/v2-permissions-and-consent).

    * Ensure that you understand the difference between [static, dynamic and incremental consent](/azure/active-directory/develop/v2-permissions-and-consent#consent-types).

* **Consider multi-tenant applications**. Expect customers to have various application and consent controls in different states. For example:

    * Tenant administrators can disable the ability for end users to consent to applications. In this case, an administrator would need to consent on behalf of their users.

    * Tenant administrators can set custom authorization policies such as blocking users from reading other user's profiles, or limiting self-service group creation to a limited set of users. In this case, your application should expect to handle 403 error response when acting on behalf of a user.

## Handle responses effectively

Depending on the requests you make to Microsoft Graph, your applications should be prepared to handle different types of responses. The following are some of the most important practices to follow to ensure that your application behaves reliably and predictably for your end users. For example:

* **Pagination**: When querying resource collections, you should expect that Microsoft Graph returns the result set in multiple pages, due to server-side page size limits. Your application should **always** handle the possibility that the responses are paged in nature, and use the `@odata.nextLink` property to obtain the next paged set of results, until all pages of the result set are read. The final page doesn't include an `@odata.nextLink` property. For more information, visit [paging](/graph/paging).

* **Evolvable enumerations**: Adding members to existing enumerations can break applications already using these enums. Evolvable enums are a mechanism that Microsoft Graph API uses to add new members to existing enumerations without causing a breaking change for applications. By default, a GET operation returns only known members for properties of evolvable enum types and your application needs to handle only the known members. If you design your application to handle unknown members as well, you can opt in to receive those members by using an HTTP `Prefer` request header.

## Storing data locally

Your application should ideally make calls to Microsoft Graph to retrieve data in real time as necessary. You should only cache or store data locally necessary for a specific scenario, and if that use case is covered by your terms of use and privacy policy, and doesn't violate the [Microsoft APIs Terms of Use](/legal/microsoft-apis/terms-of-use?context=/graph/context). Your application should also implement proper retention and deletion policies.
