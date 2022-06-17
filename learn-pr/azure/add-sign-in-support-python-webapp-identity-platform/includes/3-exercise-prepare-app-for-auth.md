
Now that you've registered your application with the Azure Active Directory (Azure AD), you require additional configurations to allow your app communicate with the identity platform.

In this exercise, you'll complete the following application-specific configurations on the Azure portal:

- Add a redirect URI
- Configure client credentials
- Add app roles to your application registration
- Assign app roles to users and groups

After configuring these application-specific settings, you'll update your Python Flask web app to use the app registration details.

## Add a redirect URI

The redirect URI, also known as Reply URL, is the location where the identity platform redirects a user's client and sends security tokens after authentication. During development, this is the endpoint where you run your app locally. To add a redirect URI for your Python Flask web app, follow these steps:

1. In the Azure portal, in **App registrations**, select your application.
2. Under **Manage**, select **Authentication**.
3. Under **Platform configurations**, select **Add a platform** 
4. Under **Configure platforms**, select **Web**.
5. Upon selecting web as your app's platform, you'll be prompted to enter a redirect URI for your app. Add `http://localhost:5000/auth/redirect` as the redirect URI for your web app.  
6. Select **Configure**.

## Configure credentials

Credentials are used by confidential client applications, such as web apps, that access a web API. Credentials allow your application to authenticate as itself, requiring no interaction from a user at runtime. You can add certificates, client secrets, or federated credentials to your confidential client app registration. 

In this module, you'll use a client secret, also known as an application password. This is a string value that the app can use to prove its identity when requesting a token. To add a client secret, follow these steps:

1. In the Azure portal, in **App registrations**, select your application.
1. Under **Manage**, select **Certificates & secrets** 
1. In the **Client secrets** section, select **New client secret**.
1. Under **Add a client secret**, add a description for your client secret.
1. Select an expiration for the secret or specify a custom lifetime.
   Client secret lifetime is limited to two years (24 months) or less. You can't specify a custom lifetime longer than 24 months. Microsoft recommends that you set an expiration value of less than 12 months.
1. Select **Add**.
1. Record the client secret value (not its ID) for use in your application's code. This secret value is only shown once when you create it. It will never be displayed again after you leave this page.

## Add app roles to your web application

App roles defined during the app registration process are used to securely enforce authorization in your application. When using app roles, an administrator grants permissions to roles and not to individual users or groups. The administrator can then assign roles to different users and groups to control who has access to what content and functionality. 

In this module, one route requires an application-defined admin app role. To add this role, follow these steps:

1. In the Azure portal, in **App registrations**, select your application.
1. Under **Manage**, select **App roles** and then **Create app role**.
1. In the **Create app role** pane, enter the settings for the role.
    - For the **Display name**, enter `admin`
    - For **Allowed member types:**, select **Users/Groups**
    - For **Value**, enter `admin`
    - For **Description**, add a more detailed app role description such as `admin app role` 
1. Select the checkbox under to enable this app role.
1. Select **Apply** to complete creating the app role.

## Assign app roles to users and groups

Once you've added the app roles in your application, you can assign users and groups to the roles. To assign users and groups to the created `admin role` using the Azure portal UI:

1. In the Azure portal, select Azure **Active Directory**. 
1. Under **Manage**, select **Enterprise applications**
1. Select **All applications** to view a list of all your applications. If your Python web app doesn't appear in the list, search using the application name or ID. You can also use the filters at the top of the **All applications** list to restrict the list, or scroll down the list to locate your application. 
1. Select the application you want to assign users or groups to roles. In this case, your Python-web-app
1. Under **Manage**, select **Users and groups**.
1. Select **Add user/group** to open the **Add Assignment** pane.
1. Select the **Users and groups** selector from the **Add Assignment** pane. A list of users and security groups is displayed. You can search for a certain user or group as well as select multiple users and groups that appear in the list. For this tutorial, add *yourself* and select the **Select** button to proceed.
1. On the **Select a role** in the **Add assignment** pane, chose the `admin role` you previously created.
1. Select the **Assign butto**n to finish the assignment of users and groups to the app.
1. Confirm that the users and groups you added appear in the **Users and groups** list.

## Update the application to use your app registration details.

Open the default_settings.py file and modify the three Azure Active Directory configuration properties using the values from your app's registration in the Azure portal.

```Python
# 'Application (client) ID' of app registration in Azure portal - this value is a GUID
CLIENT_ID = ""

# Client secret 'Value' (not its ID) from 'Client secrets' in app registration in Azure portal
CLIENT_CREDENTIAL = ""

# Full directory URL, in the form of https://login.microsoftonline.com/<tenant>
AUTHORITY = ""
```