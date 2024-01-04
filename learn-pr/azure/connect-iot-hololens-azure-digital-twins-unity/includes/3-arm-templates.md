By using several Azure services working in unison, you can bring data to your digital twin and facilitate two-way communication between Azure and your digital twin – both in Unity and in mixed reality.

The Azure services used in this module are as follows:

- Azure SignalR Service
- Managed Identity
- Azure Container Instances
- Azure Storage
- Azure Event Grid
- Azure Digital Twins
- Application Insights
- Azure App Service
- Azure Functions
- Azure IoT Hub
- Deployment Script

To simplify the setup and use of these Azure services, you can use an Azure Resource Manager template (ARM template). This ARM template helps to automate Azure service deployment for your wind farm experience. A base framework has been established for you and a Visual Studio solution has been provided for your reference and use. You need to edit configuration parameters and run commands using Azure CLI to build and deploy the ARM template.

By using the ARM template with the Azure CLI, you define the key Azure infrastructure that needs to be deployed. Just like application code, you can store the ARM template infrastructure code in a source repository and version it. Anyone on your team can run the code and deploy similar environments with their own configuration parameters.

ARM templates can be either a Bicep or JavaScript Object Notation (JSON) file that defines the infrastructure and configuration for your project. The template uses declarative syntax, which lets you state what you intend to deploy without having to write the sequence of programming commands to create it. In the template, you specify the resources to deploy and the properties for those resources.

Use a new template language called Bicep. Bicep provides a syntax that is easier to use for creating templates. Bicep and JSON templates offer the same capabilities and you can convert the template between the two languages. The Bicep file used for this module has been created for you.

ARM templates can be run using the Azure CLI in a Command Prompt window or Windows PowerShell. PowerShell offers tab completion features not available at a command prompt and is the preferred shell for this module. You aren't required to run any of the Azure CLI commands with elevated permissions.
