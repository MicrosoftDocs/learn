
You started by learning about the benefits of knowing beforehand about what would be deployed. This pre-knowledge helps with concerns like whether a new deployment would break the existing setup. It's also a good mental check to see if what you intend to happen is actually what will happen. You learned that the *what-if* script is the tool that will help you address these concerns.

You were then introduced to the Azure Resource Manager (ARM) template test toolkit. The test toolkit validates your deployment templates by comparing them to tried and tested best practices. It then indicates where you're in violation. The ARM template test toolkit isn't something you *must* abide. It's merely recommendations.

Finally, you learned how to implement domain-specific rules by authoring and running custom tests for the ARM template test toolkit.

You should now have a good understanding of what scripts and tools can help you during the development process of your deployment templates.

## Additional resources

- Read more on **what-if** command at the official [What-If](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-deploy-what-if?tabs=azure-powershell?azure-portal=true)
- Read more on the different test cases the toolkit is testing [Test cases](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/test-cases?azure-portal=true)
- Docs on [Deployment modes](https://docs.microsoft.com/azure/azure-resource-manager/templates/deployment-modes?azure-portal=true)
- Visual Studio Code [Integrated terminal](https://code.visualstudio.com/docs/editor/integrated-terminal?azure-portal=true)
- Azure CLI command [az configure](https://docs.microsoft.com/cli/azure/azure-cli-configuration?view=azure-cli-latest&azure-portal=true)
- Installing [PowerShell Core](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/test-toolkit?azure-portal=true)
- Docs on the [Test toolkit](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/test-toolkit?azure-portal=true)
- The testing toolkit GitHub repository [ARM template test toolkit](https://aka.ms/arm-ttk-latest?azure-portal=true)
