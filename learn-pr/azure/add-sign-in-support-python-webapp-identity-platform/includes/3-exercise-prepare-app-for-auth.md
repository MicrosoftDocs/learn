Now that you've understood how the Microsoft identity platform works, you'll create a Python web app and implement the authentication and authorization logic using Azure AD. 

In this exercise, you'll register the Python web app you create in the Azure portal. You'll also complete the following application-specific configurations on the Azure portal:

- Add a redirect URI
- Configure client credentials
- Add app roles to your application registration
- Assign app roles to users and groups

After configuring these application-specific settings, you'll update your Python Flask web app to use the app registration details.

## Create your Python Flask web application

To complete the rest of the module, you'll need to create a Python Flask web app project. If you prefer using a completed code sample for learning, download the [Python Flask web app sample](https://github.com/Azure-Samples/msid-add-authnz-python-webapp) from GitHub. 

If you prefer following the module and building the Python Flask web app by yourself, follow the steps below:

1. Create a folder to host your application and name it `python-flask-webapp`, for example.
1. Navigate to your project directory and create three files named `app.py`, `default_settings.py`, and `requirements.txt`
1. In your project root directory, create a sub-directory named `templates`. Flask will look for rendering templates in this directory. 
1. At the end of the module, your project's file and directory structure should look similar to this:

```
python-webapp/
├── templates
│   ├── 
│   ├── 
├── app.py
├── default_settings.py
│── requirements.txt
```

## Register your application in the Azure portal

The Microsoft identity platform performs identity and access management (IAM) only for registered applications. Follow these steps to register your application in the Azure portal: 

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, use the **Directories + subscriptions** filter :::image type="icon" source="../media/2-portal-directory-subscription-filter.png" border="false"::: at the right of the top menu to switch to the tenant where you want to register the application.
1. Search for and select **Azure Active Directory**.
1. On the left side bar, under **Manage**, select **App registrations**, then **New registration**. 
1. Enter a **Name** for your application, for example `python-flask-webapp`. Users of your application might see the display name when they use the app, for example during sign-in. You can change the display name at any time.
1. Under **Supported account types**, select **Accounts in this organizational directory only (Single tenant)**
1. Don't enter anything for Redirect URI (optional). You'll configure a redirect URI in the next section
1. Select **Register** to complete the initial app registration.

When registration finishes, the Azure portal displays the app registration's Overview pane. You see the automatically generated Application (client) ID.

## Add a redirect URI

To add a redirect URI for your Python Flask web app, follow these steps:

1. In the Azure portal, in **App registrations**, select your application.
2. Under **Manage**, select **Authentication**.
3. Under **Platform configurations**, select **Add a platform**.
4. Under **Configure platforms**, select **Web**.
5. Upon selecting web as your app's platform, you'll be prompted to enter a redirect URI. Add `http://localhost:5000/auth/redirect` as the redirect URI for your web app.  
6. Select **Configure**.

## Configure credentials

For this scenario, you'll use a client secret, also known as an application password. The client secret is a string value that an application can use to prove its identity when requesting a token. Follow these steps to add a client secret to your app registration:

1. In the Azure portal, in **App registrations**, select your application.
1. Under **Manage**, select **Certificates & secrets**.
1. In the **Client secrets** section, select **New client secret**.
1. Under **Add a client secret**, add a description for your client secret.
1. Select an expiration for the secret or specify a custom lifetime.
   Client secret lifetime is limited to two years (24 months) or less. You can't specify a custom lifetime longer than 24 months. Microsoft recommends that you set an expiration value of less than 12 months.
1. Select **Add**.
1. Record the client secret value (not its ID) for use in your application's code. This secret value is only shown once when you create it and never displayed after leaving this page.


## Add app roles to your web application

In this scenario, one route requires an application-defined app role that allows specific users to access customer profile data. To add this role, follow these steps:

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

After adding app roles to your application registration, you can assign users and groups to the roles. To assign users and groups to the created `admin role` using the Azure portal UI:

1. In the Azure portal, select Azure **Active Directory**. 
1. Under **Manage**, select **Enterprise applications**
1. Select **All applications** to view a list of all your applications. If your Python web app doesn't appear in the list, search using the application name or ID. You can also use the filters at the top of the **All applications** list to restrict the list, or scroll down the list to locate your application. 
1. Select the application you want to assign users or groups to roles. In this case, your Python web app.
1. Under **Manage**, select **Users and groups**.
1. Select **Add user/group** to open the **Add Assignment** pane.
1. Select the **Users and groups** selector from the **Add Assignment** pane. A list of users and security groups is displayed. You can search for a certain user or group as well as select multiple users and groups that appear in the list. For this tutorial, add *yourself* and select the **Select** button to proceed.
1. On the **Select a role** in the **Add assignment** pane, chose the `admin role` you previously created.
1. Select the **Assign button** to finish the assignment of users and groups to the app.
1. Confirm that the users and groups you added appear in the **Users and groups** list.

## Update the application to use your app registration details.

Open the `default_settings.py` file and add the three Azure Active Directory configuration properties using the values from your app's registration in the Azure portal.

```Python
# 'Application (client) ID' of app registration in Azure portal - this value is a GUID
CLIENT_ID = ""

# Client secret 'Value' (not its ID) from 'Client secrets' in app registration in Azure portal
CLIENT_CREDENTIAL = ""

# Full directory URL, in the form of https://login.microsoftonline.com/<tenant>
AUTHORITY = ""
```