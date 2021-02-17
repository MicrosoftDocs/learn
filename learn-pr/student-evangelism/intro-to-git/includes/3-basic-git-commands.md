Git works by remembering the changes to your files as if it's taking snapshots of your file system.

We'll cover a few basic commands to start tracking files in your repo, and then save your first "snapshot" for Git to compare against.

### git status

The first and most commonly used Git command is `git status`. You've already used it once in the previous exercise to see that you had initialized your Git repo properly.

`git status` displays the state of the working tree (and staging area—we'll talk more about the staging area later). It lets you see which changes are currently being tracked by Git, and so you can decide whether you want to ask Git to take another snapshot.

### git add

`git add` is the command you use to tell Git to start keeping track of changes in certain files.

The technical term is *staging* these changes. You'll use `git add` to stage changes to prepare for a commit. All changes in files that have been added, but not committed yet, are stored in the *staging area*.

### git commit

After you've staged some changes for commit, you can save your work into a snapshot by invoking the `git commit` command.

_Commit_ is both a verb and a noun. It has essentially the same meaning as when you commit to a plan or commit a change to a database. As a verb, committing changes means you put a copy (of the file, directory, or other "stuff") in the repository as a new version. As a noun, a commit is the small chunk of data that gives the changes you committed a unique identity. It includes the author's name and e-mail address, the date, comments about what you did (and why), an optional digital signature, and the unique identifier of the previous commit.

### git log

The `git log` command allows you to see information about previous commits. Each commit has a message attached to it (a commit message), and the `git log` command prints information about the most recent commits, like their time stamp, author, and message. This command helps you keep track of what you've been doing and what changes have been saved.

### git help

You've already tried out the `git help` command, but it's worth reminding you about it. This command lets you easily get information about all the commands you've learned so far, and more.

Remember, each command comes with its *own* help page, too. You can find these help pages by typing  `git <command> --help`. For example, `git commit --help` brings up a page that tells you more about the `git commit` command and how to use it.
