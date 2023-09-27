 
Now that your build agent is running and ready to receive build jobs, let's see it in action. In this unit, you modify a basic build configuration that we provide to build the _Space Game_ website by using your agent and not the Microsoft-hosted agent.

> [!NOTE]
> Run the following steps immediately after performing the steps in the previous module [Create a build agent  that runs on Azure](/training/modules/host-build-agent/4-create-build-agent).

At the end of this unit, as an optional step, you can remove the agent pool from your Microsoft Azure DevOps organization.

## Fetch the branch from GitHub

In this section, you fetch the `build-agent` branch from GitHub and check out, or switch to, that branch.

This branch contains the _Space Game_ project that you worked with in previous modules and an Azure Pipelines configuration to start with.

1. In Visual Studio Code, open the integrated terminal.
1. To download a branch named `build-agent` from the Microsoft repository and switch to that branch, run the following `git fetch` and `git checkout` commands:

    ```bash
    git fetch upstream build-agent
    git checkout -B build-agent upstream/build-agent
    ```

    Recall that *upstream* refers to the Microsoft GitHub repository. Your project's Git configuration understands the upstream remote, because you set up that relationship when you forked the project from the Microsoft repository and cloned it locally.

    Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

1. Optionally, in Visual Studio Code, open the *azure-pipelines.yml* file, and familiarize yourself with the initial configuration.

    The configuration resembles the basic one that you created in the [Create a build pipeline with Azure Pipelines](/training/modules/create-a-build-pipeline/6-create-the-pipeline?azure-portal=true) module. It builds only the application's release configuration.

## Modify the build configuration

In this section, you modify the build configuration to switch from using a Microsoft-hosted agent to using the agent from your build pool.

1. In Visual Studio Code, open the *azure-pipelines.yml* file, and then look for the `pool` section.

    ```yml
    pool:
      vmImage: 'ubuntu-20.04'
      demands:
      - npm
    ```

1. Modify the `pool` section, as shown here:

    ```yml
    pool:
      name: 'MyAgentPool'
      demands:
      - npm
    ```

    This version uses `name` to specify your agent pool, *MyAgentPool*. It maintains the `demands` section to specify that the build agent must have npm, the Node.js package manager, installed.

1. In the integrated terminal, add *azure-pipelines.yml* to the index, commit the changes, and push the branch up to GitHub.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Use private agent pool"
    git push origin build-agent
    ```

## Watch Azure Pipelines use your build agent

Watch the build run in the pipeline by using your build agent.

1. In Azure DevOps, go to the **Space Game - web - Agent** project.
1. On the project page or in the left pane, select **Pipelines**.
1. Select your pipeline from **Recently run pipelines**, and choose the most recent run (that was started when you updated the pipeline to use the **MyAgentPool** pool).
1. Choose **Job** and trace the run through each of the steps.

   From the **Initialize job** task, you see that the build uses your build agent.

    :::image type="content" source="../media/5-build-results-private-pool.png" alt-text="A screenshot of Azure Pipelines running the build. The Initialize job task shows that it's running the build on the private agent named MyLinxuAgent.":::

## Optional: Remove your build pool

For future reference, you can keep the build pool configuration in your Azure DevOps organization. But keep in mind that the VM that hosts the agent will no longer be available to you after you perform the cleanup steps at the end of this module.

In fact, Azure DevOps will detect that the agent is offline. Azure Pipelines will check for an available agent the next time a build is queued by using the MyAgentPool pool.

:::image type="content" source="../media/5-agent-pools-offline-agent.png" alt-text="A screenshot of the agent pool in Azure DevOps showing that the build agent is offline.":::

As an optional step, you can remove the build pool configuration from Azure DevOps. Here's how:

1. In Azure DevOps, go to the **Space Game - web - Agent** project.
1. Select **Project settings**.
1. Under **Pipelines**, select **Agent pools**.

    :::image type="content" source="../media/4-project-settings-agent-pools.png" alt-text="A screenshot of the project settings in Azure DevOps showing the location of the Agent pools menu item.":::
1. Under **MyAgentPool**, select the trash can icon, and then select **Delete**.

    :::image type="content" source="../media/5-agent-pools-delete-agent.png" alt-text="A screenshot of Azure DevOps showing the location of where to remove the agent from the agent pool.":::
