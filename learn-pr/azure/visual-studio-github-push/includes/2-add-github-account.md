There are different ways that you might use GitHub with a project. Sometimes you clone a project to get a copy of it, that you can later work on. Sometimes it goes the other direction: you have a local project that you want to put in GitHub.

Before you do anything at all with GitHub, you have to make sure that you're authenticated. GitHub needs to know who you are so it can give you access to the right repositories.

Normally, authentication can be a tedious, multiple-step process that involves generating and working with SSH keys. One benefit of using Visual Studio to work with GitHub is that the IDE handles all the authentication setup for you.

:::image type="content" source="../media/2-sign-in.png" alt-text="Screenshot of the Visual Studio default sign-in dialog.":::

## Adding an account to Visual Studio

In Visual Studio, you normally have a single personalization account that you use to sign in to the IDE. However, you can add multiple accounts to Visual Studio so that you can access the resources from any account without having to sign in to it separately. This set of accounts is called your Visual Studio keychain. Your keychain roams with you if you sign in to Visual Studio on another machine.

:::image type="content" source="../media/2-keychain-diagram.png" alt-text="Diagram of the various Visual Studio keychain accounts that can be used to sign in.":::

You can add only one GitHub account to Visual Studio. If you need to access resources from a different GitHub account, you first have to remove any existing GitHub account from Visual Studio and sign out from the web (GitHub.com). Then you can restart the process for adding the other GitHub account to Visual Studio.

## GitHub authentication in Visual Studio

When you sign in with your GitHub account, Visual Studio stores those credentials securely and can help you access GitHub features. Visual Studio lets you browse private and public GitHub repositories to clone local copies or to create new repositories in GitHub. You can use integrated Git functionality to pull from and push to remote GitHub repositories.

:::image type="content" source="../media/2-signed-in.png" alt-text="Screenshot of the Visual Studio dialog for account settings, with the user signed in.":::
