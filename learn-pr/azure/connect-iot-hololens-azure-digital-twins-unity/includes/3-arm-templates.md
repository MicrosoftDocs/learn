By using several Azure services working in unison, you can bring data to your Digital Twin and facilitate two-way communication between Azure and your Digital Twin – both in Unity and in Mixed Reality. 

The Azure services used in this module are as follows:

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

To simplify the setup and use of these Azure services, an Azure Resource Manager (ARM) Template can be used.  This ARM Template helps to automate Azure Service deployment for your wind farm experience.  A base framework has been established for you and a Visual Studio solution has been provided for your reference / use.  You'll need to edit configuration parameters and execute commands using Azure CLI to build and deploy the ARM Template.  By using the ARM Template with the Azure CLI, you define the key Azure infrastructure that needs to be deployed.  Just like application code, you can store the ARM Template infrastructure code in a source repository and version it. Anyone on your team can run the code and deploy similar environments with their own configuration parameters.

ARM Templates can be either a Bicep or JavaScript Object Notation (JSON) file that defines the infrastructure and configuration for your project. The template uses declarative syntax, which lets you state what you intend to deploy without having to write the sequence of programming commands to create it.  In the template, you specify the resources to deploy and the properties for those resources.  You'll use a new template language called Bicep, which is currently in preview.  Bicep provides a syntax that is easier to use for creating templates.  Bicep and JSON templates offer the same capabilities and you can convert the template between the two languages. The Bicep file used for this module has been created for you.

ARM Templates can be executed using the Azure CLI inside **Windows Command Prompt** or **PowerShell**. PowerShell offers some tab completion features not available from Windows Command Prompt and is the preferred shell for this module.  You aren't required to run any of the Azure CLI commands with elevated permissions.