To build your code or deploy your software, you need at least one agent. As you add more code and team members, you'll eventually need more agents.

When your build or deployment runs, the system starts one or more jobs. An agent is installable software that runs one build or deployment job at a time.

## Microsoft-hosted agents

If your pipelines are in Azure Pipelines, you have a convenient option to build and deploy using Microsoft-hosted agents.

With Microsoft-hosted agents, maintenance and upgrades happen automatically. Each time a pipeline runs, you get a fresh virtual machine instance that's discarded after one use.

For many teams, this is the simplest way to build and deploy. You can try it first and see if it works for your build or deployment. If not, you can use a self-hosted agent.

**Key characteristics:**

- Fresh virtual machine for each pipeline run
- Automatic maintenance and updates
- No setup or management required
- Job time limits apply

## Self-hosted agents

A self-hosted agent is one you set up and manage yourself to run build and deployment jobs. Self-hosted agents give you more control to install dependent software needed for your builds and deployments.

**Installation options:**

- Linux.
- macOS.
- Windows.
- Linux Docker containers.

After installing the agent on a machine, you can install any other software required by your build or deployment jobs.

**Key characteristics:**

- Full control over the environment.
- Custom software installation.
- No job time limits.
- Requires setup and maintenance.
