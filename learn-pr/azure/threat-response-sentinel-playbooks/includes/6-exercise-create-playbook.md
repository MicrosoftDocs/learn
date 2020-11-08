In this exercise, you will create an Azure Sentinel playbook.

## Exercise 1: Create an Azure Sentinel playbook

As a security engineer working for Contoso, you recently notice that significant number of users from your Azure AD, has been categorized at risk. Some of the users report that they use VPN connecton to connect to Contoso resources from home. You want to analyze that occurrence in the future and reduce the alerting of fault postive occurence.
You decide to implement Azure Sentinel playbook to automate respond on an incident.

In this exercise, you will explore the Azure Sentinel playbooks. You will perform the following tasks:
- Create a playbook to automate action against incidents.
- Create a playbook from Azure Sentinel repo on Github

> [!NOTE]
> If you choose to perform the exercise in this module be aware you may incur costs in your Azure Subscription. To estimate the cost refer to [Azure Sentinel Pricing](https://azure.microsoft.com/en-us/pricing/details/azure-sentinel/)

### Task 1: Work with Azure Sentinel Playbooks 

1. In the Azure portal, search for and select **Azure Sentinel**, and then select the previously created Sentinel workspace.
2. In the **Azure Sentinel** blade, in the menu bar, in the **Configuration** section, select **Playbooks**.
3. Select **+Add Playbook**.
4. On the **Logic App** blade, on the **Basics** tab, specify the following settings:

| **Settings** | **Value** |
| --- | --- |
| Subscription | Provide a name for the Azure subscription you are using in this lab. |
| --- | --- |
| Resource group | Select the resource group of your Azure Sentinel service. |
| Logic App name | ***yourname*-Sentinel**  | 
| Select the location | **Region** |
| Location | Region is selected nased on the location of the Azure Sentinel. | 
| Log Analytics | **Off** |

5. Select **Review + Create**, and then select **Create**.

**Note** : Wait for the deployment to complete. The deployment should take less than 1 minute.

6. After the deployment is complete, select **Go to resource**.
7. In the **Logic Apps Designer** pane, scroll down, and then select **Blank Logic App**.
8. In the search field, enter and select **Azure Sentinel**.
9. On the **Triggers** tab, select **When Azure Sentinel incident creation rule was triggered (Private Preview only) (preview)**.

![](RackMultipart20201101-4-du82r8_html_985baf0d737c4c8a.png)

10. In the Azure Sentinel, verify that for the Tenant in the drop-down menu, **Default Directory** is selected and then select **Sign in**. 

![](RackMultipart20201101-4-du82r8_html_70cdc921bd1e87c2.png)

11 Provide the credentials for your Azure subscription, and then select **+ New step**.
