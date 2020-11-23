Using the Azure portal, you can deploy a  Python [Django](https://www.djangoproject.com/) web app to [Azure App Service](/azure/app-service/overview#app-service-on-linux) and connect it to an [Azure Database for PostgreSQL](/azure/postgresql/) database. You can start with a free pricing tier that can be scaled up at any later time.

The web app code in this case comes from a GitHub repository, and you configure the web app for continuous deployment from GitHub. Once configured, you can do further development on your local computer and commit changes to the repository. The web app on Azure then deploys those changes automatically.

## Fork the sample repository

1. In a browser, navigate to [https://github.com/Azure-Samples/djangoapp](https://github.com/Azure-Samples/djangoapp) and fork the repository into your own GitHub account.

You create a fork of this repository so you can make changes and redeploy the code in a later step.

- Production settings are in the *azuresite/production.py* file. Development details are in *azuresite/settings.py*.

## Provision the web app in Azure

2. Open the portal
    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

3. Select **Create a resource**, which opens the **New** page.

4. Search for and select **Web App**.

5. On the **Create Web App** page, enter the following information:

    | Field | Value |
    | --- | --- |
    | Subscription | Select the subscription you want to use if different from the default. |
    | Resource group | Select **Create new** and enter "DjangoPostgres-Tutorial-rg". |
    | App name | A name for your web app that's unique across all Azure (the app's URL is `https://<app-name>.azurewebsites.net`). Allowed characters are `A`-`Z`, `0`-`9`, and `-`. A good pattern is to use a combination of your company name and an app identifier. |
    | Publish | Select **Code**. |
    | Runtime stack | Select **Python 3.8** from the drop-down list. |
    | Region | Select a location near you. |
    | Linux Plan | The portal will populate this field with an App Service Plan name based on your resource group. If you want to change the name, select **Create new**. |
    | Sku and size | For best performance, use the default plan, although it incurs charges in your subscription. To avoid charges, select **Change size**, then select **Dev/Test**, select **B1** (free for 30 days), then select **Apply**. You can scale the plan later for better performance. |

6. Select **Review + Create**, then select **Create**. Azure takes a few minutes to provision the web app.

7. After provisioning is complete, select **Go to resource** to open the overview page for the web app. Keep this browser window or tab open for later steps.

## Create the pollsdb database on the PostgreSQL server

In this section, you connect to the database server in the Azure Cloud Shell and use a PostgreSQL command to create a "pollsdb" database on the server. This database is expected by the sample app code.

1. From the overview page for the PostgreSQL server, select select **Connection security** (under **Settings** on the left side).

    ![Portal connection security page for firewall rules](../media/server-firewall-rules.png)

1. Select the button labeled **Add 0.0.0.0 - 255.255.255.255**, then select **Continue** in the pop up message that appears, followed by **Save** at the top of the page. These actions add a rule that allows you to connect to the database server from the Cloud Shell as well as SSH (as you do in a later section to run Django data model migrations).

1. Open the Azure Cloud Shell from the Azure portal by selecting the Cloud Shell icon at the top of the window:

    ![Cloud Shell button on the Azure portal toolbar](..media/portal-launch-icon.png)

1. In the Cloud Shell, run the following command:

   ```psql
   psql --host=payment-server-demo.postgres.database.azure.com --port=5432 --username=paymentadmin@payment-server-demo.postgres.database.azure.com --dbname=postgres
   ```
    Enter your administrator password when prompted.

1. When the shell connects successfully, you should see the prompt `postgres=>`. This prompt indicates that you're connected to the default administrative database named "postgres". (The "postgres" database isn't intended for app usage.)

## Connect the database

In this section, you create settings for the web app that it needs to connect to the `pollsdb` database. These settings appear to the app code as environment variables.

1. Switch back to the browser tab or window for the web app you created in a previous section.

1. Select **Configuration** (under **Settings** on the left side), then select **Application settings** at the top of the page.

    ![Portal settings configuration for web apps](../media/web-app-settings.png)

