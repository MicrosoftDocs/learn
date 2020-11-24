There are a variety of ways that you might be using GitHub with a project. Sometimes you clone a project to get a copy of it that you can work on. Sometimes, it goes the other direction and you have a local project that you want to put in GitHub. But before you can do anything at all with GitHub, you'll have to make sure you can authenticate. Normally, this can be a tedious, multistep process that involves generating and working with ssh keys. One of the benefits of using Visual Studio Code to work with GitHub is that it handles all of the authentication setup for you.

## Authenticate to GitHub with Visual Studio Code

You can select the accounts icon at the bottom of the activity bar and sign in with your GitHub account. A browser window will open and you'll be asked to grant permission for Visual Studio Code to access GitHub. This step is needed to connect Visual Studio Code to GitHub and doesn't store any sensitive information. Once you select **Continue**, you'll be redirected back to Visual Studio Code.

## What can access your GitHub account from Visual Studio Code

When you sign in to your GitHub account in Visual Studio Code, there are various extensions or parts of Visual Studio Code that can now access your GitHub account information. After you've signed in, you can choose which Visual Studio Code extensions are allowed to use your GitHub authentication.

To see all the extensions that are using your GitHub account., click on the account icon, select your GitHub user name, and choose "Manage Trusted Extensions". "GitHub" refers to the built-in GitHub and source control features in Visual Studio Code. You'll see that the GitHub Pull Requests and Issues extension we installed earlier also has access. This access can be revoked at any time. You can always sign out of your GitHub account in Visual Studio Code through the gear menu as well.

:::image type="content" source="../media/3-trusted-extensions.png" alt-text="The accounts menu in VS Code showing the manage trusted extensions option with many extensions enabled":::

## What GitHub features does Visual Studio Code provide?

Because you've signed in, Visual Studio Code will now help you with initializing and publishing a repository to your GitHub account with a push of a button. It will also let you search for repositories you've created on GitHub so you can clone them locally. There are even more GitHub features in the GitHub Pull Requests and Issues extension, but in this module, we'll explore the built-in ones first.
