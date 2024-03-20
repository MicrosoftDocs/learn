An SAP Basis Admin wants to view and manage SAP systems using Virtual Instance for SAP (VIS) solutions resources. A developer wants to start and stop SAP systems in Azure Center for SAP solutions (ACSS) to control instances through the VIS resource.

A supplemental option for this lesson is the interactive guide, [Manage SAP workloads](https://mslearn.cloudguides.com/guides/Azure%20Center%20for%20SAP%20solutions%20-%20Manage%20SAP%20workloads)to simulate the ACSS SAP system registration experience in the U.S. version of the Azure portal (currently English only).

## Open VIS in the portal

To configure your VIS in the Azure portal:

1. Open the [Azure portal](https://portal.azure.com) in a browser.
1. Sign in with your Azure account that has the necessary role access.
1. In the search field in the navigation menu, enter and select **Azure Center for SAP solutions**.
1. On the **Azure Center for SAP solutions** overview page, search for and select **Virtual Instances for SAP solutions** in the sidebar menu.
1. On the **Virtual Instances for SAP solutions** page, select the VIS that you want to view.

    :::image type="content" source="../media/select-virtual-instance-sap.png" lightbox="../media/select-virtual-instance-sap.png" alt-text="Screenshot of Azure portal, showing the V I S page in the Azure Center for S A P solutions service with a table of available V I S resources.":::

> [!IMPORTANT]
> Each VIS resource has a unique Managed Resource Group associated with it. This Resource Group contains resources like Storage Account, Key Vault, etc. which are critical for ACSS to provide capabilities like deployment of infrastructure for a new system, installation of SAP software, registration of existing systems, and all other SAP system management functions. Don't delete this Resource Group or any resources within it. If they are deleted, you'll have to re-register the VIS to use any capabilities of ACSS.

## Monitor VIS

To see infrastructure-based metrics for the VIS, open the VIS in the Azure portal. On the **Overview** pane, select the **Monitoring** tab. You can see the following metrics:

- VM utilization by ASCS and Application Server instances. The graph shows CPU usage percentage for all VMs that support the ASCS and Application Server instances.
- VM utilization by the database instance. The graph shows CPU usage percentage for all VMs that support the database instance.
- IOPS consumed by the database instance's data disk. The graph shows the percentage of disk utilization by all VMs that support the database instance.

## View instance properties

1. To view properties for the instances within your VIS, first open the VIS in the Azure portal.
1. In the sidebar menu, look under the section **SAP resources**:

    - To see properties of ASCS instances, select **Central service instances**.
    - To see properties of application server instances, select **App server instances**.
    - To see properties of database instances, select **Databases**.

:::image type="content" source="../media/sap-resources.png" lightbox="../media/sap-resources.png" alt-text="Screenshot of V I S resource in Azure portal, showing S A P resources pages in the sidebar menu for A S C S, App server, and Database instances.":::

## Default instance numbers

If you've deployed an SAP system using Azure Center for SAP solutions, the following list shows the default values of instance numbers configured during deployment:

- Distributed Systems [HA and non-HA systems]

  - ASCS Instance Number - 00
  - ERS Instance Number - 01
  - DB Instance Number - 00
  - APP Instance Number - 00

- Single Server Systems

  - ASCS Instance Number - 01
  - DB Instance Number - 00

- APP Instance Number - 02

## Connect to SAP Application

To connect to and manage SAP Application, you can use the following credentials:

- User: DDIC or RFC_USER or SAP*
- Client ID: 000

## Connect to HANA database

If you've deployed an SAP system using Azure Center for SAP solutions, find the SAP system's main password and HANA database passwords.

The HANA database username is either `system` or `SYSTEM` for:

- Distributed High Availability (HA) SAP systems
- Distributed non-HA systems
- Standalone systems

### Find SAP and HANA passwords

To retrieve the password:

1. Open the VIS in the Azure portal.
1. On the overview page, select the **Managed resource group**.

    :::image type="content" source="../media/select-managed-resource-group.png" lightbox="../media/select-managed-resource-group.png" alt-text="Screenshot of V I S resource in the Azure portal, showing selection of managed resource group on the overview page.":::

1. On the resource group's page, select the **Key vault** resource in the table.

    :::image type="content" source="../media/select-key-vault.png" lightbox="../media/select-key-vault.png" alt-text="Screenshot of managed resource group in the Azure portal, showing the selection of the key vault on the overview page.":::

1. On the key vault's page, select **Secrets** in the navigation menu under **Settings**.
1. Make sure that you have access to all the secrets. If you have correct permissions, you can see the SAP password file listed in the table, which hosts the global password for your SAP system.
1. Select the SAP password file name to open the secret's page.
1. Copy the **Secret value**.

If you get the warning **The operation 'List' is not enabled in this key vault's access policy** with the message **You are unauthorized to view these contents**, follow these steps:

1. Make sure that you're responsible to manage these secrets in your organization.
1. In the sidebar menu, under **Settings**, select **Access policies**.
1. On the access policies page for the key vault, select **+ Add Access Policy**.
1. In the pane **Add access policy**, configure the following settings:

    1. For **Configure from template (optional)**, select **Key, Secret, & Certificate Management**.
    1. For **Key permissions**, select the keys that you want to use.
    1. For **Secret permissions**, select the secrets that you want to use.
    1. For **Certificate permissions**, select the certificates that you want to use.
    1. For **Select principal**, assign your own account name.

1. Select **Add** to add the policy.
1. In the access policy's menu, select **Save** to save your settings.
1. In the sidebar menu, under **Settings**, select **Secrets**.
1. On the secrets page for the key vault, make sure you can now see the SAP password file.

### Stop SAP system

The following scenarios are supported when starting and stopping SAP systems:

- SAP systems that run on Windows and, RHEL and SUSE Linux operating systems.
- Stopping and starting SAP system or individual instances from the VIS resource only stops or starts the SAP application. The underlying VMs are **not** stopped or started.
- Stopping a highly available SAP system from the VIS resource gracefully stops the SAP instances in the right order and doesn't result in a failover of Central Services instance.
- Stopping the HANA database from the VIS resource results in the entire HANA instance to be stopped. If there's HANA MDC with multiple tenant DBs, the entire instance is stopped and not the specific Tenant DB.
- For highly available (HA) HANA databases, start and stop operations through the VIS resource are supported only when cluster management solution is in place. Any other HANA database HA configurations without a cluster aren't currently supported when starting and stopping using the VIS resource.

To stop an SAP system in the VIS resource:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Search for and select **Azure Center for SAP solutions** in the search bar.
1. Select **Virtual Instances for SAP solutions** in the sidebar menu.
1. In the table of VIS resources, select the name of the VIS you want to stop.
1. Select the **Stop** button. If you can't select this button, the SAP system already isn't running.

    :::image type="content" source="../media/stop-button.png" lightbox="../media/stop-button.png" alt-text="Screenshot of the V I S resource menu in the Azure portal, showing the Stop button.":::

1. Select **Yes** in the confirmation prompt to stop the VIS.

    :::image type="content" source="../media/confirm-stop.png" lightbox="../media/confirm-stop.png" alt-text="Screenshot of the V I S resource menu in the Azure portal, showing the confirmation prompt to stop the V I S resource.":::

    A notification pane then opens with a **Stopping Virtual Instance for SAP solutions** message.

1. Wait for the VIS resource's **Status** to change to **Stopping**.

    A notification pane then opens with a **Stopped Virtual Instance for SAP solutions** message.

### Start SAP system

To start an SAP system in the VIS resource:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Search for and select **Azure Center for SAP solutions** in the search bar.
1. Select **Virtual Instances for SAP solutions** in the sidebar menu.
1. In the table of VIS resources, select the name of the VIS you want to start.
1. Select the **Start** button. If you can't select this button, make sure that you've followed the prerequisites for the VMs within your SAP system.

    :::image type="content" source="../media/start-button.png" lightbox="../media/start-button.png" alt-text="Screenshot of the V I S resource menu in the Azure portal, showing the Start button.":::

    A notification pane then opens with a **Starting Virtual Instance for SAP solutions** message. The VIS resource's **Status** also changes to **Starting**.

1. Wait for the VIS resource's **Status** to change to **Running**.

    A notification pane then opens with a **Started Virtual Instance for SAP solutions** message.

>[!NOTE]
>If the SAP system takes longer than 300 seconds to complete a start or stop operation, the operation terminates. After the operation terminates, the monitoring service continues to check and update the status of the SAP system in the VIS resource.

## Check health and status

As developer wants to set up monitoring for a Virtual Instance for SAP solutions to monitor the health and status of SAP system in Azure Center for SAP solutions.

### Check basic health and status settings

1. Sign in to the [Azure portal](https://portal.azure.com).
1. In the search bar, enter `SAP on Azure`, then select **Azure Center for SAP solutions** in the results.
1. On the service's page, select **Virtual Instances for SAP solutions** in the sidebar menu.
1. On the page for the VIS, review the table of instances. There's an overview of health and status information for each VIS.

    :::image type="content" source="../media/all-virtual-instance-sap-statuses.png" lightbox="../media/all-virtual-instance-sap-statuses.png" alt-text="Screenshot of the A C S S service in the Azure portal, showing a page of all V I S resources with their health and status information.":::

1. Select the VIS you want to check.
1. On the **Overview** page for the VIS resource, select the **Properties** tab.

    :::image type="content" source="../media/virtual-instance-sap-overview.png" lightbox="../media/virtual-instance-sap-overview.png" alt-text="Screenshot of the V I S resource overview in the Azure portal, showing health and status information and the Properties tab highlighted.":::

1. On the properties page for the VIS, review the **SAP status** section to see the health of SAP instances. Review the **Virtual machines** section to see the health of VMs inside the VIS.

    :::image type="content" source="../media/properties-tab.png" lightbox="../media/properties-tab.png" alt-text="Screenshot of the Properties tab for the V I S resource overview, showing the S A P status and Virtual machines details.":::

### See information about ASCS instances

1. Open the VIS in the Azure portal, as previously described.
1. In the sidebar menu, under **SAP resources**, select **Central service instances**.
1. Select an instance from the table to see its properties.

    :::image type="content" source="../media/central-services-virtual-machine-details.png" lightbox="../media/central-services-virtual-machine-details.png" alt-text="Screenshot of an A S C S instance in the Azure portal, showing health and status information for the V M.":::

### See information about SAP application server instances

1. Open the VIS in the Azure portal, as previously described.
1. In the sidebar menu, under **SAP resources**, select **App server instances**.
1. Select an instance from the table to see its properties.

    :::image type="content" source="../media/app-server-virtual-machine-details.png" lightbox="../media/app-server-virtual-machine-details.png" alt-text="Screenshot of an Application Server instance in the Azure portal, showing health and status information for the V M.":::

## Monitor SAP infrastructure

Azure Center for SAP solutions enables you to analyze important SAP infrastructure metrics from the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. In the search bar, enter `SAP on Azure`, then select **Azure Center for SAP solutions** in the results.
1. On the service's page, select **SAP Virtual Instances** in the sidebar menu.
1. On the page for the VIS, select the VIS from the table.
1. On the overview page for the VIS, select the **Monitoring** tab.

    :::image type="content" source="../media/monitor-virtual-instance-sap-overview.png" lightbox="../media/monitor-virtual-instance-sap-overview.png" alt-text="Screenshot of the Monitoring tab for a V I S resource in the Azure portal, showing monitoring charts for C P U utilization and I O P S.":::

1. Review the monitoring charts, which include:

    - CPU utilization by the Application server and ASCS server
    - IOPS percentage consumed by the Database server instance
    - CPU utilization by the Database server instance

1. Select any of the monitoring charts to do more in-depth analysis with Azure Monitor metrics explorer.

## Configure Azure Monitor

You can also set up or register Azure Monitor for SAP solutions to monitor SAP platform-level metrics:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. In the search bar, enter `SAP on Azure`, then select **Azure Center for SAP solutions** in the results.
1. On the service's page, select **SAP Virtual Instances** in the sidebar menu.
1. On the page for the VIS, select the VIS from the table.
1. In the sidebar menu for the VIS, under **Monitoring**, select **Azure Monitor for SAP solutions**.
1. Select whether you want to create a new Azure Monitor for SAP solutions instance, or register an existing Azure Monitor for SAP solutions instance. If you don't see this option, you've already configured this setting.

    :::image type="content" source="../media/monitor-setup.png" lightbox="../media/monitor-setup.png" alt-text="Screenshot of the A C S S page inside a V I S resource in the Azure portal, showing the option to create or register a new instance.":::

1. After you create or register your Azure Monitor for SAP solutions instance, you're redirected to the Azure Monitor for SAP solutions instance.
