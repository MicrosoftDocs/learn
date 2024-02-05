You've found that many tool sets are available for infrastructure-as-code resource deployments. You want to learn more about when Bicep might be the right tool for you and your organization.

## Is Bicep the right tool?

There are many reasons to choose Bicep as the main tool set for your infrastructure-as-code deployments. For Azure deployments, Bicep has some advantages, but Bicep doesn't work as a language for other cloud providers.

### When is Bicep the right tool?

If you use Azure as your cloud platform, consider these advantages of using Bicep:

- **Azure-native**: With Bicep, you're using a language that is native to Azure. When new Azure resources are released or updated, Bicep supports those features on day one. When you use other third-party tools, it might take some time for new features to be defined in the tool set.

- **Azure integration**: ARM templates, both JSON and Bicep, are fully integrated within the Azure platform. With Resource Manager deployments, you can monitor the progress of your deployment in the Azure portal.

- **Azure support**: Bicep is a fully supported product with Microsoft Support.

- **No state management**: Bicep deployments compare the current state of your Azure resources with the state that you define in the template. You don't need to keep your resource state information somewhere else, like in a storage account. Azure automatically keeps track of this state for you.

- **Easy transition from JSON**: If you already use ARM JSON templates as your declarative template language, it isn't a difficult process to transition to using Bicep. You can use the Bicep CLI to decompile any ARM template into a Bicep template by using the `bicep decompile` command.

### When is Bicep not the right tool?

Some situations might call for another tool set. Consider the following reasons not to use Bicep as your main tool set:

- **Existing tool set**: When you're determining when to use Bicep, the first question to ask is, _does my organization already have a tool set in use?_ Many tooling options are available that can be used for infrastructure-as-code resource provisioning. Sometimes, it makes sense to use existing financial and knowledge investments when you consider adopting a new process.

- **Multicloud**: If your organization uses multiple cloud providers to host its infrastructure, Bicep might not be the right tool. Other cloud providers don't support Bicep as a template language. Open source tools like Terraform can be used for multicloud deployments, including deployments to Azure.
