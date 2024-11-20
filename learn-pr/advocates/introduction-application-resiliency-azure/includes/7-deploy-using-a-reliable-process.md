Once an application is deployed to production, updates are a possible source of errors. In the worst case, a bad update can cause downtime. To avoid this, the deployment process must be predictable and repeatable. Deployment includes provisioning Azure resources, deploying application code, and applying configuration settings. An update may involve all three, or a subset. 

The crucial point is that manual deployments are prone to error. Therefore, it's recommended to have an automated, idempotent process that you can run on demand, and re-run if something fails. 

- To automate provisioning of Azure resources you can use Terraform, Ansible, Chef, Puppet, PowerShell, CLI, or Azure Resource Manager templates.
- Use Azure Automation Desired State Configuration (DSC) to configure VMs. For Linux VMs, you can use Cloud-init.
- You can automate application deployment using Azure DevOps Services or Jenkins.

Two concepts related to resilient deployment are _infrastructure as code_ and _immutable infrastructure_.

**Infrastructure as code** is the practice of using code to provision and configure infrastructure. Infrastructure as code can use a declarative approach or an imperative approach (or a combination of both). Resource Manager templates are an example of a declarative approach. PowerShell scripts are an example of an imperative approach.

**Immutable infrastructure** is the principle that you shouldn't modify infrastructure after it's deployed to production. Otherwise, you can get into a state where ad hoc changes have been applied and it's unclear what was changed as well as more difficult to think effectively about the system.

Another question is how to roll out an application update. Azure recommends techniques such as blue-green deployment or canary releases that push updates in highly controlled way to minimize possible impacts from a bad deployment.

- Blue-green deployment is a technique in which an update is deployed into a production environment separate from the live application. After you validate the deployment, switch the traffic routing to the updated version. For example, Azure App Service Web Apps enables this with staging slots. 
- Canary releases are like blue-green deployments. Instead of switching all traffic to the updated version, you roll out the update to a small percentage of users, by routing a portion of the traffic to the new deployment. If there's a problem, back off and revert to the old deployment. Otherwise, route more of the traffic to the new version, until it gets 100% of the traffic.

Whatever approach you take, make sure that you can roll back to the last-known-good deployment, in case the new version isn't functioning. Also have a strategy in place to roll back database changes and any other changes to dependent services. If errors occur, the application logs must indicate which version caused the error.
