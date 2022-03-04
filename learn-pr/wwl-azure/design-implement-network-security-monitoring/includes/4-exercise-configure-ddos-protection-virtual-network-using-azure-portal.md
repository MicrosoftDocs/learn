> [!NOTE]
> To complete this exercise, you will need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at https://azure.com/free.

Being responsible for Contoso's Network Security team, you are going to run a mock DDoS attack on the virtual network. The following steps walk you through creating a virtual network, configuring DDoS Protection, and creating an attack which you can observe and monitor with the help of telemetry and metrics.

In this exercise, you will:

 -  Task 1: Create a resource group
 -  Task 2: Create a DDoS Protection plan
 -  Task 3: Enable DDoS Protection on a new virtual network
 -  Task 4: Configure DDoS telemetry
 -  Task 5: Configure DDoS diagnostic logs
 -  Task 6: Configure DDoS alerts
 -  Task 7: Submit a DDoS service request to run a DDoS attack
 -  Task 8: Clean up resources 

## Task 1: Create a resource group

1.  Log in to your Azure account.
2.  On the Azure portal home page, select **Resource groups**.
3.  Select **Create**.
4.  On the **Basics** tab, in **Resource group**, enter **MyResourceGroup**.
5.  In **Region**, select your region from the list.
6.  Select **Review + create**.

    :::image type="content" source="../media/create-resource-group-ddos-protection-plan-29e19f9f.png" alt-text="Create Resource Group":::


7.  Select **Create**.

    :::image type="content" source="../media/create-resource-group-end-112091d4.png" alt-text="End state when creating a resource group":::


## Task 2: Create a DDoS Protection plan

1.  On the Azure portal home page, select **Create a resource**, then in the search box, type **DDoS** and select **DDoS protection plan** when it appears.

    :::image type="content" source="../media/create-ddos-protection-plan-start-6bb0d4df.png" alt-text="Start point of creating a DDoS protection plan":::


2.  Select **Create**.
3.  On the **Basics** tab, in the **Resource group** list, select the resource group you just created.
4.  In the **Instance name** box, type **MyDdoSProtectionPlan**, then select **Review + create**.

    :::image type="content" source="../media/create-ddos-protection-plan-new-c0af2d5c.png" alt-text="Create DDoS protection plan":::


5.  Select **Create**.

## Task 3: Enable DDoS Protection on a new virtual network

Here you will enable DDoS on a new virtual network rather than on an existing one, so first you need to create the new virtual network, then enable DDoS protection on it using the plan you created previously.

1.  On the Azure portal home page, select **Create a resource**, then in the search box, type **Virtual Network**, then select **Virtual Network** when it appears.

    :::image type="content" source="../media/create-virtual-network-basics-for-ddos-protection-start-dfaf328a.png" alt-text="Start point for creating a virtual network":::


2.  On the **Virtual Network** page, select **Create**.
3.  On the **Basics** tab, select the resource group you created previously.
4.  In the **Name** box, enter **MyVirtualNetwork**, then select the **Security** tab.

    :::image type="content" source="../media/create-virtual-network-basics-for-ddos-protection-45f23479.png" alt-text="Create virtual network - Basics tab":::


5.  On the **Security** tab, next to **DDoS Protection Standard**, select **Enable**.
6.  In the **DDoS protection plan** drop-down list, select **MyDdosProtectionPlan**.

    :::image type="content" source="../media/create-virtual-network-security-for-ddos-protection-32b706a1.png" alt-text="Create virtual network - Security tab":::


7.  Select **Review + create**.
8.  Select **Create**.

## Task 4: Configure DDoS telemetry

You create a Public IP address, and then set up telemetry in the next steps.

1.  On the Azure portal home page, select **Create a resource**, then in the search box, enter **public ip**, then select **Public IP address** when it appears.
2.  On the **Public IP address** page, select **Create**.
3.  On the **Create public IP address** page, under **SKU**, select **Basic**.
4.  In the **Name** box, enter **MyPublicIPAddress**.
5.  Under **IP address assignment**, select **Static**.
6.  In **DNS name label**, enter **mypublicdnsxx** (where xx is your initials to make this unique).
7.  Select your resource group from the list.

    :::image type="content" source="../media/create-public-ip-address-for-ddos-telemetry-ac54f174.png" alt-text="Create public IP address":::


8.  Select **Create**.
9.  On the Azure home page, select **All resources**.
10. In the list of your resources, select **MyDdosProtectionPlan**.
11. Under **Monitoring**, select **Metrics**.
12. Select the **Scope** box, then select the checkbox next to **MyPublicIPAddress**.

    :::image type="content" source="../media/create-metrics-scope-for-ddos-telemetry-2fefdf5b.png" alt-text="Create metrics scope for DDoS telemetry":::


13. Select **Apply**.
14. In the **Metrics** box, select **Inbound packets dropped DDoS**.
15. In the **Aggregation** box, select **Max**.

    :::image type="content" source="../media/metrics-created-for-ddos-telemetry-dc26f5c8.png" alt-text="Metrics created for DDoS telemetry":::


## Task 5: Configure DDoS diagnostic logs

