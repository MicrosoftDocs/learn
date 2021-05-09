Your toy company wants to launch new toy in multiple countries, that requires dedicated infrastructure physically located in countries of toy launch.

You needed to deploy same resources in multiple locations and into different environments. You wanted to have flexible Bicep templates that you could reuse and control deployment by changing deployment parameters.

You added conditions to your template, to only deploy required resources based on environment type. You also used copy loops to deploy resources into different Azure regions. Furthermore, you used variable loops to define multiple properties of resources you needed to deploy. Finally, you used output loops to retrieve properties of resources that were deployed with template.

Without conditions and copy loops, you would need to maintain and use multiple versions of Bicep templates. Every change in your environment would need to be modified in multiple templates. This would cause lots of efforts and overhead to maintain all different templates. Using conditions and loops in your templates, you can minimize number of required templates. You control deployments by providing different deployment parameter values such as environment type or location of resources you need to deploy.

## References

- [Conditional deployment in templates](/azure/azure-resource-manager/templates/conditional-resource-deployment?tabs=bicep)
- [Resource iteration in templates](/azure/azure-resource-manager/templates/copy-resources?tabs=bicep)
