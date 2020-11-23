When you are working with source control, you might find yourself in any one of dozens of scenarios. Sometimes a repository already exists, and you want to get a copy of it. Sometimes you aren't sure where the project is that you need or what it's name it, and you need to find it. Other times you need more advanced tools like being able to see the history of a paticular file. Regardless of what you're working on with GitHub, Visual Studio Code (VS Code) can make your workflow smoother. In this module, you'll discover how VS Code simplifies working with GitHub by automating things like authentication, publishing and cloning.

Before you can do anything at all with GitHub, you'll have to make sure you can authenticate. Normally, this can be a tedious, mult-step process that involves generating and working with ssh keys. One of the big benefits of using VS Code to work with GitHub is that it handles all of the authentication setup for you.

## Authenticate to GitHub with VS Code

You can select the accounts icon at the bottom of the activity bar and sign in with your GitHub account. A browser window will open and you'll be asked to grant permission for VS Code to access GitHub. This step is needed to connect VS Code to GitHub and doesn't store any sensitive information. Once you select **Continue**, you'll be redirected back to VS Code.

## What can access your Github account from VS Code

When you sign in to your GitHub account in VS Code, there are various extensions or parts of VS Code that can now access your GitHub account information. After you've signed in, you can choose which VS Code extensions are allowed to use your GitHub authentication.

To see all the extensions that are using your GitHub account., click on the account icon, select your GitHub user name, and choose "Manage Trusted Extensions". "GitHub" refers to the built-in GitHub and source control features in VS Code. You'll see that the GitHub Pull Requests and Issues extension we installed earlier also has access. This access can be revoked at any time. You can always sign out of your GitHub account in VS Code through the gear menu as well.

:::image type="content" source="../media/3-trusted-extensions.png" alt-text="The Manage Trusted Extensions menu":::

## What GitHub features does VS Code provide?

Because you've signed in, VS Code will now help you with initializing and publishing a repository to your GitHub account with a push of a button. It will also let you search for repositories you've created on GitHub so you can clone them locally. There are even more GitHub features in the GitHub Pull Requests and Issues extension, but in this module, we'll explore the built-in ones first.
