Continuous delivery demands a significant level of automation. You can't be continuously delivering if you don't have a quality codebase. It's where git fares so well.

It lets you automate most of the checks in your codebase. Before committing the code into your local repository, let alone the remote.

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
 -  Preventing you & your team from committing faulty code
 -  Sending notifications to your team's chat room (Teams, Slack, HipChat, etc.)

In the next unit, you will see how to implement Git Hooks.
