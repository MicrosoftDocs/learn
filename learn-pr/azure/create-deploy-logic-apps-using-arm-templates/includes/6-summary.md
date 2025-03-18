In this module, you learned what Workflow Definition Language means and how to use an Azure Resource Manager template to deploy a workflow from Azure Logic Apps.

Azure Resource Manager templates and the JSON representation for an Azure Logic Apps workflow are *declarative*. This term means that you define what the workflow does and the resources that you need, but you let Azure Resource Manager handle the deployment details.

You used an existing template from a GitHub repo to practice deploying a logic app resource using the Azure CLI. You then extended the template to use parameters, making the template more flexible and configurable for multiple deployments. Finally, you changed an action in a workflow to calculate a rectangle's area.

After you practice with more exercises and explore the documentation, the picture becomes clearer that these templates are powerful for deploying resources, especially for Azure Logic Apps resources. In the university scenario, you can assemble workflow deployments more quickly and in a consistent, reusable, and less error-prone way.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Learn more

- [Deploy Azure infrastructure by using JSON ARM templates](/training/modules/create-azure-resource-manager-template-vs-code/)
- [Azure Logic Apps Documentation](/azure/logic-apps/)
- [Quickstart: Create and manage automated logic app workflows in Visual Studio Code](/azure/logic-apps/quickstart-create-logic-apps-visual-studio-code)
- [Schema reference for Workflow Definition Language in Azure Logic Apps](/azure/logic-apps/logic-apps-workflow-definition-language)
- [Overview: Automate deployment for Azure Logic Apps by using Azure Resource Manager templates](/azure/logic-apps/logic-apps-azure-resource-manager-templates-overview)
