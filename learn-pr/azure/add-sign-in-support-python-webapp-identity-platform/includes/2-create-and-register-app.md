The Microsoft identity platform performs identity and access management (IAM) only for registered applications. To securely authenticate and authorize users into your application using the identity platform, you start by registering your application in the Azure portal. 

## Create your Python Flask web application

To complete the rest of the module, you'll need to create a Python Flask web app project. If you prefer using a completed code sample for learning, download the [Python Flask web app sample]https://github.com/Azure-Samples/msid-add-authnz-python-webapp) from GitHub. 

If you prefer following the module and building the Python Flask web app by yourself, follow the steps below:

1. Create a folder to host your application and name it python-flask-webapp, for example.
1. Navigate to your project directory and create two files named app.py and default_settings.py.
1. At the end of the module, your project's file and directory structure should look similar to this.

```
python-webapp/
├── templates
│   ├── 
│   ├── 
├── app.py
├── default_settings.py
│── requirements.txt
```

## Install the authentication library

Install the MSAL for Python package. Open your terminal at the project directory and run the following command:
`pip install msal`

## Register your application in the Azure portal

Registering your application establishes a trust relationship between your application and the identity provider, the Microsoft identity platform. Follow these steps to create the app registration:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, use the **Directories + subscriptions** filter :::image type="icon" source="../media/2-portal-directory-subscription-filter.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application.
1. Search for and select **Azure Active Directory**.
1. Under **Manage**, select **App registrations** > **New registration**. 
1. Enter a **Name** for your application, for example `python-flask-webapp`. Users of your application might see the display name when they use the app, for example during sign-in. You can change the display name at any time and multiple app registrations can share the same name.
1. Under **Supported account types**, select **Accounts in this organizational directory only (Single tenant)**
1. Don't enter anything for Redirect URI (optional). You'll configure a redirect URI in the next section
1. Select **Register** to complete the initial app registration.

When registration finishes, the Azure portal displays the app registration's Overview pane. You see the automatically generated Application (client) ID, a value that uniquely identifies your application in the Microsoft identity platform.