Normally, you have to create a repository on GitHub before you can publish your code. Visual Studio Code lets you do that right from the editor. The following steps will guide you to create a new project and then publish that project to GitHub from Visual Studio Code.

## Step 1: Create a new project

1. Create a folder on your machine called **mslearn-demo**.
1. In Visual Studio Code, select the **File** menu and choose **Open Folder**.
1. Select the **mslearn-demo** folder that you created in step 1.

### Create README.md

The README file is what is what people see when they visit your repo on github.com. For more information about the purpose and content of a REAMDE file, check out the "Contribute to open source on GitHub" module.

1. Select the "File" menu and select "New File".
1. Add the following text to the file.

   ```markdown
   # My GitHub Project

   This is my GitHub project. I published it directly from Visual Studio Code.
   ```

1. Select the "File" menu and select "Save".
1. Save the file as "README.MD".

### Create .env.development

Many programs use a `.env` file type to define program information that is confidential. Confidential information such as database connection strings should **not** be pushed to GitHub.

1. Select the "File" menu and select "New File".
1. Add the following text to the file.

   ```bash
   CONNECTION_STRING=secret-that-should-not-be-pushed-to-github
   ```

1. Select the "File" menu and select "Save".
1. Save the file as ".env.development".

## Step 2: Publish to GitHub

1. Open the Source Control Management (SCM) View by selecting the SCM icon in the activity bar.

1. Select the "Publish to GitHub" button.

   :::image type="content" source="../media/source-control-management-publish.jpg" alt-text="The source control management publish view in visual studio code with the publish to GitHub button outlined.":::

1. In the prompt, select "Publish to GitHub public repository".
1. Uncheck the ".env.development" file as we don't want to publish that to GitHub.

   :::image type="content" source="../media/files-to-publish.jpg" alt-text="The command palette showing a list of files in the current project with checkboxes and the .env.development option unchecked":::

1. Select "OK"

   The project will now be published to GitHub.

## Step 3: View project on GitHub

1. Select "Open in GitHub" from the notification in Visual Studio Code
1. View your repository on github.com

   :::image type="content" source="../media/first-commit.jpg" alt-text="The repository page on github.com showing the README file":::

1. Notice that the commit message is set to "first commit".
1. Notice that there is a new file called ".gitignore" in your project. This file was added by Visual Studio Code during the publish process.

## Step 4: Examine .gitignore in Visual Studio Code

1. In Visual Studio Code, select the "View" menu
1. Select "Explorer" from the dropdown
1. Select ".gitignore" file
1. Notice that the ".env.development" file has been added to the ".gitignore". Any files or directories added here will **not** be pushed to GitHub.

## What you just did

Let's recap what you did in this section.

1. You created a new project and a README file.
1. You published the project to GitHub from Visual Studio Code
1. You saw that the repository was created on github.com
1. You examined the `.gitignore` file that was automatically created when you chose _not_ to include the `.env.development` file.

Visual Studio Code handled all of the tedious work that needs to happen behind the scenes to make this publish workflow seamless.

Many times, though, we start a project from GitHub, not from our local machine. In the next section, you'll see how Visual Studio Code allows you to clone repositories from your editor.
