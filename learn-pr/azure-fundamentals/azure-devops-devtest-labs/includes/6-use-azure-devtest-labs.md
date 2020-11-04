Tailwind Traders wants to be more methodical and careful when it pushes new versions of its e-commerce website to production. The company will expand its quality assurance (QA) team, and it will use the cloud to create and host virtual machines (VMs). Through this approach, it will create testing environments that match the production environment.

The management team has concerns around the costs of a more automated test environment. For instance, it wants to make sure that the QA professionals are not wasting time configuring the testing environment to match the production environment. The team wants to ensure that the VMs are destroyed when they're no longer in use. It wants to limit the number of VMs that each QA professional is allowed to spin up. Also, the team wants to ensure that each environment is configured correctly and consistent with the production environment.

### Which service should you choose?

Once again, start by applying the decision criteria you learned about previously to find the right product.

First, does Tailwind Traders need to automate and manage test lab creation?  Yes. This looks like a job for Azure DevTest Labs, because it can do everything that the team needs to accomplish in this scenario.

We could continue evaluating the decision criteria, but neither Azure DevOps nor GitHub is needed for this scenario.  Remember that either Azure DevOps or GitHub could be used to create product releases that can automatically be included in any VMs that you create for testing purposes.