1. Use the **New application setting** button to create settings for each of the following values (which are expected by the djangoapp sample):

    | Setting name | Value |
    | --- | --- |
    | DBHOST | The name of the database server from the previous section; that is, the `<server-name>` portion of the server's URL that precedes `.postgres.database.azure.com`. (The code in *azuresite/production.py* constructs the full URL automatically.) |
    | DBNAME | `pollsdb` |
    | DBUSER | The administrator user name used when you provisioned the database. (The sample code automatically adds the `@<server-name>` portion; see *azuresite/production.py*.) |
    | DBPASS | The administrator password you created earlier. |

    As noted earlier, you should not use the `$` character in the username or password because that character is escaped within environment variables on the Linux container that hosts Python apps.

1. Select **Save** and then **Continue** to apply the settings.

    > [!IMPORTANT]
    > Selecting **Save** after making changes to settings is essential. Any settings you create with the **New application setting** button aren't applied until you use **Save**.

## Deploy app code to the web app from a repository

With the database and connection settings in place, you can now configure the web app to deploy code directly from a GitHub repository.

1. In the browser window or tab for the web app, select **Deployment Center** (under **Deployment** on the left side).

1. In the **Source Control** step, select **GitHub** and then **Authorize** (if necessary). Then follow the sign-in prompts or select **Continue** to use your current GitHub login.

1. In the **Build Provider** step, select **App Service build service**, then select **Continue**.

1. In the **Configure** step, select the following values:

    | Field | Value |
    | --- | --- |
    | Organization | The GitHub account to which you forked the sample repository. |
    | Repository | djangoapp |
    | Branch | master |

1. Select **Continue** to select the repository, then select **Finish**. Azure should deploy the code within a few seconds and start the app.

## Run Django database migrations

With the code deployed and the database in place, the app is almost ready to use. The only piece that remains is to establish the necessary schema in the database itself. You do this by "migrating" the data models in the Django app to the database.

1. In the browser window or tab for the web app, select **SSH** (under **Development Tools** on the left side), and then **Go** to open an SSH console on the web app server. It may take a minute to connect for the first time as the web app container needs to start.

1. In the console, change into the web app's folder:

    ```bash
    cd site/wwwroot
    ```

1. Activate the container's virtual environment:

    ```bash
    source /antenv/bin/activate
    ```

1. Install Python packages:

    ```bash
    pip install -r requirements.txt
    ```

1. Run database migrations:

    ```bash
    python manage.py migrate
    ```

1. Create an administrator login for the app:

    ```bash
    python manage.py createsuperuser
   ```

    The `createsuperuser` command prompts you for Django superuser (or admin) credentials, which are used within the web app. For the purposes of this tutorial, use the default username `root`, press **Enter** for the email address to leave it blank, and enter `Pollsdb1` for the password.

### Create a poll question in the app

You're now ready to run a quick test of the app to demonstrate that it is working with the PostgreSQL database.

1. In the browser window or tab for the web app, return to the **Overview** page, then select the **URL** for the web app (of the form `http://<app-name>.azurewebsites.net`).

1. The app should display the message "No polls are available" because there are no specific polls yet in the database.

1. Browse to `http://<app-name>.azurewebsites.net/admin` (the "Django Administration" page) and sign in using the superuser credentials from the previous section (`root` and `Pollsdb1`).

1. Under **Polls**, select **Add** next to **Questions** and create a poll question with some choices.

1. Browse again to `http://<app-name>.azurewebsites.net/` to confirm that the questions are now presented to the user. Answer questions however you like to generate some data in the database.

**Congratulations!** You're running a Python Django web app in Azure App Service for Linux, with an active PostgreSQL database.

## Update the app and redeploy

As described earlier in this tutorial, Azure redeploys your app code whenever you commit changes to the GitHub repository.

If you change the Django app's data models, however, you must migrate those changes to the database:

1. Connect to the web app again via SSH as described under [Run Django database migrations](#run-django-database-migrations).

1. Change into the app folder with `cd site/wwwroot`.

1. Activate the virtual environment with `source /antenv/bin/activate`.

1. Run the migrations again with `python manage.py migrate`.

## View diagnostic logs

You can access the console logs generated from inside the container that hosts the app on Azure.

On the web app's page in the Azure portal, select **Log stream** (under **Monitoring** on the left side). The logs appear as console output.

You can also inspect the log files from the browser at `https://<app-name>.scm.azurewebsites.net/api/logs/docker`.
