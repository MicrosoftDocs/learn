**Exercise 1**

**Task 1: Deploy Azure Sentinel**

In this task, you will deploy Azure Sentinel.

1. Sign in to the [Azure portal](http://portal.azure.com/).
2. In the Azure portal, search for and select Azure Sentinel and, on the **Azure Sentinel workspaces** blade, click **+ Add.**
3. On the **Add Azure Sentinel to a workspace** blade, click **+ Create a new workspace.**
4. On the  **Create Log Analytics workspace** blade, specify the following settings:

| **Settings** | **Value** |
| --- | --- |
| Subscription | the name of the Azure subscription you are using in this lab |
| --- | --- |
| Resource group | the name of a new resource group  **sentinel** |
| Name | _ **Yourname-** _**Sentinel (**unique name) |
| Region | region that is closer to you |

5. Click  **Review + Create**  and then click  **Create**.

>[!Note]
> Wait for the deployment to complete. The deployment should take less than 1 minute.

6. Once that the Workspace is created, in **Add Azure Sentinel**** to a workspace **blade, click** Add.**

**Note** : Wait for the deployment to complete. The deployment should take less than 1 minute.

**Task 2: Configure Azure Sentinel Connectors**

In this task, you will deploy Azure Sentinel connectors to Azure Activity and Azure Security Center.

1. In the Azure portal, search for and select Azure Sentinel and select the previously created Sentinel workspace.
2. In the **Azure Sentinel** blade, on the left side in the menu bar, in the **Configuration** section, select **Data connectors.**
3. In the **Data connectors** pane, search for and select **Azure Activity.** In the detailed pane on the right site click on **Open connector page.**

![](RackMultipart20201101-4-du82r8_html_612ee3c1063f355.png)

4. In the **Azure Activity** pane, slick on the link **Configure Azure Activity logs**

![](RackMultipart20201101-4-du82r8_html_422b315ab251d541.png)

5. Click on your subscription and then click **Connect.**
6. When you receive status **Connected** , you can close all open blades to return on **Azure Sentinel| Data connector** blade.
7. In the Azure portal, search for and select Security Center
8. In the **Security Center | Getting started** pane, verify that your subscription is selected and click **Upgrade.** In the install Agents pane, click **Install agents.**

![](RackMultipart20201101-4-du82r8_html_92596f151d072b55.png)

9. In the Azure portal, search for and select Azure Sentinel, and select the previously created Sentinel workspace.
10. In the **Azure Sentinel** blade, on the left side in the menu bar, in the **Configuration** section, select **Data connectors.**
11. In the **Data connectors** pane, search for and select **Azure Security Center.** In the detailed pane on the right site click on **Open connector page.**
12. In the **Azure Security Center** pane, in the **Configuration** section, locate your subscription and click **Connect**

![](RackMultipart20201101-4-du82r8_html_d97fc63671ce75cb.png)

13. Scroll down in the instructions pane and in the **Create incidents – Recommended !,** click **Enable.**

**Exercise 2**

**Task 1: Work with Azure Sentinel Playbooks**

Draft lab exercise title: Create an Azure Sentinel playbook

- Task 1. Add a playbook from Logic Apps
- Task 2. Add an Azure Sentinel connector in Logic Apps
- Task 3. Add a trigger to Azure Sentinel Connection
- Task 4. Add an action
- Task 5. Test the playbook result

1. In the Azure portal, search for and select Azure Sentinel and select the previously created Sentinel workspace.
2. In the **Azure Sentinel** blade, on the left side in the menu bar, in the **Configuration** section, select **Playbooks.**
3. Click on **+Add Playbook.**
4. On the  **Logic App** blade, in the **Basics** tab, specify the following settings:

| **Settings** | **Value** |
| --- | --- |
| Subscription | the name of the Azure subscription you are using in this lab |
| --- | --- |
| Resource group | Select the resource group of your Azure Sentinel service |
| Logic App name | _ **Sentinel** _ |
| Select the location | **Region** |
| Location | region is selected from the location of the Azure Sentinel |
| Log Analytics | **Off** |

5. Click  **Review + Create**  and then click  **Create**.

**Note** : Wait for the deployment to complete. The deployment should take less than 1 minute.

6. Once the deployment is complete, click **Go to resource.**
7. In the **Logic Apps Designer** pane, scroll down and click **Blank Logic App.**
8. In the search field type and select **Azure Sentinel.**
9. In the **Triggers** tab, click **When Azure Sentinel incident creation rule was triggered (Private Preview only) (preview).**

![](RackMultipart20201101-4-du82r8_html_985baf0d737c4c8a.png)

10. In the Azure Sentinel, verify that for the Tenant in the drop-down menu, **Default Directory** is selected and then click **Sign in.**

![](RackMultipart20201101-4-du82r8_html_70cdc921bd1e87c2.png)

11 Provide the credential for your Azure subscription and then click **+ New step.*
