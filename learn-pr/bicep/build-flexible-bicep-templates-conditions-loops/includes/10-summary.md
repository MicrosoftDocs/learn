Your toy company wants to launch new toy in multiple countries. For compliance reasons, the infrastructure needs to be spread across each of the countries that the toy will be launched in.

You needed to deploy same resources in multiple locations and into different environments. You wanted to have flexible Bicep templates that you could reuse and that could control deployments by changing deployment parameters.

You added conditions to your template, to deploy some of the resources only for certain environment. You then used copy loops to deploy resources into different Azure regions. You used variable loops to define the properties of resources you needed to deploy. Finally, you used output loops to retrieve properties of the resources that you'd deployed.

Without conditions and copy loops, you would need to maintain and use multiple versions of Bicep templates. Every change in your environment would need to be modified in multiple templates. This would cause lots of efforts and overhead to maintain all of the different templates. By using conditions and loops in your templates, you created a single template that worked for all of your regions and environments, and ensured that all of your resources were configured identically.

## References

- [Conditional deployment in templates](/azure/azure-resource-manager/templates/conditional-resource-deployment?tabs=bicep)
- [Resource iteration in templates](/azure/azure-resource-manager/templates/copy-resources?tabs=bicep)
