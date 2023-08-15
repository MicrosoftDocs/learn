Separating YAML pipeline files in multiple repositories, projects, or templates is essential to help improve Azure DevOps security.

Implementing nested templates and tokens, and sensitive information such as credentials, secrets, and other configuration settings, helps abstract the main deployment pipeline and store it in a more secure location. This approach helps to limit the exposure of sensitive information to unauthorized users, reduce the risk of data breaches and prevent unauthorized access to critical resources.

In addition, by separating the pipeline configuration into smaller, more manageable pieces, it's easier to manage changes and version control, which can help to prevent errors and conflicts that can lead to security issues. By applying the power of nested templates, it's also possible to reduce duplication in the pipeline configuration, which can help simplify the pipeline's maintenance and management over time.

In this module, learners can work with Azure DevOps to create nested templates and configure pipelines to use tokenization while also learning to secure pipelines and protect their organization's sensitive information.

### Learning objectives

After completing this module, students and professionals can:

- Create nested templates.
- Rewrite the main deployment pipeline.
- Configure the pipeline and the application to use tokenization.
- Remove plain text secrets.
- Restrict agent logging.
- Identify and conditionally remove script tasks in Azure DevOps.

By the end of this module, you'll know how to extend a pipeline to use multiple templates and how to secure pipelines to protect their organization's sensitive information.

### Prerequisites

You must create an Azure DevOps Organization and a Team Project for some exercises. If you don't have them yet, see:

- [Create an organization - Azure DevOps.](https://learn.microsoft.com/azure/devops/organizations/accounts/create-organization)
- [Create a project in Azure DevOps.](https://learn.microsoft.com/azure/devops/organizations/projects/create-project)

To get the most out of this course, we recommend that you understand Azure DevOps and pipeline management.

For study recommendations, see:

- [Configure secure access to pipeline resources - Introduction.](/training/modules/configure-secure-access-pipeline-resources/1-introduction)

Ensure you have all the necessary resources and access to Azure DevOps before starting the course.

Let's begin!
