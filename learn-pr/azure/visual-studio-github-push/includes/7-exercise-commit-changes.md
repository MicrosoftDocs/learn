One of the key aspects of any Git workflow is making commits to your branch. Committing is the Git equivalent of saving your file. In this exercise, you'll make a change to your code, stage the changes, and commit them, all without leaving your code files.

## Commit a change

1. Open **Program.cs** by selecting the file from Solution Explorer.

    :::image type="content" source="../media/7-solution-explorer.png" alt-text="Screenshot of Solution Explorer with the program.cs file highlighted.":::

1. Change the output message to "Hello Everyone!". Save the file.

    :::image type="content" source="../media/7-program-cs.png" alt-text="Screenshot of the Program.cs file in the editor.":::

1. Open the **Git Changes** window to view the pending changes. Select the plus button next to **Program.cs** to stage the file.

    :::image type="content" source="../media/7-stage-changes.png" alt-text="Screenshot of the Git Changes window, with the stage button highlighted.":::

1. Now that the changes are staged, enter a commit message in the text box that currently says **Update output message**, and then select **Commit Staged**.

    :::image type="content" source="../media/7-commit-staged.png" alt-text="Screenshot of the Git Changes window, with the commit message and commit button highlighted.":::

## Verify the commit

A gold info bar appears in the **Git Changes** window and says that the commit was created locally. Select the commit ID to open the details of the commit. You can also select the **1 outgoing / 0 incoming** link above the text box to open the **Git Repository** window.

:::image type="content" source="../media/7-verify-commit.png" alt-text="Screenshot of the Git Changes window, with the info bar and the outgoing link highlighted.":::

View the one outgoing commit that you created in your current branch's commit graph to verify its creation.
