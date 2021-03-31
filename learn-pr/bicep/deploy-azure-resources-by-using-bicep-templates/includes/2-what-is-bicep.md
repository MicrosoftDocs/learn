Bicep is a language for declaratively deploying Azure resources. By using Bicep, you can define how your Azure resources should be configured and deployed. You define your resources within a Bicep file, called a _template_, and then submit the template to Azure Resource Manager (ARM). ARM then takes responsibility for deploying each resource within the template on your behalf.

## How does Bicep compare to JSON ARM templates?

You may already be familiar with JSON ARM templates. These are also files that represent Azure resources. One common problem with JSON template is that they are difficult to work with, and have quite a complex syntax. It can be hard to get started with writing ARM templates using JSON.

Bicep solves these problems by using a much simpler language, which has been designed specifically to help you deploy resources to Azure.

Behind the scenes, Azure Resource Manager still operates based on the same JSON templates. When you submit a Bicep template to ARM, the Bicep tooling converts your template to a JSON format in a process called _transpilation_. This isn't something you typically have to think about, but if you want to, you can view the JSON template file that Bicep creates.

:::image type="content" source="../media/2-bicep-to-json.png" alt-text="Diagram illustrating a template author, a Bicep template, an emitted JSON template, and a deployment to Azure." border="false":::

## What do I need to install?

To get started with Bicep, you need to install some tooling. The easiest way to do this is to install the latest version of the Azure CLI or Azure PowerShell. Both of these tools support Bicep templates.

You will also need a text editor to write your Bicep templates in. [Visual Studio Code](https://code.visualstudio.com/) is a great text editor, and it has an [extension for writing Bicep templates](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). These tools provide language support and resource autocompletion. They help you to create and validate Bicep files.
