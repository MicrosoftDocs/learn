Bicep is a language for declaratively deploying Azure resources. By using Bicep, you can define how your Azure resources should be configured and deployed. You define your resources within a Bicep file, called a _template_, and then submit the template to Azure Resource Manager (ARM). ARM then takes responsibility for deploying each resource within the template on your behalf.

Behind the scenes, Azure Resource Manager works based on JSON templates. When you submit a Bicep template to ARM, the Bicep tooling converts your template to JSON in a process called _transpilation_. This isn't something you typically have to think about, but if you want to, you can view the JSON template file that Bicep creates.

To get started with Bicep, you need to install some tooling. The easiest way to do this is to install recent versions of the Azure CLI or Azure PowerShell. Both of these tools support Bicep templates.

You will also need a text editor to write your Bicep templates in. [Visual Studio Code](https://code.visualstudio.com/) is a great text editor, and it has an [extension for writing Bicep templates](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). These tools provide language support and resource autocompletion. They help create and validate Bicep files.
