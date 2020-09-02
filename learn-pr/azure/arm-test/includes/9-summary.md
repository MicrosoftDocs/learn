
You started by learning about the benefits of knowing beforehand about what would be deployed. This pre-knowledge helps with concerns like, for example,  if a new deploy would break the existing setup. It's also a good mental check to see if what you intend to happen is actually what will happen. You've furthermore learned that the **What-If** script is the tool that will help you address the above concerns.   

You were then introduced to **arm-ttk**, a testing toolkit. The testing toolkit validates your deployment templates by comparing them to tried and tested, best practices and indicates where you are in *violation*. It's worth pointing out that the **arm-ttk** is not something you *must* abide to but is merely recommendations.

Finally you've learned how to implement domain-specific rules by authoring and running custom tests for the **arm-ttk** tool.

In summary, you should now have a good overall understanding of what scripts and tools can help you during the development process of your deployment templates.

## Additional resources

- Read more on **What-If** at the official [What-If](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-deploy-what-if?tabs=azure-powershell)
- Docs on the [Test toolkit](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/test-toolkit)
- Test toolkit [GitHub repo](https://github.com/Azure/arm-ttk/blob/master/arm-ttk/README.md) 
- Read more on the different test cases the toolkit is testing [Test cases](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/test-cases)
