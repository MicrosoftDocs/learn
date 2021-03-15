<!-- Guidance on writing the opening to a content/conceptual unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-learning-unit-introduction-format -->

There are different kinds of ways that you might use GitHub with a project. Sometimes you clone a project to get a copy of it you can work on. Sometimes, it goes the other direction and you have a local project you want to put in GitHub.

Before you do anything at all with GitHub, you have to make sure that you are authenticated. GitHub needs to know who you are so it can give you access to the right repositories. Normally, authentication can be a tedious, multi-step process that involves generating and working with SSH keys. One benefit of using Visual Studio to work with GitHub is that the IDE handles all the authentication setup for you.

## Add an account to Visual Studio

In Visual Studio 2019, you normally have a single Personalization Account that you use to sign in to the IDE. However, you can add multiple accounts to Visual Studio so that you can access the resources from any account without having to sign in to it separately. This set of accounts is called your Visual Studio keychain. Your keychain roams with you if you sign in to Visual Studio on another machine.

You can add only one GitHub account to Visual Studio. If you need to access resources from a different GitHub account, you first have to remove any existing GitHub account from Visual Studio and sign out from the web (GitHub.com). Then you can restart the process for adding the other GitHub account to Visual Studio.

## GitHub Authentication in Visual Studio

When you sign in with your GitHub account, Visual Studio will store those credentials securely and can now help you access GitHub features. Visual Studio will let you browse private and public GitHub repositories to clone local copies or create new repositories in GitHub. You can use integrated Git functionality to pull from and push to remote GitHub repositories. 

<!-- 
Resources: 
https://docs.microsoft.com/en-us/visualstudio/ide/work-with-github-accounts?view=vs-2019

-->
