To build your code or deploy your software, you generally need at least one agent.

As you add more code and people, you'll eventually need more.

When your build or deployment runs, the system begins one or more jobs.

An agent is an installable software that runs one build or deployment job at a time.

## Microsoft-hosted agent

If your pipelines are in Azure Pipelines, then you've got a convenient option to build and deploy using a Microsoft-hosted agent.

With a Microsoft-hosted agent, maintenance and upgrades are automatically done.

Each time a pipeline is run, a new virtual machine (instance) is provided. The virtual machine is discarded after one use.

For many teams, this is the simplest way to build and deploy.

You can try it first and see if it works for your build or deployment. If not, you can use a self-hosted agent.

A Microsoft-hosted agent has job time limits.

## Self-hosted agent

An agent that you set up and manage on your own to run build and deployment jobs is a self-hosted agent.

You can use a self-hosted agent in Azure Pipelines. A self-hosted agent gives you more control to install dependent software needed for your builds and deployments.

You can install the agent on:

 -  Linux.
 -  macOS.
 -  Windows.
 -  Linux Docker containers.

After you've installed the agent on a machine, you can install any other software on that machine as required by your build or deployment jobs.

A self-hosted agent doesn't have job time limits.
