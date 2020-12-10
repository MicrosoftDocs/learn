In this module, you started by learning about how you can express dependencies between resources. Being able to express this dependency guarantees that a resource can be expected to exist and that a certain deployment order is guaranteed. Additionally this fact gives you the freedom to decide how to do the deployment as well,  you can choose whether to deploy your resources on many different occasions or on one occasion, and still get the same result. 

You were then introduced to an important topic, how to manage secrets. It's discouraged to store any kind of secrets in an Azure Resource Manager (ARM) template as the template is most likely stored in a version control system and thereby potentially vulnerable to anyone who may have read access now or in the future. A good approach is to use Azure Key Vault to store your secrets in there and also configure your ARM template to read from said Key Vault instance at deployment time.

Thereafter you learned how you could conditionally control various aspects of your template by using the _condition_ construct in combination with parameters. This construct can, for example,  help you deploy some resources on one environment while omitting to deploy those same resources on another environment, all the while using the same template.

Finally, you learned how to identify repetitive parts of your template and encode those parts using the _copy_ construct. This construct allows you to deploy more than one instance of everything from properties to resources. Using this construct is encouraged as it makes your templates shorter and more succinct.

You should now have a good understanding of what advanced constructs are at your disposal that can help you with everything from making your templates flexible, less repetitive, and more secure.

## Additional resources

- [How to: Use Azure Key Vault to pass secure parameter value during deployment](https://docs.microsoft.com/azure/azure-resource-manager/templates/key-vault-parameter?tabs=azure-cli&azure-portal=true)
- [Tutorial: Integrate Azure Key Vault in your ARM template deployment](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-tutorial-use-key-vault?azure-portal=true)
- [How to: Conditional deployment in ARM templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/conditional-resource-deployment?azure-portal=true) 
- [Tutorial: Use condition in ARM templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-tutorial-use-conditions?azure-portal=true)
- [How to: Define the order for deploying resources in ARM templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/define-resource-dependency?azure-portal=true)
- [Tutorial: Create ARM templates with dependent resources](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-tutorial-create-templates-with-dependent-resources?tabs=CLI&azure-portal=true)
- [Tutorial: Create multiple resource instances with ARM templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-tutorial-create-multiple-instances?tabs=CLI%2Cazure-cli&azure-portal=true)
