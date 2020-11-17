To make it easier for you to start working on a GitHub project, you can authenticate with your GitHub account inside Visual Studio Code.

## How can I authenticate with GitHub?

You can select the accounts icon at the bottom of the activity bar and sign in with your GitHub account. A browser window will open and you'll be asked to grant permission for VS Code to access GitHub. This step is needed to connect VS Code to GitHub and doesn't store any sensitive information. Once you select "Continue", you'll be redirected back to VS Code.  

## What is VS Code doing with this authorization?

When you sign in to your GitHub account in VS Code, there are various extensions or parts of VS Code that can now access your GitHub account information. After you've signed in, you can choose which VS Code extensions are allowed to use your GitHub authentication. 

When you select the account icon, select your GitHub user name, and choose "Manage Trusted Extensions". You can see all the extensions that are using your GitHub account. "GitHub" refers to the built-in GitHub and source control features in VS Code. You'll also see the GitHub Pull Requests and Issues extension we installed earlier also has access. The access that the GitHub Issues and Pull Requests extension has can be revoked at any time. You can always sign out of your GitHub account in VS Code through the gear menu as well. 

![Trusted extensions](../media/3-trusted-extensions.png)

## What GitHub features does VS Code provide?

Because you've signed in, VS Code will now help you with initializing and publishing a repository to your GitHub account with a push of a button. It will also let you search for repositories you've created on GitHub so you can clone them locally. There are even more GitHub features in the GitHub Pull Requests and Issues extension, but in this module, we'll explore the built-in ones first.


