Your website's development team wanted to be able to deploy their changes within a non-production environment, and remove the risk of their changes accidentally affecting your customers accessing the production website.

In this module you learned how to work with multiple environments in a deployment pipeline. You were able to generalize the similar steps in a pipeline template, and to handle the differences between your environments by storing Bicep parameters in variables and variable groups.
    
- [Azure Pipelines environments](/azure/devops/pipelines/process/environments)
- [Pipeline templates](/azure/devops/pipelines/process/templates)
    - [Use other repositories](/azure/devops/pipelines/process/templates#use-other-repositories)
    - [Security through templates](/azure/devops/pipelines/security/templates)
- [Conditions](/azure/devops/pipelines/process/conditions)
- [Expressions](/azure/devops/pipelines/process/expressions)
- [Variables](/azure/devops/pipelines/process/variables?tabs=yaml)
    - [Variable groups](/azure/devops/pipelines/library/variable-groups?tabs=yaml)
    - [Link secrets from an Azure key vault](/azure/devops/pipelines/library/variable-groups?tabs=yaml#link-secrets-from-an-azure-key-vault)
    - [How to securely use variables and parameters in your pipeline](/azure/devops/pipelines/security/inputs)