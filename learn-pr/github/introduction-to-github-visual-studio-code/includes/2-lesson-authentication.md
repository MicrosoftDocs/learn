There's a variety of ways that you might use GitHub with a project. Sometimes you clone a project to get a copy of it that you can work on. Sometimes, it goes the other direction and you have a local project that you want to put in GitHub. 

Before you can do anything at all with GitHub, you have to make sure that you can authenticate. Normally, this can be a tedious, multistep process that involves generating and working with SSH keys. One benefit of using Visual Studio Code to work with GitHub is that it handles all of the authentication setup for you.

## Authentication to GitHub through Visual Studio Code

You can select the account icon at the bottom of the Activity Bar and sign in with your GitHub account. A browser window opens, and you're asked to grant permission for Visual Studio Code to access GitHub. 

This step is needed to connect Visual Studio Code to GitHub. It doesn't store any sensitive information. After you select **Continue**, you'll be redirected back to Visual Studio Code.

## Access to your GitHub account from Visual Studio Code

When you sign in to your GitHub account in Visual Studio Code, various extensions or parts of Visual Studio Code can now access your GitHub account information. After you've signed in, you can choose which Visual Studio Code extensions are allowed to use your GitHub authentication.

To see all the extensions that are using your GitHub account, select the account icon, select your GitHub username, and choose **Manage Trusted Extensions**. *GitHub* refers to the built-in GitHub and source control features in Visual Studio Code. 

You'll see that the **GitHub Pull Requests and Issues** extension that we installed earlier also has access. You can revoke this access at any time. You can always sign out of your GitHub account in Visual Studio Code through the gear menu as well.

:::image type="content" source="../media/3-trusted-extensions.png" alt-text="The account menu in Visual Studio Code, showing the Manage Trusted Extensions option with many extensions enabled.":::

## GitHub features in Visual Studio Code

Because you've signed in, Visual Studio Code will now help you with starting and publishing a repository to your GitHub account with a push of a button. It will also let you search for repositories you've created on GitHub so you can clone them locally. 

There are even more GitHub features in the **GitHub Pull Requests and Issues** extension. In this module, we'll explore the built-in ones first.
