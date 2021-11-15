The last step in setting up your application is to configure the connection from Azure Static Web Apps to Azure SQL Database. Once the applications settings are configured, you can see the functioning application.

Here, you'll configure the application settings, view the functioning application, and review the GitHub Action runs.

## Configure application settings for Azure Static Web Apps

In order for your Azure Static Web App to access your Azure SQL Database, you must configure an application setting that contains the Azure SQL Database connection string that works with the language you chose in and earlier exercise (.NET, Python, or Node.js).

1. In a text file, determine the connection string that you'll need to connect to your Azure SQL Database. The format should be as follows:

    ::: zone pivot="python"

    ```
    Driver={ODBC Driver 17 for SQL Server};Server=[serverName].database.windows.net,1433;Database=bus-db;UID=cloudadmin;PWD=[yourPassword];Connection Timeout=30;
    ```

    ::: zone-end

    ::: zone pivot="csharp"

    ```
    Server=tcp:[serverName].database.windows.net,1433;Database=bus-db;User ID=cloudadmin;Password=  [yourPassword];Encrypt=true;Connection Timeout=30;
    ```

    ::: zone-end

    ::: zone pivot="node"

    ```
    mssql://cloudadmin:[yourPassword]@[serverName].database.windows.net/bus-db?encrypt=true
    ```

    ::: zone-end

2. Navigate to your Azure Static Web App in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

3. From the *Overview* pane of your Azure Static Web App in the Azure portal, select **Configuration** under *Settings* on the left-hand menu.

4. Select **+ Add** and create a new setting named **AzureSQLConnectionString** with the value set to the connection string obtained in an earlier step.

5. Select **OK**.

6. Check the box next to the new application setting and select **Save**.

<!-- Not sure this is needed 
::: zone pivot="python"

1. Navigate to your GitHub repository in GitHub to the new workflow file that has been added under **serverless-full-stack-apps-azure-sql/.github/workflows**. It will be similar in name to `azure-static-web-apps-random-words&letters&numbers.yml`.

1. Select **Edit** to edit within the browser. 

1. Replace **ubuntu-latest** with **ubuntu-18.04** on *Line 15*.

1. Create a new line after *Line 20: `submodules: true` and add the following:

    ```yaml
    - name: Setup Python
    uses: actions/setup-python@v2
    with:
        python-version: '3.8.x'
    - name: Install dependencies
    run: |
        python -m pip install --target=".python_packages/lib/site-packages" -r requirements.txt
        echo "" > requirements.txt # blank out requirements.txt so it doesn't get installed again
    working-directory: 'azure-static-web-app/api/python'
    ```

1. Select **Start commit** > **Commit changes**.

1. In GitHub, navigate to **Actions** and confirm that the one titled *Azure Static Web Apps CI/CD* completes successfully.

::: zone-end
-->

## View the published application using Azure Static Web Apps

1. Navigate to your Azure Static Web App in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. From the *Overview* pane of your Azure Static Web App in the Azure portal, select the **URL**.

1. To view results for the specific bus route and geofence, add **`?rid=100113&gid=1`** to the end of the URL in the browser and refresh the page.

1. You should now see a geofence and several bus points. You may need to use the **+** or **-** buttons create a zoom fit. If you do not see any buses, change the URL from `gid=1` to `gid=2`.

> [!NOTE]
> For this module, a few bus points have been manually entered into your Azure SQL Database. If you completed the previous module of this learning path, you set up the Azure Function that runs on a timer trigger to pull down the latest real-time bus data and send notifications when buses enter or exit geofence. In the next module of the learning path, you can put both of these pieces together, which will enable your Azure Static Web App to include real-time data.

## Review deployment run history with GitHub Actions

1. Navigate to your Azure Static Web App in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. From the *Overview* pane of your Azure Static Web App in the Azure portal, select **GitHub Action runs** under *Deployment history*.

1. Review the *Azure Static Web Apps CI/CD* workflow run to understand how GitHub Actions are deploying and updating your application. If you make any changes to your application and push them to the repository, a new workflow will spin up to deploy the changes.
