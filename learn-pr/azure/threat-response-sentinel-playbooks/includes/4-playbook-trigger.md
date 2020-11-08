Now, that you understand a little more about Azure Sentinel playbooks, let&#39;s see how Contoso can automatically respond to a security threat.

## Explore the Playbooks page

You can automate respond to threats in the **Playbooks** page. On this page, you can see all the playbooks that are created from Azure Logic Apps. The column **Trigger kind** presents what type of connectors are used in the logic app.

![](RackMultipart20201028-4-1cv98ih_html_8f13ea8ce93a89d2.png)

You can use the header bar, as displayed in the following diagram, to create new playbooks or to enable or disable existing playbooks.

![](RackMultipart20201028-4-1cv98ih_html_4b0f4ac4c5b09e46.png)

The header bar provides the following options:

- Use the **Add Playbook** button to create a new playbook.
- Use the **Refresh** button to refresh the display, for example, after you create a new playbook.
- Use the drop-down time frame to filter the status of the running of the playbooks. <!--Marjan, can you please confirm the UI name here? Is the drop-down option called "time frame"?-->
- The **Enable**, **Disable**, and **Delete** buttons are only available if you select one or more logic apps.
- Use the **Logic Apps documentation** button to review links to official Microsoft documentation for more information on logic apps.

Contoso wants to use automated actions to prevent suspicious users from accessing their network. As their security administrator, you can create a playbook to implement this action. To create a new playbook, select **Add Playbook**. You will be directed to the page where you should create a new Logic App by providing inputs for the following settings:

- **Subscription**. Select the subscription that contains the Azure Sentinel workplace. <!--Marjan just doible-checking if this was supposed to be workspace or workplace-- >
- **Resource Group**. You can use an existing resource group or create a new one.
- **Logic App name**. Provide a descriptive name for the logic app.
- **Location**. Select the same location as where your Log Analytics workspace is located.
- **Log Analytics**. If you enable log analytics, you can get information about playbook&#39;s runtime events.

![](RackMultipart20201028-4-1cv98ih_html_73e8eeca2ad79ed0.png)

## Logic Apps Designer

After Azure Sentinel creates the Logic App, you are directed to the **Logic App Designer** page. <!--Marjan, I changed this sentence to active voice but please check if it is Azure Sentinel that creates the App or just Azure.-->

The Logic App Designer provides a design canvas that you use to add a trigger and actions to your workflow. For example, you can configure the trigger to come from the Azure Sentinel Connector when a new security incident is created.

Opening Azure Sentinel Connector for the first time prompts you to **Sign in** to your tenant either with a user account from Azure Active Directory (Azure AD) or with Service Principal. This establishes an API connection to your Azure AD.

Each playbook starts with trigger followed by actions that design the automated response on a security incident. You can combine actions from Azure Sentinel Connector with other actions from other Logic Apps connectors.

For example, you can add the trigger from Azure Sentinel Connector when an incident is triggered, follow it with an action that identifies the entities from Azure Sentinel alert, and then another action that sends an email to an Microsoft Office 365 email account.

The following screenshot displays the incident triggered by Azure Sentinel Connector, which detects a suspicious account and sends an email to the administrator. 

![](RackMultipart20201028-4-1cv98ih_html_f290e65b3b8e6bdc.png)

Each step in the workflow design has different fields that you must fill. For example, the **Entities - Get Accounts** action requires you to provide the list of entities from Azure Sentinel Alert. An advantage of using Azure Logic Apps is that you can provide this input from the **Dynamic content** list, which is populated with the outputs of the previous step. For example,the  Azure Sentinel Connector trigger **When a response to Azure Sentinel Alert is triggered** provides dynamic properties such as **Entities, Alert Display name**, which you can use to fill the inputs.

![](RackMultipart20201028-4-1cv98ih_html_a309740eab36017.png)

After you provide all the steps in the Logic Apps Designer, save the logic app to create a playbook in Azure Sentinel.
