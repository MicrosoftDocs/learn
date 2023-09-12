<!--- raw content start --->
In this unit, you'll be working with the GitHub site and the web interface. If you already have a GitHub account and know your sign in credentials, you can skip to [Create an initial repository](#create-an-initial-repository).
<!--- raw content end --->

## Create a GitHub account

Creating a GitHub account is free, and creation is quick. While there are many different versioning systems available, for this project you'll be using GitHub.

1.  In a browser, go to [https://github.com](https://github.com?azure-portal=true)
2.  Select **Sign up**.
3.  Enter your email address (you’ll need access to this email in a few steps).
4.  Create a password.
    
    > [!NOTE]
    > GitHub requires that your password is at least 15 characters OR at least 8 characters including a number and a lowercase letter.
5.  Create a user name.
6.  Decide if you want to receive product updates.
7.  Complete the captcha.
8.  Select **Create account**.
9.  Check your email and enter your **launch code**.
    
    > [!NOTE]
    > In the next step, you can choose to personalize your GitHub experience or skip the personalization. The decision won’t impact your completion of this project.
10. Enter the personalization questions or select **Skip personalization**.

## Create an initial repository

If you already have a GitHub account with repositories in it, you'll want to create a new repository anyway to avoid trouble with your existing data.

1.  Select **Create repository**.
2.  Set your GitHub username as the repository owner.
3.  Enter **learn-git** as the repository name.
    
    > [!NOTE]
    > If you already have a learn-git repository in your account, you can delete and recreate the learn-git repository, or you'll need to modify the commands later in this module based on the repository name you end up using.
4.  Set the visibility to Private.
    
    > [!IMPORTANT]
    > Anyone is able to access a public repository. The privacy setting can be changed within the GitHub web interface.
5.  Select **Add a README file**.
6.  Leave the remaining settings as default.
7.  Select **Create repository**.

## Use the GitHub web interface to edit your README.md

1.  Select the edit icon for the readme file.
    
    :::image type="content" source="../media/readme-edit-control-4e9b72c7.png" alt-text="Screenshot of the edit button for the readme file.":::
    
2.  Copy the following text into the readme file.
    
    `This project is designed to help learn basic Git commands using the GitHub platform. Throughout this project, files and branches will be created and merged. The premise of the project is creating a grade database for a teacher to help organize student grades.`
3.  Select **Commit changes**.
4.  Review the commit comment. This is where you'd enter a custom commit message that others would read when checking what changes you had made.
5.  Select **Commit changes**.

## Use the GitHub web interface to create a new file

1.  Select **Add file**.
2.  Enter **grade-template.md** as the file name.
3.  Paste the following into the file.
    
    ```
    
    | Student | Grade |
    |----------|----------|
    | Ronak | grade |
    | Nao | grade |
    | Quinn | grade |
    | Sasa | grade |
    | Mingkwan | grade |
    
    
    
    ```
4.  Select **Commit changes**.
5.  Review the commit comment.
6.  Select **Commit changes**.

Congratulations - you've created a git repository including a README.md file and a project file. You've update the contents of both files and committed them to the main branch of the learn-git repository.
