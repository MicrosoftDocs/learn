When pushing quality into the development process, developing code locally, you want developers to identify and catch code quality issues. It's even before raising the pull request to trigger the branch policies.

Git hooks allow you to run custom scripts whenever certain important events occur in the Git life cycle—for example, committing, merging, and pushing.

Git ships with several sample hook scripts in the repo .git\\hooks directory. Git executes the contents on the particular occasion type they're approached. You can do practically anything with Git hooks.

Here are a few instances of where you can use Git hooks to uphold arrangements, guarantee consistency, and control your environment:

 -  Enforcing preconditions for merging
 -  Verifying work Item ID association in your commit message Preventing you and your team from committing faulty code
 -  Sending notifications to your team's chat room (Teams, Slack, HipChat)

In this recipe, we'll use the pre-commit Git hook to scan the commit for keywords from a predefined list to block the commit if it contains any of these keywords.

## Getting ready

Let's start by exploring client-side Git hooks. Navigate to the repo .git\\hooks directory – you'll find that there are a bunch of samples, but they're disabled by default.

:::image type="content" source="../media/git-hook-files-8bce9eb8.png" alt-text="Screenshot of Git hook files for automation.":::


> [!NOTE]
> If you open that folder, you'll find a file called pre-commit.sample. To enable it, rename it to pre-commit by removing the .sample extension and making the script executable.

The script is found and executed when you attempt to commit using git commit. You commit successfully if your pre-commit script exits with a 0 (zero). Otherwise, the commit fails. If you're using Windows, simply renaming the file won't work.

Git will fail to find the shell in the chosen path specified in the script.

The problem is lurking in the first line of the script, the shebang declaration:

```Bash
#!/bin/sh
```

On Unix-like OSs, the \#! Tells the program loader that it's a script to be interpreted, and /bin/sh is the path to the interpreter you want to use, sh in this case.

Windows isn't a Unix-like OS. Git for Windows supports Bash commands and shell scripts via Cygwin.

By default, what does it find when it looks for sh.exe at /bin/sh?

Nothing, nothing at all. Fix it by providing the path to the sh executable on your system. It's using the 64-bit version of Git for Windows, so the baseline looks like this:

```Bash
#!C:/Program\ Files/Git/usr/bin/sh.exe
```

## How to do it

How could Git hooks stop you from accidentally leaking Amazon AWS access keys to GitHub?

You can invoke a script at pre-commit.

Using Git hooks to scan the increment of code being committed into your local repository for specific keywords:

Replace the code in this pre-commit shell file with the following code.

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

You can branch off to a different file by referring to it here to encrypt or scramble if you want to.

## How it works

The Git diff-index identifies the code increment committed in the script. This increment is then compared against the list of specified keywords. If any matches are found, an error is raised to block the commit; the script returns an error message with the list of matches. The pre-commit script doesn't return 0 (zero), which means the commit fails.

## There's more

The repo .git\\hooks folder isn't committed into source control. You may wonder how you share the goodness of the automated scripts you create with the team.

The good news is that, from Git version 2.9, you can now map Git hooks to a folder that can be committed into source control.

You could do that by updating the global settings configuration for your Git repository:

```Cmd
Git config --global core.hooksPath '~/.githooks'
```

If you ever need to overwrite the Git hooks you have set up on the client-side, you can do so by using the no-verify switch:

```Cmd
Git commit --no-verify
```

## Server-side service hooks with Azure Repos

So far, we've looked at the client-side Git Hooks on Windows. Azure Repos also exposes server-side hooks. Azure DevOps uses the exact mechanism itself to create Pull requests. You can read more about it at the [Server hooks event reference](/azure/devops/service-hooks/events).
