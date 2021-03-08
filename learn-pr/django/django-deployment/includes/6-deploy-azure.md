This module requires a sandbox to complete. A sandbox gives you access to free resources. Your personal subscription will not be charged. The sandbox may only be used to complete training on Microsoft Learn. Use for any other reason is prohibited, and may result in permanent loss of access to the sandbox.

To make our site available to the public, we are going to deploy it to Azure. We will use the Azure App Service extension in Visual Studio Code to streamline the process.

## Install the Azure App Service extension

We will start by installing the extension into Visual Studio Code.

1. Inside **Visual Studio Code**, click the **Extensions** icon.

    ![Extensions icon](media/extensions-icon.png)

1. In the **Search Extensions** dialog, type **App Services**.
1. Under **Azure App Service**, click **Install**.

The extension will install.

## Deploy the application

With our extension installed, let's perform the installation.

1. Inside **Visual Studio Code**, click the **Azure** icon on the toolbar.

    ![Azure icon](media/azure-icon.png)

1. Click **Sign in** to sign into Azure using the same account you used to create the sandbox.
1. On the **App Service** bar, click the **Deploy** icon.

    ![App service bar with deploy icon highlighted](media/app-service.png)

1. On **Select subscription**, choose your Azure subscription.

    ![Subscription list](media/select-subscription.png)

1. Select **Create new Web App**.

    ![Create new web app](media/create-new-webapp.png)

1. Provide a unique name for your application.

    ![Provide a name](media/provide-name.png)

1. Select **Python 3.8** as the runtime stack.

    ![Runtime stack selection screen](media/runtime-selection.png)

    The extension will now create your web application and begin deploying your application. This will take a few moments.

1. Select **Yes** prompted to **Always deploy the workspace** to the application you created during the deployment.

    ![Deployment configuration option](media/always-deploy.png)

Your site will now deploy!

## Creating the database

While your site is deploying we can turn our attention to creating the database. As mentioned earlier, we will be using PostgreSQL.

1. On the **Databases** extension click **Create server...**.

    ![Screenshot of databases extension with create server highlighted](media/databases.png)

1. In the dialog, select the sandbox subscription.

    ![Subscription list](media/select-subscription.png)

1. For the Azure Database Server, select **PostgreSQL**.

    ![List of available database servers](media/database-server.png)

1. Provide a unique name for your database server and press <kbd>Enter</kbd>.

    > [!IMPORTANT]
    > Make a note of the name you use for your database server.

1. Enter **shelter_admin** for the name of the admin user and press <kbd>Enter</kbd>.
1. Provide a secure password, such as **86i*^z5#emSk6wu3t10nC**, and press <kbd>Enter</kbd>.

    > [!IMPORTANT]
    > When creating the password, do not use an `$` as it can cause issues when connecting from Python. Make a note of the password you use.

1. Enter the password a second time to confirm it, and press <kbd>Enter</kbd>.
1. For the firewall rule, select **Skip for now**.

    ![Firewall rule dialog with skip for now highlighted](media/firewall-rule.png)

1. For the Resource Group, select **appsvc_linux_centralus**, which was created when you deployed your web application.

    ![Select resource group with appsvc_linux_centralus selected](media/resource-group.png)

1. For the location for new resources, select **Central US**.

    ![Resource location with Central US highlighted](media/region.png)

    > [!IMPORTANT]
    > When creating multiple Azure resources which will communicate with one another you should always place them in the same region. This ensures the best performance.

Your server will now be created! This will take a few minutes.

## Configure application settings

While your database server is being created we can configure the App Service we setup earlier. The application settings are used by App Services to configure environmental variables, and are a convenient way to store information we don't want to put into our code, such as database connection strings.

1. Under **App Service**, expand the sandbox subscription, and then your application
1. To create the first Application Setting, right click on **Application Settings** and click **Add New Setting**

    ![Add new setting dialog](media/add-setting.png)

1. In the first dialog, provide the name **DBUSER** and press <kbd>Enter</kbd>.
1. In the second dialog, provide the value **shelter_admin** and press <kbd>Enter</kbd>.
1. Repeat the above steps to create the remaining settings.

    Name       | Value
    -----------|---------------------------------------
    DBHOST     | `<The server name you created above>`
    DBPASS     | `<The password you created above>`
    DBNAME     | `shelters`
    SECRET_KEY | `<Generate a secure password>`

    > [!NOTE]
    > Replace the **DBHOST** and **DBPASS** values with the ones you created earlier in this exercise. For **SECRET_KEY** you will need to create a new password.

All the necessary environmental variables are now created on your App Service.

## Create the database

With our App Service configured, and our server now created, we can create our database.

1. Under **Databases**, expand the sandbox subscription.
1. Right click on the name of your database server and click **Create Database**.

    ![Database server dialog with Create Database highlighted](media/create-database.png)

1. Enter the name **shelters** into the dialog and press <kbd>Enter</kbd>.

Your database will be created!

## Create the schema and superuser

The last step to our deployment is to setup the database. When doing local development, you run **python manage.py migrate** and **python manage.py createsuperuser** to create the database schema and superuser. We do the exact same thing on Azure! We need to connect to our web server in Azure using Secure Shell (SSH), which can do by using Visual Studio Code.

1. Inside the **App Service** extension, **right click** your App Service and select **SSH into Web App**.

    ![Screenshot of menu for SSH](media/ssh.png)

    An SSH connection will now be made to your web server on Azure. This may take a few minutes. A terminal window will appear inside Visual Studio Code, which is your SSH connection into your web server.

    > [!IMPORTANT]
    > If you receive an error message stating you need to enable SSL for the database, ensure all environmental variables were created correctly.

1. Inside the SSH terminal window, execute the following commands to ensure the appropriate libraries are installed and create the database:

    ```bash
    # Change to the app folder
    cd $APP_PATH
    # Activate the venv
    source /antenv/bin/activate
    # Install requirements
    pip install -r requirements.txt
    # Run database migrations
    python manage.py migrate
    ```

1. Create your superuser by executing the following command:

    ```bash
    python manage.py createsuperuser
    ```

1. Provide a **name**, **email** and **password** for the superuser.
1. After creating your superuser, enter the command `exit` to close the connection.

Your database is configured in Azure, and you have a superuser for your site.

## Browse to your site

With everything deployed and configured, we can now view our website on Azure.

Right click on the name of your site inside the **App Service** extension and click **Browse Website**.

![Screenshot of the browse website dialog](media/browse-website.png)

Your website now appears

Because we deployed our SQLite database, you should notice your site already contains data. If you navigate to location which doesn't exist on your site you will notice you receive a generic **Not found** error because `DEBUG` is disabled.

You have now deployed a website to Azure!
