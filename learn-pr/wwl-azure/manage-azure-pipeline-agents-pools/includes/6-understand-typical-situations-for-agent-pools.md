If you've got many agents intended for different teams or purposes, you might want to create more pools, as explained below.

## Create agent pools

Here are some typical situations when you might want to create agent pools:

 -  You're a project member, and you want to use a set of machines your team owns for running build and deployment jobs.
     -  First, make sure you're a member of a group in All Pools with the Administrator role.
     -  Next, create a New project agent pool in your project settings and select the option to Create a new organization agent pool. As a result, both an organization and project-level agent pool will be created.
     -  Finally, install and configure agents to be part of that agent pool.
 -  You're a member of the infrastructure team and would like to set up a pool of agents for use in all projects.
     -  First, make sure you're a member of a group in All Pools with the Administrator role.
     -  Next, create a New organization agent pool in your admin settings and select Autoprovision corresponding project agent pools in all projects while creating the pool. This setting ensures all projects have a pool pointing to the organization agent pool. The system creates a pool for existing projects, and in the future, it will do so whenever a new project is created.
     -  Finally, install and configure agents to be part of that agent pool.
 -  You want to share a set of agent machines with multiple projects, but not all of them.
     -  First, create a project agent pool in one of the projects and select the option to Create a new organization agent pool while creating that pool.
     -  Next, go to each of the other projects, and create a pool in each of them while selecting the option to Use an existing organization agent pool.
     -  Finally, install and configure agents to be part of the shared agent pool.
