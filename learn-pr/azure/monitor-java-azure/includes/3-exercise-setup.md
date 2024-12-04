In this exercise, you'll configure a sample application to be ready for monitoring. Later, you'll access the collected monitoring data and view it in the Azure portal.

## Introduction

In this exercise, you'll clone a Git repository and run a script that sets up an Azure Spring Apps application and Azure Database for MySQL. The script deploys a well-known PetClinic microservice application and is built around small independent services, communicating over HTTP via a REST API.

## The sample microservice application

The PetClinic application is decomposed into four core microservices. All of them are independently deployable applications organized by business domains.

- **Customers service**: Contains general user input logic and validation including pets and owners information (Name, Address, City, Telephone).
- **Visits service**: Stores and shows visits information for each pet's comments.
- **Vets service**: Stores and shows Veterinarians' information, including names and specialties.
- **API Gateway**: A single entry point into the system, used to handle requests and route them to an appropriate service, and aggregate the results.

## Set up the sample microservice application

1. In a web browser, open https://shell.azure.com in a new window.

1. Select **Bash** mode in the top right-hand side.
1. In the Cloud Shell window on the right side of the screen, select **Settings** > **Go to Classic version**.

1. Next, run the following commands to clone the sample repository and open the built-in Azure editor:

   ```bash
   git clone https://github.com/MicrosoftDocs/mslearn-monitoring-java
   cd mslearn-monitoring-java
   code deployPetClinicApp.sh
   ```

## Set up and run the Setup script

When you run the preceding command, a window pops up with the file `deployPetClinicApp.sh` ready to be edited in the built-in Azure editor.

1. At the top of the `deployPetClinicApp.sh` file, edit the following variables to customize the scripts parameters for your environment. For all resource names, use lowercase letters. You can also use hyphens and numbers.

   | Variable | Description |
   |-|-|
   | resource_group | Provide a new or existing resource group name. |
   | region | The Azure region you'll use. You can use `westeurope` by default, but we recommend that you use a region close to where you live and that also supports Azure Spring Apps. To see the full list of available regions, visit [Azure Spring Apps Availability by Region](https://azure.microsoft.com/global-infrastructure/services/?products=spring-apps). |
   | spring_apps_service | Name of your Azure Spring Apps instance. |
   | mysql_server_name | The name of your MySQL server. It should be unique across Azure. |
   | mysql_server_admin_name | Username for the MySQL Administrator. The admin name can't be "azure-superuser", "admin", "administrator", "root", "guest, or "public". |
   | mysql_server_admin_password | A new password for the server admin user. The password must be 8 to 128 characters long and contain a combination of uppercase or lowercase letters, numbers, and non-alphanumeric characters (!, $, #, %, and so on).|
   | log_analytics | Name of your Azure Log Analytics workspace. |

2. Save the file by selecting the **...** in the top-right of the editor and selecting **Save**. You can also press **Ctrl + S**.

3. Close the editor by selecting the **...** in the top-right of the editor and selecting **Close Editor**. You can also press **Ctrl + Q**.

4. Don't close the Azure Cloud Shell, because we'll run the setup script next.

## Run the setup script

The script takes 30-45 minutes to run and includes the creation of an Azure spring Apps and a MySQL instance. This sample script also populates sample data for the monitoring logs, traces, and metrics.

In the already open Azure Cloud Shell, run the following shell script. Leave the browser window and Azure Cloud Shell open while running. Store the URL when the script completes.

```bash
bash deployPetClinicApp.sh
```

> [!IMPORTANT]
> If you run into errors with the setup script, the script will attempt to delete any resources it creates.
> You can then try again once the resource group is fully deleted.
> The Summary unit also has instructions on how to delete your resources manually.

## Test the application

Next, we'll verify your environment via the Azure portal.

1. Open the Azure portal.

1. Select **Azure Spring Apps** from the list of Azure services.

1. Select your Azure Spring Apps instance.

1. On the right-hand side, select **Apps** under **Settings**.

1. Verify all the applications are running and registered, as in the following screenshot:

   :::image type="content" source="../media/3-app-selection.jpg" alt-text="Screenshot showing applications under your spring apps." lightbox="../media/3-app-selection.jpg":::

1. On the left-hand side, select the **api-gateway** application.

1. The URL for your application is listed on the left-hand side properties in the **URL** field.

   :::image type="content" source="../media/3-gateway-url.jpg" alt-text="Screenshot showing the Spring gateway url." lightbox="../media/3-gateway-url.jpg":::

1. In a web browser, navigate toy our api-gateway URL to open the Pet Clinic microservice application.

1. Next, navigate to the **Owners** tab and select **Find all owners**.

1. Confirm your sample application is up and running, populated with data, and now ready for you to explore.

:::image type="content" source="../media/4-petclinic.jpg" alt-text="Screenshot of your Spring application." lightbox="../media/4-petclinic.jpg":::
