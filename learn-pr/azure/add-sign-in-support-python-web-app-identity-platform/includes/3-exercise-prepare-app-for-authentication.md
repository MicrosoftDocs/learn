In this exercise, you create the presentation layer of your Python Flask web application and complete the following application-specific configurations on the Azure portal:

- Add a redirect URI
- Configure client credentials
- Add app roles to your application registration
- Assign app roles to users and groups

## Create your Python Flask web application

To complete the rest of the module, you'll need to create a Python Flask web app project. If you prefer using a completed code sample for learning, download the [Python Flask web app sample](https://github.com/Azure-Samples/msid-add-authnz-python-webapp) from GitHub. 

Alternatively, you can build the Python Flask web app from scratch by following the steps below:

1. Create a folder to host your application and name it *python-flask-webapp*.
1. Navigate to your project directory and create three files named *app.py*, *default_settings.py*, and *requirements.txt*
1. In your project root directory, create a folder named *templates*. Flask will look for rendering templates in this subdirectory. 
1. At the end of the module, your project's file and directory structure should look similar to this:

```md
python-webapp/
├── templates/
│     ├── authenticated/
│     │     ├── admin.html
│     │     ├── graph.html
│     ├── public/
│     │     ├── index.html
│     ├── layout.html
├── app.py
├── default_settings.py
│── requirements.txt
```

#### Install dependencies

For the sample app in this module, you'll use Flask and the Microsoft Authentication Library (MSAL) for Python. Update *requirements.txt* with these dependencies.

```python
# Flask
Flask~=2.0.2
Flask-Session~=0.4.0

# Microsoft Authentication Library for Python
msal==1.17.0

# Environment variable parsing
environs~=9.3.5
```

To make these dependencies available in your environment, run `pip install -r requirements.txt` from your project directory.

#### Add application UI components

Flask uses the helper function `render_template()` for rendering HTML templates containing both static and dynamic content. For this module, you'll create a general design template that's reused across all pages. You'll also add three HTML templates for each of the routes that will be set up in the app. Follow the steps below to create the templates for your app's user interface: 

1. For the general template, create an HTML file named *layout.html* in the templates folder and paste the contents below: 

    ```html
    
    <!-- Purpose: General template that's used across all pages. Other templates will inherit this design. --> 
    <!-- Path: <project-root>/templates/layout.html -->
    
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="utf-8" />
        <title>{% block page_title %}{% endblock %} - Python Flask</title>
        {% block css %}{% endblock %}
      </head>
      <body>
        {% block body %}
        
        <h1> Authentication and authorization in Python Flask web app using the Microsoft identity platform </h1>
    
        <main role="main">
          {% block content %}{% endblock %}
        </main>
    
        {% block js %}{% endblock %}
    
        {% endblock %}    
      </body>
    </html>
    ```
2. Next, create a new folder in *templates* and name it *public*. Then add an *index.html* template to the *public* folder. Your app will render this template when serving the page that all users, authenticated or not, can access. Paste the contents below into the *index.html* template.

    ```html
    <!-- Purpose: Template rendered when any user, authenticated or not, accesses the app --> 
    <!-- Path: <project-root>/templates/authenticated/index.html -->
    
    {% extends "layout.html" %}
    {% block page_title %}Home{% endblock %}
    {% block content %}
        <div>This page can be accessed by all users, authenticated or not.</div>
        <div>
          <p>The following links will all require you to sign into the application before they can be used. Navigating to them while not logged in will automatically initiate the login process.</p>
          <ul>
            <li><a href="/graph">This link</a> doesn't require that your user has any specific application roles assigned, and will access Microsoft Graph on your behalf.</li>
            <li><a href="/admin">This link</a> requires that your user has the application-defined, <code>admin</code> role assigned.</li>
          </ul>
        </div>
    {% endblock %}
    ```

3. Move into the *templates* folder and create a new folder named *authenticated* where you'll add two templates that your app will render when users sign in. 

