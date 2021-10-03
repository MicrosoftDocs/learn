Your website's development team wanted to be able to deploy their changes within a Test environment, while keeping your production environment available for end users. 

In this module you learned how to add multiple environments to a YAML pipeline. You did this in such a way to allow for reuse. You were able to generalize the similar steps in a pipeline template and to vary on differences across environments by using parameters. 

Now you can easily make additional environments available if needed. 


- References
    - [Template types & usage](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/templates?view=azure-devops)
    - [Security through templates](https://docs.microsoft.com/en-us/azure/devops/pipelines/security/templates?view=azure-devops)
- References that are helpful internally but won't include in links:
    - [How to securely use variables and parameters in your pipeline](https://docs.microsoft.com/en-us/azure/devops/pipelines/security/inputs?view=azure-devops)
    - [Secure a service connection](https://docs.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml#secure-a-service-connection)
    - [Create and target an environment](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/environments?view=azure-devops)
    - [Add & use variable groups](https://docs.microsoft.com/en-us/azure/devops/pipelines/library/variable-groups?view=azure-devops&tabs=yaml)