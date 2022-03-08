:::image type="content" source="../media/centralized-strengths-best-used-2b567258.png" alt-text="Strengths include scaling, permissions, monitoring, file locking. Best used for large codebases, audit, and access, and hard to merge file types.":::


Centralized source control systems are based on the idea that there's a single "central" copy of your project somewhere (probably on a server). Programmers will check in (or commit) their changes to this central copy.

"Committing" a change means to record the difference in the central system. Other programmers can then see this change.

Also, it's possible to pull down the change. The version control tool will automatically update the contents of any files that were changed.

Most modern version control systems deal with "changesets," which are a group of changes (possibly too many files) that should be treated as a cohesive whole.

Programmers no longer must keep many copies of files on their hard drives manually. The version control tool can talk to the central copy and retrieve any version they need on the fly.

Some of the most common-centralized version control systems you may have heard of or used are Team Foundation Version Control (TFVC), CVS, Subversion (or SVN), and Perforce.

## A typical centralized source control workflow

If working with a centralized source control system, your workflow for adding a new feature or fixing a bug in your project will usually look something like this:

 -  Get the latest changes other people have made from the central server.
 -  Make your changes, and make sure they work correctly.
 -  Check in your changes to the main server so that other programmers can see them.
