Azure DevOps is a collection of services that provide an end-to-end solution for the five core practices of DevOps: planning and tracking, development, build and test, delivery, and monitoring and operations.

It is possible to put an Azure Databricks Notebook under Version Control in an Azure DevOps repo. Using Azure DevOps, you can then build Deployment pipelines to manage your release process.

## CI/CD with Azure DevOps

While we won't be demonstrating [all of the features of Azure DevOps](/azure/devops/user-guide/alm-devops-features?view=azure-devops) in this module, here are some of the features that make it well-suited to CI/CD with Azure Databricks.

* Integrated Git repositories
* Integration with other Azure services
* Automatic virtual machine management for testing builds
* Secure deployment
* Friendly GUI that generates (and accepts) various scripted files

## But what is CI/CD?

### Continuous Integration

Throughout the development cycle, developers commit code changes locally as they work on new features, bug fixes, etc. If the developers practice continuous integration, they merge their changes back to the main branch as often as possible. Each merge into the master branch triggers a build and automated tests that validate the code changes to ensure successful integration with other incoming changes. This process avoids integration headaches that frequently happen when people wait until the release day before they merge all their changes into the release branch.

### Continuous Delivery

Continuous delivery builds on top of continuous integration to ensure you can successfully release new changes in a fast and consistent way. This is because, in addition to the automated builds and testing provided by continuous integration, the release process is automated to the point where you can deploy your application with the click of a button.

### Continuous Deployment

Continuous deployment takes continuous delivery a step further by automatically deploying your application without human intervention. This means that merged changes pass through all stages of your production pipeline and, unless any of the tests fail, automatically release to production in a fully automated manner.

## Who benefits?

_Everyone_. Once properly configured, automated testing and deployment can free up your engineering team and enable your data team to push their changes into production. For example:

- Data engineers can easily deploy changes to generate new tables for BI analysts.
- Data scientists can update models being used in production.
- Data analysts can modify scripts being used to generate dashboards.

In short, changes made to a Databricks notebook can be pushed to production with a simple mouse click (and then any amount of oversight that your DevOps team feels is appropriate).

## Additional Resources

- [Continuous Integration & Continuous Delivery with Databricks](https://databricks.com/blog/2017/10/30/continuous-integration-continuous-delivery-databricks.html)
- [Azure DevOps Services Version Control](/azure/databricks/notebooks/azure-devops-services-version-control)
- [GitHub Version Control](/azure/databricks/notebooks/github-version-control)
- [Creating Continuous Integration Pipelines on Azure Using Azure Databricks and Azure DevOps](https://databricks.com/session/devops-for-applications-in-azure-databricks-creating-continuous-integration-pipelines-on-azure-using-azure-databricks-and-azure-devops)