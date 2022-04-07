Normally, you have to create a repository on GitHub before you can publish your code. Visual Studio Code lets you do that right from the editor. The following steps help you create a new project and publish that project to GitHub from Visual Studio Code.

## Step 1: Create a new project

1. Create a folder on your machine called **mslearn-demo**.

1. In Visual Studio Code, select the **File** menu, and then select **Open Folder**.

1. Select the **mslearn-demo** folder that you created in step 1.

### Create README.md

The README file is what people see when they visit your repo on Github.com. For more information about the purpose and content of a README file, check out the [Contribute to open source on GitHub](/learn/modules/create-open-source-program-github/) module.

1. On the **File** menu, select **New File**.

1. Add the following text to the file.

   ```markdown
   # My GitHub Project

   This is my GitHub project. I published it directly from Visual Studio Code.
   ```

1. On the **File** menu, select **Save**.

1. Save the file as **README.md**.

### Create .env.development

Many programs use an .env file type to define program information that's confidential. You should *not* push confidential information (such as database connection strings) to GitHub.

1. On the **File** menu, select **New File**.

1. Add the following text to the file.

   ```bash
   CONNECTION_STRING=secret-that-should-not-be-pushed-to-github
   ```

1. On the **File** menu, select **Save**.

1. Save the file as **.env.development**.

## Step 2: Publish to GitHub

1. Open the Source Control Management (SCM) view by selecting the **SCM** icon on the activity bar.

1. Select **Publish to GitHub**.

   :::image type="content" source="../media/source-control-management-publish.jpg" alt-text="Screenshot of the Source Control Management view in Visual Studio Code, with the Publish to GitHub button outlined.":::

1. In the prompt, select **Publish to GitHub public repository**.

1. Clear the selection of the **.env.development** file, because we don't want to publish that to GitHub.

   :::image type="content" source="../media/files-to-publish.jpg" alt-text="Screenshot of the command palette, showing a list of files in the current project with check boxes and the .env.development option cleared.":::

1. Select **OK**.

   The project will now be published to GitHub.

## Step 3: View the project on GitHub

1. Select **Open in GitHub** from the notification in Visual Studio Code.

1. View your repository on Github.com.

   :::image type="content" source="../media/first-commit.jpg" alt-text="Screenshot of the repository page on Github.com, showing the README file.":::

1. Notice the commit message is set to **first commit**.

1. Notice your project has a new file called **.gitignore**. Visual Studio Code added this file during the publishing process.

## Step 4: Examine .gitignore in Visual Studio Code

1. In Visual Studio Code, select the **View** menu.

1. Select **Explorer** from the dropdown list.

1. Select the **.gitignore** file.

1. Notice that the **.env.development** file has been added to **.gitignore**. Any files or directories added here will *not* be pushed to GitHub.

## What you just did

Let's recap what you did in this section:

- Created a new project and a README file
- Published the project to GitHub from Visual Studio Code
- Saw that the repository was created on Github.com
- Examined the .gitignore file that was automatically created when you chose *not* to include the .env.development file

Visual Studio Code handled all the tedious work that needs to happen behind the scenes to make this publishing workflow seamless.

Many times, though, you'll start a project from GitHub, not from a local machine. In the next section, you'll see how Visual Studio Code lets you clone repositories from your editor.