Azure Key Vault is a secure secret, key, and certificate store. Azure Key Vault can ensure that your tokens and secrets are stored securely and easily accessed by your pipeline without exposing them in plain text. Azure Pipelines provides built-in tasks that enable you to retrieve secrets from Azure Key Vault during pipeline execution.

In this unit, learn ways to use Azure Key Vault with YAML pipelines for security tokens and secrets management.

## Prerequisite

Azure Key Vault, Service Principal and YAML Pipeline. Follow the steps to create the resources: [Use Azure Key Vault to secure secrets](/training/modules/configure-secure-access-azure-repos-from-pipelines/5-use-azure-key-vault-secure-secrets)

## Reference Azure Key Vault in a variable group

One way to use Azure Key Vault with YAML pipeline templates is to create a variable group that references the Key Vault. Here are the steps:

1. In Azure DevOps, click on Library under Pipelines.
2. Create a new variable group or use existing groups.
3. Give the variable group a name and description.
4. Under Variables, add a new variable and set its value to `$(keyVaultSecret)`. Use this variable to retrieve the secret from Azure Key Vault.
5. Under Link secrets, link the variable group to your Azure Key Vault and grant read access to the service principal that will be used to access the Key Vault.
6. Save the variable group.

Now, you can reference the variable group in your YAML pipeline templates using the following syntax:

```YAML
variables:
- group: <variable group name>

steps:
- task: AzureKeyVault@2
  inputs:
    azureSubscription: '<Azure subscription service connection>'
    KeyVaultName: '<Key Vault name>'
    SecretsFilter: '*'
    RunAsPreJob: true
```

## Pass Azure Key Vault secret as a parameter

Another way to use Azure Key Vault with YAML pipeline templates is to pass the secret as a parameter to the template.

1. In Azure DevOps, create a new pipeline and choose YAML.
2. In the pipeline, define a parameter for the secret:

    ```YAML
    parameters:
      - name: keyVaultSecret
        type: string
    ```

3. In the pipeline, use the AzureKeyVault task to retrieve the secret:

    ```YAML
    steps:
    - task: AzureKeyVault@2
      inputs:
        azureSubscription: '<Azure subscription service connection>'
        KeyVaultName: '<Key Vault name>'
        SecretsFilter: '$(keyVaultSecret)'
    ```

4. In the pipeline, pass the secret as a parameter to the template:

    ```YAML
    - template: template.yaml
      parameters:
        keyVaultSecret: $(keyVaultSecret)
    ```

Replace `<Azure subscription service connection>` and `<Key Vault name>` with your own values.

## Use Azure Key Vault with variables and tokens

A third way to use Azure Key Vault with YAML pipeline templates is to combine variables, tokens, and Azure Key Vault.

1. Set the value of the variable to `$(keyVaultSecret)` and mark it as a secret. Use variable to retrieve the secret from Azure Key Vault.
2. In your YAML pipeline template, use the `$(keyVaultSecret)` variable to retrieve the secret from Azure Key Vault:

    ```YAML
    steps:
    - task: AzureKeyVault@2
      inputs:
        azureSubscription: '<Azure subscription service connection>'
        KeyVaultName: '<Key Vault name>'
        SecretsFilter: '$(keyVaultSecret)'
    ```

3. To tokenize the value of the secret, use the `$(keyVaultSecret)` variable in your pipeline:

    ```YAML
    steps:
    - script: |
        echo $(keyVaultSecret)
    ```

    This outputs the value of the secret at runtime.

4. If you want to use the secret as an environment variable in your pipeline, you can set the environment variable in a script step:

    ```YAML
    steps:
    - task: AzureKeyVault@2
      inputs:
        azureSubscription: '<Azure subscription service connection>'
        KeyVaultName: '<Key Vault name>'
        SecretsFilter: '$(keyVaultSecret)'
    - script: |
        export MY_SECRET=$(keyVaultSecret)    
    ```

    This sets the `MY_SECRET` environment variable to the value of the secret.

## Best practices for using Azure Key Vault with YAML pipelines

1. Use a separate Key Vault for each environment. For example, use one Key Vault for production secrets and another for development secrets.
2. Assign minimum required permissions to the service principal that accesses the Key Vault.
3. Use the latest version of the AzureKeyVault task in your pipeline.
4. Ensure Azure Key Vault soft delete is enabled to protect against accidental deletion of secrets and keys.

## Challenge yourself

Create a new YAML pipeline that deploys an Azure Resource Manager template that references a secret stored in Azure Key Vault. Use the AzureKeyVault task to retrieve the secret and pass it as a parameter to the template. Verify that the pipeline can successfully deploy the template without exposing the secret in plain text.

**Suggested Lab:** [Integrate Azure Key Vault with Azure DevOps](https://learn.microsoft.com/training/modules/manage-application-configuration-data/11-integrate-azure-key-vault-with-azure-devops/)

For more information about Azure Key Vault and YAML pipelines, see:

- [Manage application configuration data.](https://learn.microsoft.com/training/modules/manage-application-configuration-data/)
- [Use Azure Key Vault secrets in Azure Pipelines.](https://learn.microsoft.com/azure/devops/pipelines/release/azure-key-vault/)
- [Use Azure Key Vault in your YAML Pipeline.](https://learn.microsoft.com/azure/devops/pipelines/release/key-vault-in-own-project/)
- [Azure Key Vault recovery management with soft delete and purge protection.](https://learn.microsoft.com/azure/key-vault/general/key-vault-recovery)
- [Add & use variable groups.](https://learn.microsoft.com/azure/devops/pipelines/library/variable-groups)
