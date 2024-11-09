Many tool sets are available for infrastructure as code resource deployments. You want to learn more about when Terraform might be the right tool for you and your organization.

## Is Terraform the right tool?

Terraform is a great choice if you need a cloud / service agnostic solution. Terraform allows you to manage other Microsoft products in a consistent manner, including Azure DevOps and GitHub. Terraform has great ongoing community and Microsoft support and investment. Terraform fits well into an infrastructure as code DevOps process and supports the latest Azure identity solutions.

Whichever infrastructure as code solution you choose, know you are in good company. Simply making the choice to embrace infrastructure as code aligns you with our best practice guidance and our highest performing customers.

### When is Terraform the right tool?

If you use Azure as your cloud platform, consider these advantages of using Terraform:

- **Multicloud / Service Agnostic**: With Terraform, you're using a language that is agnostic of the clouds or services you use. You can even deploy resources to multiple providers within the same Terraform module.

- **Azure support**: With the azapi provider, when new Azure resources are released or updated, Terraform supports those features on day one.

- **Azure Verified Modules**: If you use [Azure Verified Modules](https://aka.ms/avm), you have a fully supported product with Microsoft Support.

- **State management**: Because of the state file, Terraform is effective at managing the lifecycle of your resource from creation through to decommissioning.

- **Skill sets**: When making your choice, take into account the skill set of your team and the skills available in your market.

### When is Terraform not the right tool?

Some situations might call for another tool set. Consider the following reasons not to use Terraform as your main tool set:

- **Existing tool set**: When you're determining when to use Terraform, the first question to ask is, *does my organization already have a tool set in use?* Many tooling options are available that can be used for infrastructure as code resource provisioning. Sometimes, it makes sense to use existing financial and knowledge investments when you consider adopting a new process.

- **Single cloud**: If your organization only uses Azure and no other clouds or services, Bicep might be the right tool. Terraform supports the single cloud scenario, but you might wish to consider the trade-off in managing state files.
