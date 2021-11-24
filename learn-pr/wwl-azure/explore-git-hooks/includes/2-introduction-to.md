Continuous delivery demands a significant level of automation. You can't be continuously delivering if you don't have a quality codebase. It's where git fares so well.

It lets you automate most of the checks in your codebase. Even before committing the code into your local repository, let alone the remote.

## Git hooks

Git hooks are a mechanism that allows code to be run before or after certain Git lifecycle events.

For example, one could hook into the commit-msg event to validate that the commit message structure follows the recommended format.

The hooks can be any executable code, including shell, PowerShell, Python, or other scripts. Or they may be a binary executable. Anything goes!

The only criteria are that hooks must be stored in the .git/hooks folder in the repo root. Also, they must be named to match the related events (Git 2.x):

 -  applypatch-msg
 -  pre-applypatch
 -  post-applypatch
 -  pre-commit
 -  prepare-commit-msg
 -  commit-msg
 -  post-commit
 -  pre-rebase
 -  post-checkout
 -  post-merge
 -  pre-receive
 -  update
 -  post-receive
 -  post-update
 -  pre-auto-gc
 -  post-rewrite
 -  pre-push

## Practical use cases for using Git hooks

Since Git hooks execute the scripts on the specific event type they're called on, you can do much anything with Git hooks.

Some examples of where you can use hooks to enforce policies, ensure consistency, and control your environment:

 -  In Enforcing preconditions for merging
 -  Verifying work Item ID association in your commit message
 -  Preventing you &amp; your team from committing faulty code
 -  Sending notifications to your team's chat room (Teams, Slack, HipChat, and so on.)

## So, where do I start?

Let's start by exploring client-side Git hooks.

Navigate to the repo.git\\hooks directory.

You'll find that there are a bunch of samples, but they're disabled by default.

For instance, if you open that folder, you'll find a file called pre-commit.sample.

To enable it, rename it to pre-commit by removing the .sample extension and making the script executable.

When you attempt to commit using git commit, the script is found and executed.

If your pre-commit script exits with a 0 (zero), you commit successfully. Otherwise, the commit fails.

:::image type="content" source="../media/git-hook-files-8bce9eb8.png" alt-text="Screenshot of Git hook files.":::


Git hooks on Windows!

Now, if you are on Windows, simply renaming the file won't work. Git will fail to find a shell in the chosen path as specified in the script. The problem was lurking in the first line of the script, the shebang declaration:

```Bash
#!/bin/sh

```

On Unix-like OSs, the \#! Tells the program loader that it's a script to be interpreted, and /bin/sh is the path to the interpreter you want to use, sh in this case.

Windows isn't a Unix-like OS. Git for Windows supports Bash commands and shell scripts via Cygwin. By default, what does it find when it looks for sh.exe at /bin/sh?

Nothing, nothing at all.

Fix it by providing the path to the sh executable on your system. It's using the 64-bit version of Git for Windows, the bash line looks like this.

```Bash
#!C:/Program\ Files/Git/usr/bin/sh.exe

```

## PreCommit Git Hook to scan commit for keywords

How can Git hooks help with security?

You can invoke a script at pre-commit using Git hooks to scan the increment of code being committed into your local repository for specific keywords.

Replace the code in this pre-commit shell file with the below code.

```Bash
#!C:/Program\ Files/Git/usr/bin/sh.exe
matches=$(git diff-index --patch HEAD | grep '^+' | grep -Pi 'password|keyword2|keyword3')
if [ ! -z "$matches" ]
then
    cat <<\EOT
Error: Words from the blocked list were present in the diff:
EOT
    echo $matches
    exit 1 
fi

```

You don't have to build the complete keyword scan list in this script.

You can branch off to a different file by referring it here to encrypt or scramble if you want to.

The repo .git\\hooks folder isn't committed to source control, so you may ask how you share the goodness of the automated scripts you create with the team?

The good news is that from Git version 2.9, you can now map Git hooks to a folder that can be committed into source control.

You could do that by updating the global settings configuration for your git repository.

```Cmd
git config --global core.hooksPath '~/.GitHooks'

```

If you ever need to overwrite the Git Hooks, you have set up on the client-side. Also, you could do so by using the no-verify switch.

```Cmd
git commit --no-verify

```

## Server-side service hooks with Azure Repos

So far, we've looked at the client-side Git Hooks on Windows. Azure Repos also exposes server-side hooks. Azure DevOps uses the exact mechanism itself to create Pull requests. You can read more about it at the [Server hooks event reference](/azure/devops/service-hooks/events).
