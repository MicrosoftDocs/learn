# Exercise - Move the security repository away from a project

As seen in the previous unit, an important part of configuring a secure project and repository structure is separating projects as necessary.

Recall that in the banking institution example, it’ll be necessary to separate projects to increase security across pipelines and make sure that protected resources can’t be accessed by unauthorized users.

In this exercise, you’ll move the security repository away from an application project into a second project.

## Create a new repository

Create a new repository outside of the project to which the security repository is currently attached. This repository should be able to host the security-related files, such as policies, secrets, and access control lists.

1. Log in to your Azure DevOps account and navigate to the project you created for this module.
1. Click on the **Repos** icon in the left-hand navigation menu.
1. On the **Repos** page, click the **New repository** button in the upper right-hand corner.
1. In the **Create a new repository** dialog box that appears, select the type of repository you want to create. For this exercise, please select **Git**.
1. Enter a name for your new repository. The name should be unique within the project. For this exercise, name the repository as **“Project X Security Files”**.
1. Enter a description for your new repository. The description can be used to provide additional context about the repository.
1. Choose **Git** as the version control system and select any additional options you want to use.
1. Click the **Create** button to create the new repository.

## Export the security-related files

Now, it’s time to export the security-related files from the existing security repository in the project to the new repository you just created in the previous step.

> [!NOTE]
> Make sure you select a repository which already contains files or upload some files before you move on with this exercise.

You can use the Azure DevOps REST API to retrieve the contents of the security repository or manually download the files.

1. Navigate to the security repository that contains the files you want to export.
1. Identify the files that need to be exported. These files could include security policies, access control lists, or any other security-related configuration files.
1. Click on the **Clone** button in the upper-right corner of the repository page. This will open a dialog box that asks you to select a target repository to clone the existing repository to.
1. Select the target repository where you want to export the files to. This can be an existing repository or the new repository, “Project X Security Files”, you just created for this exercise.
1. Choose the appropriate settings for the target repository. You can choose to include all branches and history or just the current state of the repository.
1. Once you have selected the target repository and configured the settings, click on the **Clone** button to initiate the cloning process.
1. Wait for the cloning process to complete. This may take some time depending on the size of the repository and the speed of your internet connection.

## Check your work

Once you have completed the migration, test the new configuration to ensure that everything is working as expected. Then, deploy the changes to the production environment.

Finally, remove the old security repository from the project, and make sure that there are no remaining references to it in the project.

You have now been able to move the security repository away from a project to a new repository without disrupting your existing processes.
