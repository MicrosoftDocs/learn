What if you need to migrate more than a single branch and keep branch relationships? Or are you going to drag all the history with you?

In that case, you're going to have to use **GIT-TFS**. It's an open-source project built to synchronize Git and TFVC repositories.

But you can do a once-off migration using the Git TFS clone.

**GIT-TFS** has the advantage that it can migrate multiple branches and preserve the relationships to merge branches in Git after you migrate.

Be warned that doing this conversion can take a while - especially for large or long-history repositories.

You can quickly dry-run the migration locally, iron out any issues, and then do it for real. There are lots of flexibilities with this tool.

If you are on Subversion, you can use **GIT-SVN** to import your Subversion repo similarly to **GIT-TFS**.

## Migrating from TFVC to Git using GIT-TFS

If Chocolatey is already installed on your computer, run `choco install gittfs`

Add the GIT-TFS folder path to your PATH. You could also set it temporary (the time of your current terminal session) using: `set PATH=%PATH%;%cd%\GitTfs\bin\Debug`

You need .NET 4.5.2 and maybe the 2012 or 2013 version of Team Explorer (or Visual Studio). It depends on the version of Azure DevOps you want to target.

Clone the whole repository (wait for a while.) :

`git tfs clone http://tfs:8080/tfs/DefaultCollection $/some_project`

Advanced use cases of cloning the TFVC repository into Git are [documented here](https://github.com/git-tfs/git-tfs/blob/master/doc/commands/clone.md).

```Cmd
cd some_project
git log







```
