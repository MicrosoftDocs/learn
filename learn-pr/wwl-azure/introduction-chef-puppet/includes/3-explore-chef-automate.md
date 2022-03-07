You can deploy Chef on Microsoft Azure from the Azure Marketplace using the Chef Automate image.

*Chef Automate* is a Chef product that allows you to package and test your applications and provision and update your infrastructure.

Using Chef, you can manage changes to your applications and infrastructure using compliance and security checks and dashboards that give you visibility into your entire stack.

The Chef Automate image is available on the Azure Chef Server and has the legacy Chef Compliance server functionality.

You can build, deploy, and manage your applications and infrastructure on Azure.

Chef Automate is available from the Azure Marketplace, and you can try it out with a free 30-day license. You can deploy it in Azure straight away.

## Chef Automate structure and function

Chef Automate integrates with the open-source products Chef, Chef InSpec, Chef Habitat, and their associated tools, including chef-client and ChefDK.

See [Chef overview](https://docs.chef.io/chef_overview/) for an overview of the structure of Chef Automate and how it functions.

Let's break down the Chef Automate architecture components:

 -  **Habitat** is an open-source project that offers an entirely new approach to application management. It makes the application and its automation the deployment unit by creating platform-independent build artifacts on traditional servers and virtual machines (VMs). They also can be exported into your preferred container platform, enabling you to deploy your applications in any environment. When applications are wrapped in a lightweight habitat (the runtime environment), whether the habitat is a container, a bare-metal machine, or platform as a service (PaaS) is no longer the focus and doesn't constrain the application.

For more information about Habitat, go to [Use Habitat to deploy your application to Azure](/azure/chef/chef-habitat-overview).

 -  **InSpec** is a free and open-source framework for testing and auditing your applications and infrastructure. InSpec works by comparing the actual state of your system with the desired state that you express in easy-to-read and easy-to-write InSpec code. InSpec detects violations and displays findings in the form of a report, but you are in control of remediation.

You can use InSpec to validate the state of your VMs running in Azure. You can also use InSpec to scan and validate the state of resources and resource groups inside a subscription.

More information about InSpec is available at [Use InSpec for compliance automation of your Azure infrastructure](/azure/chef/chef-inspec-overview).