4. In the  *authenticated* folder, add the first template, *graph.html*, which will render when all users sign in. Paste the following contents into this template:
    
    ```html
    <!-- Purpose: Template rendered when any user signs in. --> 
    <!-- Path: <project-root>/templates/authenticated/graph.html -->
    
    {% extends "layout.html" %}
    {% block page_title %}Graph Access{% endblock %}
    
    {% block css %}
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.25.0/themes/prism.min.css" integrity="sha512-tN7Ec6zAFaVSG3TpNAKtk4DOHNpSwKHxxrsiw4GHKESGPs5njn/0sMCUMl2svV4wo4BK/rCP7juYz+zx+l6oeQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    {% endblock %}
    
    {% block content %}
    <div>This page can be accessed by only logged-in users.</div>
    <div>
      <p>Before rendering the page, the controller was able to make a call to Microsoft Graph's <code>/me</code> API for your user and received the following:</p>
      <p><pre><code class="language-js">{{ graphCallResponse | tojson(indent=2) }}</code></pre></p>
      <p>Refreshing this page will continue to use the cached access token acquired for Microsoft Graph, which is valid for another {{ graphAccessTokenExpiresInSeconds }} second(s) and future page views will attempt to refresh this token as it nears its expiration.</p>
    </div>
    <div>
      <p>The following links will all require you to sign into the application before they can be used. Navigating to them while not logged in will automatically initiate the login process.</p>
      <ul>
        <li><a href="/graph">This link</a> doesn't require that your user has any specific application roles assigned, and will access Microsoft Graph on your behalf. <em>(That's this page.)</em></li>
        <li><a href="/admin">This link</a> requires that your user has the application-defined, <code>admin</code> role assigned.</li>
      </ul>
    </div>
    <div>
      <p><a href="/">Return to home.</a></p>
    </div>
    {% endblock %}
    
    {% block js %}
    <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.25.0/prism.min.js" integrity="sha512-hpZ5pDCF2bRCweL5WoA0/N1elet1KYL5mx3LP555Eg/0ZguaHawxNvEjF6O3rufAChs16HVNhEc6blF/rZoowQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    {% endblock %}
    ```

5. In the *authenticated* folder, add a second template named *admin.html*. Your app will render this template when users with an application-defined role sign-in. In our insurance company web application scenario, the admin role would represent a company employee with privileges to access specific customer data. Paste the following contents into the *admin.html* template:

    ```html
    <!-- Purpose: Template rendered when a user with an application-defined role signs in. --> 
    <!-- Path: <project-root>/templates/authenticated/admin.html -->
    
    {% extends "layout.html" %}
    {% block page_title %}Graph Access as Admin{% endblock %}
    
    {% block css %}
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.25.0/themes/prism.min.css" integrity="sha512-tN7Ec6zAFaVSG3TpNAKtk4DOHNpSwKHxxrsiw4GHKESGPs5njn/0sMCUMl2svV4wo4BK/rCP7juYz+zx+l6oeQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    {% endblock %}
    
    {% block content %}
    <div>This page can be accessed by only logged-in users that have the <strong>admin</strong> role assigned.</div>
    <div>
      <p>This is based on the <strong>roles</strong> in your id token stored in your user session.</p>
      <p><pre><code class="language-js">{{ graphCallResponse | tojson(indent=2) }}</code></pre></p>
    </div>
    <div>
      <p>The following links will all require you to sign into the application before they can be used. Navigating to them while not logged in will automatically initiate the login process.</p>
      <ul>
        <li><a href="/graph">This link</a> doesn't require that your user has any specific application roles assigned, and will access Microsoft Graph on your behalf.</li>
        <li><a href="/admin">This link</a> requires that your user has the application-defined, <code>admin</code> role assigned. <em>(That's this page.)</em></li>
      </ul>
    </div>
    <div>
      <p><a href="/">Return to home.</a></p>
    </div>
    {% endblock %}
    
    {% block js %}
    <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.25.0/prism.min.js" integrity="sha512-hpZ5pDCF2bRCweL5WoA0/N1elet1KYL5mx3LP555Eg/0ZguaHawxNvEjF6O3rufAChs16HVNhEc6blF/rZoowQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    {% endblock %}
    
    ```

