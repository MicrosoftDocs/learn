The Microsoft identity platform implements the OAuth 2.0 authorization protocol. OAuth 2.0 is a method through which a third-party app can access web-hosted resources on behalf of a user. Any web-hosted resource that integrates with the Microsoft identity platform has a resource identifier, or application ID URI. The same is true for any third-party resources that have integrated with the Microsoft identity platform. Any of these resources can also define a set of permissions that can be used to divide the functionality of that resource into smaller chunks. As an example, Microsoft Graph has defined permissions to do the following tasks, among others:

 -  Read a user's calendar
 -  Write to a user's calendar
 -  Send mail as a user

Because of these types of permission definitions, the resource has fine-grained control over its data and how API functionality is exposed. A third-party app can request these permissions from users and administrators, who must approve the request before the app can access data or act on a user's behalf. When a resource's functionality is chunked into small permission sets, third-party apps can be built to request only the permissions that they need to perform their function. Users and administrators can know what data the app can access. Administrators can be more confident that the app isn't behaving with malicious intent. Developers should always abide by the principle of least privilege, asking for only the permissions they need for their applications to function.

## Configure API permissions

Configure delegated permission to Microsoft Graph to enable your client application to perform operations on behalf of the logged-in user, for example reading their email or modifying their profile. By default, users of your client app are asked when they sign in to consent to the delegated permissions you've configured for it.

:::image type="content" source="../media/app-registration-add-api-permission-ae399591-ac6c0fd4-e2bdf3cb.png" alt-text="Screenshot of the app registration api permissions configuration screen Microsoft Graph granted the user.read permission.":::


1.  Sign in to the Microsoft Entra admin center.
2.  Select Applications - App registrations, and then select your client application.<br>
3.  Select API permissions - Add a permission - Microsoft Graph
4.  Select Delegated permissions. Microsoft Graph exposes many permissions, with the most commonly used shown at the top of the list.
5.  Under Select permissions, select the following permissions:
    
    | **Permission**  | **Description**                                     |
    | --------------- | --------------------------------------------------- |
    | email           | View users' email address                           |
    | offline\_access | Maintain access to data you have given it access to |
    | openid          | Sign users in                                       |
    | profile         | View users' basic profile                           |
6.  Select Add permissions to complete the process.
