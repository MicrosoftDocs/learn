:::image type="content" source="../media/image-dcf15bbf-67c0-4464-ac17-34da5ba1ea9a-2b2b2be3.png" alt-text="Strengths include scaling, permissions, monitoring, file locking. Best used for large codebases, audit, and access, and hard to merge file types.":::


Centralized source control systems are based on the idea that there is a single "central" copy of your project somewhere (probably on a server). Programmers will check in (or commit) their changes to this central copy.

"Committing" a change means recording the difference in the central system. Other programmers can then see this change.

Also, it is possible to pull down the change. The version control tool will automatically update the contents of any files that were changed.

Most modern version control systems deal with "changesets," which are a group of changes (possibly-too-many files) that should be treated as a cohesive whole.

For example, changing a C header file and the corresponding ".C" file will keep it together.

Programmers no longer must keep many copies of files on their hard drives manually. The version control tool can talk to the central copy and retrieve any version they need on the fly.

Some of the most common-centralized version control systems you may have heard of or used are TFVC, CVS, Subversion (or SVN), and Perforce.

## A typical centralized source control workflow

Working with a centralized source control system, your workflow for adding a new feature or fixing a bug in your project will usually look something like this:

 -  Get the latest changes other people have made from the central server.
 -  Make your changes, and make sure they work correctly.
 -  Check in your changes to the main server so that other programmers can see them.
