Levering several Azure services working in conjunction,you can bring data to your Digital Twin and permit two-way communication.  The Azure services used in this module are as follows:

- Azure SignalR
- Managed Identity
- Container instances
- Storage account
- Event grid topic
- Azure Digital Twins
- Application Insights
- Event grid system topic
- App Service plan
- Function app
- IoT Hub
- Deployment Script

To simplify the setup and use of these Azure services, a Azure Resource Manager (ARM) Template can be used.  This ARM Template will help automate the Azure Service deployment.  A base framework has been established for you, and a Visual Studio solution has been provided for your reference.  You will need to edit configuration parameters and execute the command window using Azure CLI to build and deploy the ARM Template.  In code, you define the infrastructure that needs to be deployed.  Just like application code, you store the infrastructure code in a source repository and version it. Anyone on your team can run the code and deploy similar environments.

To implement infrastructure as code for your Azure solutions, use Azure Resource Manager templates (ARM templates). The template is a JavaScript Object Notation (JSON) file that defines the infrastructure and configuration for your project. The template uses declarative syntax, which lets you state what you intend to deploy without having to write the sequence of programming commands to create it. In the template, you specify the resources to deploy and the properties for those resources.

You will use a new template language called Bicep, which is currently in preview. Bicep and JSON templates offer the same capabilities. You can convert the template between the two languages. Bicep provides a syntax that is easier to use for creating templates.

ARM Templates can be run using the Azure CLI from Windows Command Prompt or PowerShell. PowerShell offers some tab completion features not available from Windows Command Prompt, and is the preferred shell for this module.
