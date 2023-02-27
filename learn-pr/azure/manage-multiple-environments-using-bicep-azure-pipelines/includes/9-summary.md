Your website's development team wanted to deploy its changes within a non-production environment. The team wanted to remove the risk of its changes accidentally affecting the customers who access the production website.

In this module, you learned how to work with multiple environments in a deployment pipeline. You generalized your deployment process into a pipeline template, and you reused the pipeline template for both your test and production environments. You also handled the differences between your environments by storing Bicep parameter values in variable groups.

Now that your pipeline deploys to multiple environments, you have higher confidence that the changes you make to your Bicep files will deploy successfully to a non-production environment, and will be tested before they progress to your production environment.

## Learn more

- [Azure Pipelines environments](/azure/devops/pipelines/process/environments)
- [Approvals and checks](/azure/devops/pipelines/process/approvals)
- [Deployment jobs](/azure/devops/pipelines/process/deployment-jobs)
- [Pipeline templates](/azure/devops/pipelines/process/templates)
  - [Use other repositories](/azure/devops/pipelines/process/templates#use-other-repositories)
  - [Security through templates](/azure/devops/pipelines/security/templates)
- [Conditions](/azure/devops/pipelines/process/conditions)
- [Expressions](/azure/devops/pipelines/process/expressions)
- [Variables](/azure/devops/pipelines/process/variables?tabs=yaml)
  - [Variable groups](/azure/devops/pipelines/library/variable-groups?tabs=yaml)
  - [Link secrets from an Azure key vault](/azure/devops/pipelines/library/variable-groups?tabs=yaml#link-secrets-from-an-azure-key-vault)
  - [How to securely use variables and parameters in your pipeline](/azure/devops/pipelines/security/inputs)
