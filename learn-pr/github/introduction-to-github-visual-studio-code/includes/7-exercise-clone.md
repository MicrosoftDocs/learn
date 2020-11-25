Let's see how you can use Visual Studio Code to start a new project by cloning the project from an existing repository on GitHub.

## Clone a new repository from GitHub

1. Open a new Visual Studio Code window. From the File Explorer view, you can click on **Clone Repository**. You should see an option to clone from GitHub.

   :::image type="content" source="../media/clone-from-github.png" alt-text="Clone from GitHub option shown in Visual Studio Code Command Palette":::

2. Select the **Clone from GitHub** option from the dropdown and you will find a list of your repositories. You can also search for other repositories on GitHub. Search for a repository using this path "MicrosoftDocs/mslearn-python-products" and select the first option.

   :::image type="content" source="../media/find-repository-to-clone.png" alt-text="The explorer view in Visual Studio Code showing with the clone repository button outlined and the clone from GitHub option in the command palette.":::

3. Choose a location on your computer where you want the repository to be cloned into.
4. Select **Open** from the pop-up that appears after Visual Studio Code has cloned the repository:

   :::image type="content" source="../media/open-cloned-repository.png" alt-text="A notification in Visual Studio Code asking to open the clone repository with the open button outlined.":::

## Comparing changes in commit history to gain context

1. Open the `README.md` file from the file explorer. Once you have the file in the editor, expand the **Timeline** Pane

   :::image type="content" source="../media/open-timeline.png" alt-text="The explorer icon in Visual Studio Code":::

2. Select the commit made by the user _Burke Holland_. This will open a read-only diff view so you can see all the changes associated with the commit. The green highlight shows that Burke has added those lines to the original content

   :::image type="content" source="../media/timeline-view.png" alt-text="The Visual Studio Code diff editor showing the differences in a file between 2 commits.":::
