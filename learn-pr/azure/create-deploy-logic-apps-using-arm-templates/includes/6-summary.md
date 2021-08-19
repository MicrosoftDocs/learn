In this module, you defined what Workflow Definition Language means and how to use a Resource Manager template to deploy a Logic Apps workflow. 

Resource Manager templates and the JSON representation of a Logic Apps workflow are *declarative*, meaning that you define what the workflow should do and what resources you need and let the Resource Manager handle the deployment details. 

You used an existing template from a GitHub repo to practice deploying a logic app from the Azure CLI. You then extended the template to use parameters, making it more configurable. Finally, you changed the action in our simple workflow to calculate the area of a rectangle. 

Once you practice by doing and explore the documentation, it will become clearer how powerful these templates become for deployment of resources, including Logic Apps workflows. In the university scenario, you'll be able to assemble workflow deployments more quickly, in a consistent, less error-prone, reusable way. 

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Learn more

- [Deploy Azure infrastructure by using JSON ARM templates](/learn/modules/create-azure-resource-manager-template-vs-code/)
- [Azure Logic Apps Documentation](/azure/logic-apps/)
- [Quickstart: Create and manage automated logic app workflows - Visual Studio Code](/azure/logic-apps/Quickstart-create-logic-apps-visual-studio-code)
- [Schema reference for Workflow Definition Language in Azure Logic Apps](/azure/logic-apps/logic-apps-workflow-definition-language)
- [Create Azure Resource Manager templates for deploying logic appsSS](/azure/logic-apps/logic-apps-create-deploy-template)