6. You're now done creating the presentation layer for your Flask web application. Your final *templates* folder should look like this:

    ```text
    # 📁 templates
      ├── authenticated
      │     ├── admin.html
      │     ├── graph.html
      ├── public
      │     ├── index.html
      ├── layout.html
    ```

## Register your application in the Azure portal

The Microsoft identity platform performs identity and access management (IAM) only for registered applications. Follow these steps to register your application in the Azure portal: 

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, use the **Directories + subscriptions** filter :::image type="icon" source="../media/2-portal-directory-subscription-filter.png" border="false"::: at the right of the top menu to switch to the tenant where you want to register the application.
1. Search for and select **Azure Active Directory**.
1. On the left side bar, under **Manage**, select **App registrations**, then **New registration**. 
1. Enter a **Name** for your application, for example *python-flask-webapp*. Users of your application might see the display name when they use the app, for example during sign-in. You can change the display name at any time.
1. Under **Supported account types**, select **Accounts in any organizational directory(Any Azure AD directory Multitenant)**
1. Ignore the **Redirect URI (optional)** for now. You'll configure it in the next section
1. Select **Register** to complete the initial app registration.

When registration finishes, the Azure portal displays the app registration's **Overview** pane. You see the automatically generated **Application (client) ID**.

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
1. In the **Add a client secret** pane, provide a description for your client secret.
1. Select an expiration for the secret or specify a custom lifetime.
   - Client secret lifetime is limited to two years (24 months) or less. You can't specify a custom lifetime longer than 24 months. Microsoft recommends that you set an expiration value of less than 12 months.
1. Select **Add**.
1. Record the client secret value (not its ID) for use in a later step. This secret value is only shown once when you create it and never displayed after leaving this page.

## Add app roles to your web application

In this scenario, one route requires an application-defined app role that allows specific users to access customer profile data. To add this role, follow these steps:

1. In the Azure portal, in **App registrations**, select your application.
1. Under **Manage**, select **App roles** and then **Create app role**.
1. In the **Create app role** pane, enter the settings for the role.
    - For the **Display name**, enter **admin**.
    - For **Allowed member types:**, select **Users/Groups**.
    - For **Value**, enter **admin**.
    - For **Description**, add a more detailed app role description such as **admin app role**.
1. Select the checkbox under **Do you want to enable this app role?**
1. Select **Apply** to complete creating the app role.

## Assign app roles to users and groups

After adding app roles to your application registration, you can assign users and groups to the roles. To assign users and groups to the created `admin role` using the Azure portal UI:

1. In the Azure portal, select **Azure Active Directory**. 
1. Under **Manage**, select **Enterprise applications**.
1. Select **All applications** to view a list of all your applications. If your Python web app doesn't appear in the list, search using the application name or ID. You can also use the filters at the top of the **All applications** list to restrict the list, or scroll down the list to locate your application. 
1. Select the application you want to assign users or groups to roles. In this case, your Python web app.
1. Under **Manage**, select **Users and groups**.
1. Select **Add user/group** to open the **Add Assignment** pane.
1. Select the **Users and groups** selector from the **Add Assignment** pane. A list of users and security groups is displayed. You can search for a certain user or group as well as select multiple users and groups that appear in the list. For this tutorial, add *yourself* and select the **Select** button to proceed.
1. In the **Add assignment** pane, you'll also choose a role to assign the selected users. In this case, the *admin role* is already selected by default. If you added several roles to the application, you'll have the option to choose the role you want.
1. Select the **Assign button** to finish the assignment of users and groups to the app.
1. Confirm that the users and groups you added appear in the **Users and groups** list.