1.  On the Azure home page, select **All resources**.
2.  In the list of your resources, select **MyPublicIPAddress**.
3.  Under **Monitoring**, select **Diagnostic settings**.
4.  Select **Add diagnostic setting**.
5.  On the **Diagnostic setting** page, in the **Diagnostic setting name** box, enter **MyDiagnosticSetting**.
6.  Under **Category details**, select all 3 **log** checkboxes and the **AllMetrics** checkbox.
7.  Under **Destination details**, select the **Send to Log Analytics workspace** checkbox. Here, you could select a pre-existing Log Analytics workspace, but as you haven't set up a destination for the diagnostic logs yet, you will just enter the settings, but then discard them in the next step in this exercise.

    :::image type="content" source="../media/configure-ddos-diagnostic-settings-new-68277c11.png" alt-text="Configure new Diagnostic settings for DDoS":::


8.  Normally you would now select **Save** to save your diagnostic settings. Note that this option is still grayed out as we cannot complete the setting configuration yet.
9.  Select **Discard**, then select **Yes**.

## Task 6: Configure DDoS alerts

In this step you will create a virtual machine, assign a public IP address to it, and then configure DDoS alerts.

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

2. In the toolbar of the Cloud Shell pane, select the Upload/Download files icon, in the drop-down menu, select Upload and upload the following files **ddos.json** and **ddos.parameters.json** into the Cloud Shell home directory from the source folder **F:\Allfiles\Exercises\M06**.

3. Deploy the following ARM templates to create the VM needed for this exercise:

   ```powershell
   $RGName = "MyResourceGroup"
   
   New-AzResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile ddos.json -TemplateParameterFile ddos.parameters.json
   ```
  
4. When the deployment is complete, go to the Azure portal home page, and then select **Virtual Machines**.

5. Verify that the virtual machine has been created.

### Assign the Public IP address

1.  On the **Overview** page of the new virtual machine, under **Settings**, select **Networking**.
2.  Next to **Network Interface**, select **myvirtualmachine** (e.g., myvirtualmachine892).
3.  Under **Settings**, select **IP configurations**.
4.  Select **ipconfig1**.
5.  In the **Public IP address** list, select **MyPublicIPAddress**.
6.  Select **Save**.

:::image type="content" source="../media/change-public-ip-config-ddos-vm-new-920fd067.png" alt-text="Change public IP address for DDoS VM":::


### Configure DDoS alerts

1.  On the Azure home page, select **All resources**.
2.  In the list of your resources, select **MyDdosProtectionPlan**.
3.  Under **Monitoring**, select **Alerts**.
4.  Select **New alert rule**.
5.  On the **Create alert rule** page, under **Scope**, select **Edit resource**.
6.  In the **Select a resource** pane, in the **Filter by resource type** box, scroll down the list and select **Public IP addresses**.

    :::image type="content" source="../media/new-alert-rule-change-scope-public-ip-address-1-3e5400a0.png" alt-text="New alert rule change scope to public IP address":::


7.  In the **Resource** list, select **MyPublicIPAddress**, then select **Done**.
8.  On the **Create alert rule** page, under **Condition**, select **Add condition**.
9.  Select **Under DDoS attack or not**.

    :::image type="content" source="../media/add-condition-alert-rule-1-20f2dd85.png" alt-text="Add condition to alert rule - select a signal":::


10. In the **Operator** box select **Greater than or equal to**.
11. In **Threshold value**, enter **1** (means under attack).
12. Select **Done**.

    :::image type="content" source="../media/add-condition-alert-rule-2-e1746d20.png" alt-text="Add condition to alert rule - configure signal logic":::


13. Back on the **Create alert rule** page, scroll down to the **Alert rule details** section and in **Alert rule name**, enter **MyDdosAlert**.

:::image type="content" source="../media/new-alert-rule-end-3b66cfad.png" alt-text="End point of create new alert rule":::


14. Select **Create alert rule**.

## Task 7: Submit a DDoS service request to run a DDoS attack

1.  Create an account with [BreakingPoint Cloud](https://breakingpoint.cloud/)
2.  Set up your DDoS test as per the settings in the screenshot below (you may need to select the 100k pps test size with the trial account), but specifying the IP address of your own **MyPublicIPAddress** resource in the **Target IP Address** box (e.g., **51.140.137.219**)

    :::image type="content" source="../media/ddos-test-setup-0d944524.png" alt-text="DDoS Test Setup":::


3.  On the Azure portal home page, select **All resources**.
4.  In the resources list, select your **MyPublicIPAddress** resource, then under **Monitoring**, select **Metrics**.
5.  In the **Metric** box, select **Under DDoS attack or not** from the list.
6.  And here you can see DDoS attack as it happened. Note it may take the full 10 minutes before you see the results.

:::image type="content" source="../media/metrics-showing-resource-under-attack-a666d0a5.png" alt-text="Metrics showing resource under DDoS attack":::



## Task 8: Clean up resources

> [!NOTE]
> Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

1. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```powershell
   Remove-AzResourceGroup -Name 'MyResourceGroup' -Force -AsJob
   ```


> [!NOTE]
> The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.
