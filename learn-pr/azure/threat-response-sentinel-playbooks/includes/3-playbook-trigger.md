<!-- File name should be changed from "3-playboor-trigger.md" to "3-playbook-trigger.md"  -->
Now, that you understand little more about Azure Sentinel playbooks, let&#39;s see how Contoso can automatically respond to a security threat.

## Exploring the Playbooks page

You start to automate respond to threats in the Playbooks page. Here you can see all the playbooks that are created from Azure Logic Apps. The column **Trigger kind**, present what type of connectors are used in the logic app.

![](RackMultipart20201028-4-1cv98ih_html_8f13ea8ce93a89d2.png)

The header bar, shown in the following diagram, is used to create new playbooks, or to Enable/Disable the existing.

![](RackMultipart20201028-4-1cv98ih_html_4b0f4ac4c5b09e46.png)

The following options are available in the Header bar

- The **Add Playbook** button creates new Playbook
- The **Refresh** button will refresh the display, (for example after you create a new playbook)
- Dropdown time frame, filter the status of execution of the playbooks
- The **Enable**, **Disable**, and **Delete** buttons are only available if one or more logic apps are selected.
- The **Logic Apps documentation** button provides links to official Microsoft Docs with more information on logic apps.

So, Contoso wants to prevent access to their network from suspicious users with automated action and their security administrator create a playbook by clicking **Add Playbook** button. He will be directed to the page where he should create a new Logic App by providing inputs for the following settings:

- **Subscription** - Select the subscription that contains Azure Sentinel workplace
- **Resource Group** - You can use existing or create a new resource group
- **Logic App name** - Provide descriptive name for the logic app
- **Location** - Select the same location as where your Log Analytics workspace is located
- **Log Analytics** - If you enable log analytics, you can get information about playbook&#39;s runtime events.

![](RackMultipart20201028-4-1cv98ih_html_73e8eeca2ad79ed0.png)

## Logic Apps Designer

Once that the Logic App is created, you are directed into Logic App Designer page.

The Logic App Designer gives you a design canvas that you use to add a trigger and actions to your workflow. In our example the trigger will come from the Azure Sentinel Connector when a new security incident is created.

Opening Azure Sentinel Connector for the first time will prompt you to **Sign in** to your tenant either with user account from Azure Active Directory or with Service Principal. This will establish Application Programing Interface (API) connection to your Azure AD.

Each playbook starts with trigger, followed with actions that design the automated response on a security incident. You can combine actions from Azure Sentinel Connector with other actions from other Logic Apps connectors.

In our example we are adding the trigger from Azure Sentinel Connector, when incident is triggered, followed with action that identifies the entities from Azure Sentinel alert, and then an action that send an email to an Office 365 email account.

The following screenshot shows the incident triggered by Azure Sentinel Connector, that detects suspicious account and send email to administrator:

![](RackMultipart20201028-4-1cv98ih_html_f290e65b3b8e6bdc.png)

Each step in the workflow design, has different fields that need to be filled. For example, the action **Entities - Get Accounts**, require that we provide the list on entities from the Azure Sentinel Alert. The great thing of Logic App is that we can provide this input from **Dynamic content** list, which is populated from the outputs of the previous step. In our example, Azure Sentinel Connector Trigger **When a response to Azure Sentinel Alert is triggered,** provides dynamic properties, like **Entities, Alert Display name**, which we can use to fill the inputs.

![](RackMultipart20201028-4-1cv98ih_html_a309740eab36017.png)

Once that you provide all the steps in the Logic App Designer, save the Logic App, and that will create a playbook in Azure Sentinel.
