Once you identify a compromised system, you can run security playbooks to automate the response to a specific security alert. A security playbook is a collection of procedures that can be executed from Security Center once a certain playbook is triggered from selected alert. Security playbook can help to automate and orchestrate your response to a specific security alert detected by Security Center.

Security playbooks are based on **Azure Logic Apps** which allows you to easily customize existing logic and create a workflow using the visual workflow designer. You can either start with an existing Logic App, or create a new Logic App and use Security Center to trigger it when an alert is generated.

## Create a security playbook

New security playbooks can be created directly in the Security Center portal. Let's try that out using the free Azure Sandbox. You will need an Office 365 email account to use this specific set of instructions - if you don't have one, try changing the instructions below to use a different template, or create a Blank Logic App.

1. Under **Automation & Orchestration** in the Azure Security Center left panel, select **Playbooks (Preview).**

    ![Screenshot showing the playbook creation screen](../media/7-playbooks.png)

1. Select the **Add** button to create a new Logic App to use as a playbook.

1. In the **Logic App** panel, enter the following information:
    - **Name**: _RespondToMalwareAlert_
    - **Subscription**: _Concierge Subscription_
    - **Resource group**: select _Use existing_ and pick <rgn>[Learn resource group]</rgn> from the drop-down list
    - **Location**: select any valid location near you - if it fails to create, try a different location
    - **Log Analytics**: select _Off_

1. Select **Create** to create the Logic app. This will return you to the Playbooks screen. You can select the **Refresh** button from the top toolbar until the app shows up.

    ![Screenshot highlighting the Refresh button on the Playbook screen](../media/7-refresh-playbook.png)

1. Select your logic app to edit it. The **Logic Apps Designer** will appear.

1. Select **Get a notification email when Security Center detects a threat** as shown below. You could also select **Blank Logic App** if you wanted to create some custom logic to run in response to an alert.

    ![Screenshot showing the popular security options from Logic apps](../media/7-select-logic-app.png)

1. Select **Use this template** to create the app.

1. Provide credentials for Office 365 to connect your email account.

1. Select **Create** on the **Azure Security Center Alert** connection.

1. Specify a target email address to send the notification to.

1. You can use the **+ Next step** to create additional logic steps in the flow. In this case, we don't need any more so select **Save** from the menu at the top.

## Run a security playbook

You can run playbooks from the Security Center dashboard.

1. Navigate back to the Security Center dashboard. You can use the breadcrumb bar at the top to back up.

1. Under **Threat Detection**, select **Security incidents & alerts**.

1. Select an alert and at the top of the alert's page, select the **Run playbooks** button.

    ![Screenshot showing the Run playbooks option](../media/7-security-center-playbooks.png)

1. In the Playbooks page, select the playbook that you want to run, and select the **Run** button. If you want to see the playbook before triggering, you can select it, and the designer will open.

## Playbook examples

The Security Center team has created four sample playbooks to demonstrate Azure Security Center capabilities. With these four playbooks you can evaluate Azure Security Capabilities to protect your Azure resources against virus attack, SQL injection, DDoS on public IP or cross site scripting.

You can deploy the playbooks from the following URL to your Azure tenant:

1. **Virus attack playbook** – https://aka.ms/ASCPlaybooksVAttack – deploys 2 virtual machines, OMS and associated network resources. One of the VM is deployed without endpoint protection
1. **SQL Injection playbook** – https://aka.ms/ASCPlaybooksSQLi – deploys 2 application gateway, a web app and SQL server and database and OMS
1. **XSS (cross site scripting) attack** – https://aka.ms/ASCPlaybooksXSS – deploys 2 application gateway, a web app and SQL server and database and OMS
1. **DDoS protection** – https://aka.ms/ASCPlaybooksDDos – deploys a virtual machine an associated network resources (including public IP address) and OMS.

Once the playbook is deployed, just follow the instruction to execute the associated scenario.
