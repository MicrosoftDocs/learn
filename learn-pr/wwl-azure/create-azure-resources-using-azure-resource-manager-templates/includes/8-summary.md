This module explored **Azure Resource Manager (ARM) templates** and their components, teaching you how to implement infrastructure as code for consistent, repeatable Azure deployments.

## What you learned

You now understand how to:

- **Create Azure resources using ARM templates:** Define infrastructure declaratively using JSON or Bicep syntax for automated deployments.
- **Understand template components:** Work with parameters, variables, functions, resources, and outputs to build flexible, reusable templates.
- **Manage resource dependencies:** Use `dependsOn` elements and `reference()` functions to ensure correct deployment ordering and avoid circular dependencies.
- **Organize and modularize templates:** Break large templates into linked and nested components for better maintainability and reusability.
- **Secure sensitive data:** Integrate Azure Key Vault to pass passwords, API keys, and certificates securely without exposing them in code or logs.
- **Choose deployment modes:** Apply incremental mode for adding resources or complete mode for achieving idempotency in production environments.

## Key concepts recap

**ARM templates provide:**

- **Consistency:** Same infrastructure every deployment across all environments.
- **Automation:** Eliminate manual portal clicks and scripting errors.
- **Version control:** Track infrastructure changes alongside application code.
- **Reusability:** Create once, deploy many times with parameters.
- **Security:** Integrate with Key Vault for secrets management.

**Template structure:**

- **Parameters:** Configurable values for different environments.
- **Variables:** Reusable values to reduce duplication.
- **Functions:** Custom logic for complex operations.
- **Resources:** The actual Azure resources to deploy.
- **Outputs:** Return deployment information for automation.

**Best practices:**

- Use **Bicep** for new projects (cleaner syntax than JSON).
- Store secrets in **Azure Key Vault**, never in templates.
- Use **linked templates** for modular, maintainable architectures.
- Apply **complete mode** in production for idempotency.
- Validate templates before deployment with `az deployment group validate`.

## Next steps

**Continue your infrastructure as code journey:**

- Explore **Azure Bicep** as a modern alternative to JSON ARM templates.
- Learn about **Terraform** for multi-cloud infrastructure management.
- Implement **CI/CD pipelines** for automated template deployments.
- Study **Azure Policy** to enforce governance on deployed resources.
- Practice with **Azure Quickstart Templates** for real-world scenarios.

## Learn more

- [ARM template documentation - Azure Resource Manager](https://learn.microsoft.com/azure/azure-resource-manager/templates/)
- [What is Bicep? - Azure Resource Manager](https://learn.microsoft.com/azure/azure-resource-manager/bicep/overview)
- [Azure Key Vault to pass secure parameter values](https://learn.microsoft.com/azure/azure-resource-manager/templates/key-vault-parameter)
- [CI/CD with Azure Pipelines and templates](https://learn.microsoft.com/azure/azure-resource-manager/templates/add-template-to-azure-pipelines)
- [Azure Quickstart Templates on GitHub](https://github.com/Azure/azure-quickstart-templates)
- [Connect to Microsoft Azure - Azure Pipelines](https://learn.microsoft.com/azure/devops/pipelines/library/connect-to-azure)
- [Security through templates - Azure Pipelines](https://learn.microsoft.com/azure/devops/pipelines/security/templates)
