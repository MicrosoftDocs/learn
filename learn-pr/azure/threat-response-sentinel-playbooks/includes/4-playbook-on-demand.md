Some incidents need more investigation before executing the Playbook.

You can use Playbooks to run on demand from the incident details, to trigger steps as part of the investigation or to conduct some remediation action.

Following the previous example with suspicious users that are prevented to access corporate resources, Contoso security administrator found one fault positive occasion. Some of their users were accessing the resources over a VPN connection from remote computers and at the same time they were connected from the office computers. Microsoft security graph received signals and based on the vulnerability that detect potential threat from atypical travel locations they tagged the user with medium risk.

Security administrator can use a playbook that can automatically dismiss the risky user property in Azure AD.

## Azure Sentinel repository on GitHub

[Azure Sentinel repository on GitHub](https://github.com/Azure/Azure-Sentinel), contains ready to use playbooks to help you to automate response on incidents. These playbooks are defined with Azure Resource Manager (ARM) templates that uses Logic App Azure Sentinel trigger.

For our example you can use **Dismiss-AADRiskyUser** playbook, located in Azure Sentinel repository on GitHub and deploy directly in your Azure subscription.

Each deployment from GitHub, first must authorize each connection in the playbook before you edit them in Logic Apps Designer.

![](RackMultipart20201028-4-rlmmgt_html_2a1063672f8884cf.png)

## Attach a playbook on existing incident

Once that your playbook is ready, you can open **Incident** page in Azure Sentinel, and select the existing incident. In the detailed pane on the right side you can select **View full details,** to explore the properties of the incident. From the **Alerts blade,** you can click on **View playbooks,** and then you can run on of the existing playbooks.

![](RackMultipart20201028-4-rlmmgt_html_bf903f46812eb4fe.png) 

After the investigation of the incident, you choose to run the playbook manually to respond to a security threat.
