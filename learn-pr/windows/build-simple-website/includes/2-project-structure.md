There are different ways to create and manage website projects. Some variation occurs depending on the specific tools you have, and also the preferences of your organization. When creating a website, it's not uncommon for your project structure to change over time as it becomes more complicated. The key is to keep a semblance of organization, and there are common strategies to help. Large projects often require a higher degree of care and attention so that many people can keep everything straight.





## delete - Using the command line

You can use either the command line or code editor to establish a project folder and new files. To get started with the command line interface, open **Git Bash** or **Terminal**. So you can determine where to put your creations, you need to know a little about how to navigate through directories on your computer. Then you can conquer the world wide web!

### delete - Navigation

Your computer has a *root directory* or top-level folder that all other sub-folders originate. You also have a user or *home directory* that you create when you set up a new computer user. The CLI starts a new session in your home directory, which is denoted by a tilde `~` followed by your username. You can show part of the current directory *path* with the print working directory command `pwd`.

![Screenshot of Terminal print working directory command](../media/terminal-pwd.png)

To see the existing files and folders in a directory, use the list `ls` command. From your user directory or home folder, you should be able to see a list of folders such as **Desktop** and **Documents**. Navigate to the **Documents** folder by using the change directory `cd` command. Not too scary.

> [!TIP]
> On some command lines, you can start typing a directory, then press Tab to autocomplete the word.

Change directory `cd <DirectoryName>` lets you specify the folder you would like to enter, where `<DirectoryName>` is a folder that already exists. Enter `cd Documents` to open and `ls` to see it's content. To exit, or go up a level in the directory structure, you can use change directory followed by a space and two periods. Use the `cd ..` command followed by `ls` to safely return to the home directory. Travel to the Desktop with `cd Desktop` so you can create a new folder.

> [!TIP]
> If you somehow venture off the trail into the file system somewhere, use `cd ~` to return to your home directory. You can also type `cd` followed by a space, then drag a folder from the file system to locate and enter that path.

To create a new project folder, used the *make directory* command `mkdir` followed by a name, which in this case is `public`. The full command to create a directory is `mkdir public`. After creating the new directory, navigate into it using `cd public`.

![Screenshot of make directory named public](../media/terminal-mkdir.png)

### delete - Initializing Git

As mentioned previously, Git will magically track changes we make to a project. However, for file tracking to successfully occur, we need to initialize a *repository* (repo). A repo contains the necessary metadata to track our project and appears as a single folder named `.git`. Folders or files that start with a period are designated as hidden in the operating system, and may only be visible by changing preferences, using the command line, or viewing in a special program like an IDE.

To initialize our project as a Git repo, enter `git init`. If you try looking at your new creation with the `ls` command, it seems like nothing happened. We can utilize the built-in CLI manual by entering `man` followed by what we need help with `ls` or altogether `man ls`. There are quite a few options available, but `ls -a` or `ls -la` will provide the necessary details to show us hidden directories. Press lowercase *q* to quit the manual page. If you're feeling adventurous, enter the git directory with `cd .git` and take a look. When you're ready, return to the public folder with the `cd ..` command.

![Screenshot of initialize a Git repository](../media/terminal-git-init.png)
