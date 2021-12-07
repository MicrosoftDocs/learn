**Chef Infra** is an infrastructure automation tool that you use to deploy, configure, manage, and ensure application and infrastructure compliance.

It provides for a consistent deployment and management experience.

Chef Infra helps you manage your infrastructure in the cloud, on-premises, or a hybrid environment by using instructions (or *recipes*) to configure nodes.

A *node* or chef-client is any physical or virtual machine (VM), cloud, or network device under management by Chef Infra.

See [Chef Infra Overview](https://docs.chef.io/chef_overview/) for a high-level Chef Infra architecture example.

## Chef Infra components

Chef Infra has three main architectural components:

 -  **Chef Server** This is the management point. There are two options for the Chef Server: a hosted solution and an on-premises solution.
 -  **Chef Client (node)** It's a Chef agent that is on the servers you're managing.
 -  **Chef Workstation** This is the Admin workstation where you create policies and execute management commands. You run the **knife** command from the Chef Workstation to manage your infrastructure.

Chef Infra also uses concepts called *cookbooks* and *recipes*. Chef Infra cookbooks and recipes are essentially the policies that you define and apply to your servers.
