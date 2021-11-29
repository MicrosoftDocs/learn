**Chef Infra** is an infrastructure automation tool that you use to deploy, configure, manage, and ensure application and infrastructure compliance.

It provides for a consistent deployment and management experience.

Chef Infra helps you manage your infrastructure in the cloud, on-premises, or a hybrid environment by using instructions (or *recipes*) to configure nodes.

A *node* or chef-client is any physical or virtual machine (VM), cloud, or network device under management by Chef Infra.

The following diagram is of the high-level Chef Infra architecture:

:::image type="content" source="../media/chef-architecture-d2d1736a.png" alt-text="Diagram of the high-level Chef Infra architecture. A Chef Server box contains a Chef server, node objects, and cookbooks. An Administrators workstation box containing knife, settings, and cookbooks. It's linked to both a GitHub repository and Microsoft Azure via cloud provisioning requests, where nodes are managed by Chef.":::


## Chef Infra components

Chef Infra has three main architectural components:

 -  **Chef Server** This is the management point. There are two options for the Chef Server: a hosted solution and an on-premises solution.
 -  **Chef Client (node)** It's a Chef agent that is on the servers you're managing.
 -  **Chef Workstation** This is the Admin workstation where you create policies and execute management commands. You run the **knife** command from the Chef Workstation to manage your infrastructure.

Chef Infra also uses concepts called *cookbooks* and *recipes*. Chef Infra cookbooks and recipes are essentially the policies that you define and apply to your servers.
