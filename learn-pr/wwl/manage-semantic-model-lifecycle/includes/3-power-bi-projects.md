Reusable assets give you consistent foundations, but without version control, you can't track what changed, who changed it, or when. Power BI Desktop projects and Git integration in Fabric bring professional source control to your analytics workflow.

## Power BI Desktop projects

A Power BI Desktop project (`.pbip`) saves your report and semantic model as plain text files in a folder structure instead of a single binary `.pbix` file. The project folder contains two main subfolders:

- **\<name\>.SemanticModel/** contains the semantic model definition in Tabular Model Definition Language (TMDL) format. TMDL stores each table, measure, and relationship as a separate readable text file.
- **\<name\>.Report/** contains the report definition in Power BI Report (`.pbir`) format. A `.pbir` file is a JSON document that stores the report's pages, visuals, and layout as structured text. This file type allows for version control, unlike `.pbix` file which is stored as binary data.

Because every definition is a text file, you can use standard diff tools to see exactly what changed between versions. A renamed column, a modified DAX measure, or an added relationship appears as a clear text change rather than a binary difference.

To save as a project, go to **File** > **Save as** in Power BI Desktop and select **Power BI Project (.pbip)** as the file type. Power BI Desktop creates the folder structure and a `.gitignore` file that excludes cache and local settings files from version control.

> [!NOTE]
> Power BI Desktop project files are currently in preview. Enable the feature in **File** > **Options and settings** > **Options** > **Preview features** > **Power BI Project (.pbip) save option**.

The project format also supports programmatic editing. Because the semantic model definition uses TMDL text files, you can use scripts or tools to make batch updates. For example, you can add a description to every measure in the model by modifying the TMDL files directly, then committing the batch change through Git.

## Enable Git integration for a workspace

Git integration connects a Fabric workspace to a Git repository in Azure DevOps or GitHub. Changes to workspace items sync bidirectionally between the workspace and repository. This workspace-level integration means you can version-control all items in a workspace through a single connection.

To set up Git integration:

1. Open your workspace in the Fabric portal.
1. Select **Workspace settings** > **Git integration**.
1. Connect to your Git provider (Azure DevOps or GitHub).
1. Select the repository, branch, and folder to map.
1. Complete the initial sync to align the workspace with the repository.

After the connection is established, the workspace shows Git status indicators on each item. Items that differ from the repository display a change icon. Items that match the repository show a synced status.

> [!NOTE]
> Git integration supports many Fabric item types beyond Power BI, including notebooks, pipelines, lakehouses, and warehouses. You can version-control an entire workspace of mixed content through a single Git connection.

## Work with a Git-connected workspace

Once your workspace is connected, you work through a cycle of editing, committing, and syncing:

- **Commit**: When you make changes to workspace items, select **Source control** to review pending changes. Choose the items to commit, provide a descriptive commit message, and save your changes to the Git repository.
- **Update**: When the repository has newer changes from other team members, select **Update all** to pull those changes into the workspace. This brings the workspace in sync with the latest repository state.
- **Branches**: You can switch the workspace to a different branch for development or testing. Each branch represents an independent line of development. Create feature branches for experimental changes that shouldn't affect the main branch until they're reviewed.
- **Conflicts**: If the same item changed in both the workspace and repository since the last sync, Git reports a conflict. You resolve the conflict by choosing which version to keep or merging the changes manually.

## Combine projects and Git integration

Power BI Desktop projects and Fabric Git integration complement each other in a team workflow:

1. **Local development**: Authors save work as `.pbip` projects on their local machine, using Power BI Desktop for authoring and iteration.
1. **Commit to Git**: Authors commit `.pbip` files to the shared Git repository. The text-based format makes code reviews practical because reviewers can see exactly which measures, columns, or visuals changed.
1. **Workspace sync**: The Fabric workspace syncs with the repository, so published content reflects the latest commits.

This workflow gives you the benefits of local development (faster iteration, offline work) combined with centralized version history and team collaboration through Git.

| Workflow step | Tool | Purpose |
|---|---|---|
| Author and iterate | Power BI Desktop (.pbip) | Local development with readable text files |
| Track changes | Git (Azure DevOps or GitHub) | Version history, branching, pull requests |
| Publish to service | Fabric workspace Git sync | Deploy committed content to the workspace |

> [!TIP]
> Use pull requests as quality gates. Require at least one reviewer to approve changes before merging to the main branch. This adds a review step between development and deployment, catching issues before they reach the workspace.

With reusable assets under version control, the **Develop** stage is complete. Next, you move to the **Validate** stage — inspecting and verifying your models programmatically through the XMLA endpoint.
