Your toy company wants to launch a new teddy bear toy in multiple countries/regions. For compliance reasons, the infrastructure must be spread across all the Azure regions where the toy will be launched.

You needed to deploy the same resources in multiple locations and a variety of environments. You wanted to create flexible Bicep templates that you can reuse, and to control resource deployments by changing the deployment parameters.

To deploy some resources only to certain environments, you added conditions to your template. You then used copy loops to deploy resources into various Azure regions. You used variable loops to define the properties of the resources to be deployed. Finally, you used output loops to retrieve the properties of those deployed resources.

Without the conditions and copy loops features, you'd have to maintain and use multiple versions of Bicep templates. You'd have to apply every change in your environment in multiple templates. Maintaining all these templates would entail a great deal of effort and overhead. By using conditions and loops, you were able to create a single template that works for all your regions and environments and ensure that all your resources are configured identically.

## Learn more

- [Conditional deployment in Bicep](/azure/azure-resource-manager/bicep/conditional-resource-deployment)
- [Bicep loops](/azure/azure-resource-manager/bicep/loops)
- [Resources](/azure/azure-resource-manager/bicep/resource-declaration)
- [Modules](/azure/azure-resource-manager/bicep/modules)
- [Variables](/azure/azure-resource-manager/bicep/variables)
- [Outputs](/azure/azure-resource-manager/bicep/outputs)
