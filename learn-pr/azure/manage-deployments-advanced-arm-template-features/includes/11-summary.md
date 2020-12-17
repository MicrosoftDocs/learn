In this module, you started by learning about how you can express dependencies between resources. Being able to express this dependency guarantees that a resource can be expected to exist and that a certain deployment order happens. Additionally, this fact gives you the freedom to decide how to do the deployment. You can choose whether to deploy your resources on many different occasions or on one occasion, and still get the same result. 

You then learned how to manage secrets. You shouldn't store secrets in an Azure Resource Manager (ARM) template, because the template is most likely stored in a version control system. It's potentially vulnerable to anyone who has read access, now or in the future. Instead, a good approach is to store your secrets in Azure Key Vault, and also to configure your ARM template to read from that instance of Key Vault at deployment time.

Next, you learned how you can conditionally control various aspects of your template by using the `condition` construct in combination with parameters. This construct can, for example, help you deploy some resources on one environment while omitting to deploy those same resources on another environment. You can do this using the same template.

Finally, you learned how to identify repetitive parts of your template and encode those parts by using the `copy` construct. This construct allows you to deploy more than one instance of everything from properties to resources, making your templates shorter.

You should now have a good understanding of what advanced constructs are at your disposal. These can help you make your templates flexible, less repetitive, and more secure.

## Additional resources

- [Use Azure Key Vault to pass secure parameter value during deployment](https://docs.microsoft.com/azure/azure-resource-manager/templates/key-vault-parameter?tabs=azure-cli&azure-portal=true)
- [Tutorial: Integrate Azure Key Vault in your ARM template deployment](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-tutorial-use-key-vault?azure-portal=true)
- [Conditional deployment in ARM templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/conditional-resource-deployment?azure-portal=true) 
- [Tutorial: Use condition in ARM templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-tutorial-use-conditions?azure-portal=true)
- [Define the order for deploying resources in ARM templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/define-resource-dependency?azure-portal=true)
- [Tutorial: Create ARM templates with dependent resources](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-tutorial-create-templates-with-dependent-resources?tabs=CLI&azure-portal=true)
- [Tutorial: Create multiple resource instances with ARM templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-tutorial-create-multiple-instances?tabs=CLI%2Cazure-cli&azure-portal=true)
