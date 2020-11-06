In this exercise, you will create an Azure Sentinel playbook.

## Exercise 1: Create an Azure Sentinel playbook

<!--Marjan as per the exercise template, we need to have setup section as described below. Can you please provide any content if applicable for the setup section for this exercise?  

Setup
<!-- Provide high level guidance on what needs to exist before tasks can be completed. Likely you'll point the students to a script to run. You might also have additional setup steps to include. -->
Download and run the setup script which will configure your Azure environment for this exercise. The script will <do X>, <do Y>, and <do Z>.
After running the script, create a resource group called ContosoResourceGroup. Details here.
Create a VM. Details here.
<!-- The following steps need to be detailed enough for someone to perform the task themselves - supposing they meet the prereq knowledge -->
>

### Task 1: Deploy Azure Sentinel

In this task, you will deploy Azure Sentinel.

1. Sign in to the [Azure portal](http://portal.azure.com/).
2. In the Azure portal, search for and select Azure Sentinel and, on the **Azure Sentinel workspaces** blade, select **+ Add.**
3. On the **Add Azure Sentinel to a workspace** blade, select **+ Create a new workspace.**
4. On the  **Create Log Analytics workspace** blade, specify the following settings:

| **Settings** | **Value** |
| --- | --- |
| Subscription | Provide a name for the Azure subscription you are using in this lab. |
| --- | --- |
| Resource group |Provide **sentinel** as the name for the new resource group. | <!-- Marjan, please check edits to this row-->
| Name | _ **Yourname-** _**Sentinel (**unique name) |
| Region | Provide a region that is closer to you. |

5. Select  **Review + Create**,  and then select  **Create**.

>[!Note]
> Wait for the deployment to complete. The deployment should take less than 1 minute.

6. After the workspace is created, in **Add Azure Sentinel to a workspace** blade, select **Add**. <!--Marjan please check if the bolding for the uI terms is correct in this sentence.-->

**Note** : Wait for the deployment to complete. The deployment should take less than 1 minute.

### Task 2: Configure Azure Sentinel Connectors

In this task, you will deploy Azure Sentinel connectors to Azure Activity and Azure Security Center.

1. In the Azure portal, search for and select Azure Sentinel, and then select the previously created Azure Sentinel workspace <!--MArjan please check if this reference is to Azure Sentinel workspace or should it be "previous created **sentinel** workspace.. the case bolding etc will differ.-->.
2. In the **Azure Sentinel** blade, on the menu bar, in the **Configuration** section, select **Data connectors.**
3. In the **Data connectors** pane, search for and select **Azure Activity.** In the details pane, select **Open connector page**.

![](RackMultipart20201101-4-du82r8_html_612ee3c1063f355.png)

4. In the **Azure Activity** pane, select the **Configure Azure Activity logs** link.

![](RackMultipart20201101-4-du82r8_html_422b315ab251d541.png)

5. Select your subscription, and then select **Connect**.
6. When you receive status **Connected** , you can close all open blades to return to the **Azure Sentinel | Data connector** blade.
7. In the Azure portal, search for and select **Security Center**.
8. In the **Security Center | Getting started** pane, verify that your subscription is selected, and then select **Upgrade**. In the **Install Agents** pane, select **Install agents**. <!--Marjan, I corrected the casing and bolding for the pane name. Please check Install Agents is the pane name.-->

![](RackMultipart20201101-4-du82r8_html_92596f151d072b55.png)

9. In the Azure portal, search for and select **Azure Sentinel**, and then select the previously created Sentinel workspace. <!--Marjan, same queation as before about th eworkspace name-->
10. In the **Azure Sentinel** blade, in the menu bar, in the **Configuration** section, select **Data connectors**.
11. In the **Data connectors** pane, search for and select **Azure Security Center.** 
12. In the details pane, select **Open connector page**.
13. In the **Azure Security Center** pane, in the **Configuration** section, locate your subscription, and then select **Connect**.

![](RackMultipart20201101-4-du82r8_html_d97fc63671ce75cb.png)

14. Scroll down in the instructions pane and in the **Create incidents – Recommended !** <!--MArjan, is this a blade, box, pane?. Also please the spaces after Recommended does that match the UI?-->, select **Enable**.

### Task 3: Work with Azure Sentinel Playbooks 

<!--Marjan, I changed this to task 3 instead of Exercise 2 task 1. I dont thik we have two exercises in the same unit. Can you please double check?-->

Draft lab exercise title: Create an Azure Sentinel playbook

- Task 1. Add a playbook from Logic Apps.
- Task 2. Add an Azure Sentinel connector in Logic Apps.
- Task 3. Add a trigger to Azure Sentinel Connection.
- Task 4. Add an action.
- Task 5. Test the playbook result. <!--Marjan, I am not sure if we re covering all these tasks in this exercise. I am finding it hard to map the exercise and tasks with the design doc or the content here. Can you please double-check?-->

1. In the Azure portal, search for and select **Azure Sentinel**, and then select the previously created Sentinel workspace.
2. In the **Azure Sentinel** blade, in the menu bar, in the **Configuration** section, select **Playbooks**.
3. Select **+Add Playbook**.
4. On the **Logic App** blade, on the **Basics** tab, specify the following settings:

| **Settings** | **Value** |
| --- | --- |
| Subscription | Provide a name for the Azure subscription you are using in this lab. |
| --- | --- |
| Resource group | Select the resource group of your Azure Sentinel service. |
| Logic App name | _ **Sentinel** _ | <!--MArjan do we need the underscore before and after the workspace name? And please confirm the casing of sentinel. When we created it, we used lower case in exercise 1.-->
| Select the location | **Region** |
| Location | Region is selected from the location of the Azure Sentinel. | <!--Marjan, this is not very clear - what region should be seletced or is this automatically selected?-->
| Log Analytics | **Off** |

5. Select **Review + Create**, and then select **Create**.

**Note** : Wait for the deployment to complete. The deployment should take less than 1 minute.

6. After the deployment is complete, select **Go to resource**.
7. In the **Logic Apps Designer** pane, scroll down, and then select **Blank Logic App**.
8. In the search field, enter and select **Azure Sentinel**.
9. On the **Triggers** tab, select **When Azure Sentinel incident creation rule was triggered (Private Preview only) (preview)**.

![](RackMultipart20201101-4-du82r8_html_985baf0d737c4c8a.png)

10. In the Azure Sentinel, verify that for the Tenant in the drop-down menu, **Default Directory** is selected and then select **Sign in**. <!--Marjan, does "Tenant" need to be capitalized?-->

![](RackMultipart20201101-4-du82r8_html_70cdc921bd1e87c2.png)

11 Provide the credentials for your Azure subscription, and then select **+ New step**.
