App role is another feature you can and should configure when performing an app registration. And app role is a tag or claim that can be applied to a user, group, or application that will appear with the token generated when a user authenticates for an app. The app role data in the token can then be used in the application for authorization purposes. App role is another way to work around the over usage of groups assigned to an application, because that is a Microsoft Entra P1 feature. To take advantage of this feature, the admin in an app, you define app roles that allow users and groups as member types. As shown in the following screen of the App registrations - App roles - Create app role screen, select Users/Groups for Allowed member types.

:::image type="content" source="../media/app-registration-create-app-roles-78b223c5-a47f3b92-45495f05.png" alt-text="Screenshot of create app roles in app registration of Microsoft Entra ID.":::


Having created the app role in the app's registration, IT Pros can assign users and groups to the role. Your app will get a roles claim in your token (ID token for app, access token for APIs) with all the signed-in user's assigned roles as shown in the following token sample.

```
"iss": "https://login.microsoftonline.com/833ced3d-cb2e-41de-92f1-29e2af035ddc/v2.0",
"iat": 1670826509, "nbf": 1670826509, "exp": 1670830409,
"name": "Kyle Marsh",
"oid": "cb7eda1b-d09a-419e-b8bb-37836ebc6abd",
"preferred_username": "kylemar@idfordevs.dev",
"roles": [
"Approver",
"Reviewer"
],
"sub": "dx-4lf-0loB3c3uVrULnZ2VTLuRRWYff0q7-QlIfYU4",
"tid": "833ced3d-cb3e-41de-92f1-29e2af035ddc",


```

When you create app roles that allow user and groups as members, always define a baseline user role with no elevated authorization roles. When an Enterprise App configuration requires assignment, only users with direct assignment to an application or membership in a group assigned to the app can use the app. If your app has defined app roles that allow users and groups as members then, when a user or group is assigned to the app, one of the defined app roles must be part of the user or group's assignment to the app. If your app has only defined elevated roles (such as admin) for the app, then all users and groups would be assigned the admin role. When you define a base role (such as user), users and groups assigned to the app can be assigned the base user role.

In addition to avoiding group overage claims, another advantage of using roles isn't needing to map between a group ID or name and what it means in your application. For example, your code can look for the admin role claim instead of iterating through groups in the groups claims and deciding which group IDs should be allowed the admin functionality.
