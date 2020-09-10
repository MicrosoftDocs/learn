Tailwind Traders wants to be more methodical and careful when pushing new versions of their ecommerce website to production.  They will expand their quality assurance team, and use the cloud to create 

Management has concerns around costs of a more automated test environment. For instance, they want to make sure that the QA professionals are not wasting time configuring the testing environment to match the production environment. They want to ensure that VMs are destroyed when no longer in use.  They want to limit the number of VMs that each quality assurance professional is allowed to spin up.  Also, they want to ensure that each environment is configured correctly and consistently with their production environment.

### Which service should we choose?

Once again, let's start by applying the decision criteria we learned about in the previous unit to find the right product.

First, does Tailwind Traders need to automate and manage test lab creation?  Yes!  This looks like a job for Azure DevTest Labs since it literally will do everything that Tailwind Traders needs to accomplish in this scenario.

We could continue evaluating the decision criteria from earlier, however Azure DevOps nor GitHub are needed for this specific scenario.  Remember that Azure DevOps or GitHub could be used to create product releases that can automatically be included in VMs created for testing purposes.