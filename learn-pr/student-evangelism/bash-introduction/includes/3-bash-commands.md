Every shell language has its most-used commands. Let's start building your Bash repertoire by examining the most commonly used commands.

## Bash commands

Let's look at common Bash commands and how to use them.

### `ls` command

`ls` lists the contents of your current directory or the directory specified in an argument to the command. By itself, it lists the files and directories in the current directory:

```bash
ls
```

Files and directories whose names begin with a period are hidden by default. To include these items in a directory listing, use an `-a` flag:

```bash
ls -a
```

To get even more information about the files and directories in the current directory, use an `-l` flag:

```bash
ls -l
```

Here's some sample output from a directory that contains a handful of JPEGs and PNGs and a subdirectory named **gifs**:

```output
-rw-rw-r-- 1 azureuser azureuser  473774 Jun 13 15:38 0001.png
-rw-rw-r-- 1 azureuser azureuser 1557965 Jun 13 14:43 0002.jpg
-rw-rw-r-- 1 azureuser azureuser  473774 Mar 26 09:21 0003.png
-rw-rw-r-- 1 azureuser azureuser 4193680 Jun 13 09:40 0004.jpg
-rw-rw-r-- 1 azureuser azureuser  423325 Jun 10 12:53 0005.jpg
-rw-rw-r-- 1 azureuser azureuser 2278001 Jun 12 04:21 0006.jpg
-rw-rw-r-- 1 azureuser azureuser 1220517 Jun 13 14:44 0007.jpg
drwxrwxr-x 2 azureuser azureuser    4096 Jun 13 20:16 gifs
```

Each line provides detailed information about the corresponding file or directory. That information includes the permissions assigned to it, its owner, its size in bytes, the last time it was modified, and the file or directory name.

### `cat` command

Suppose you want to see what's inside a file. You can use the `cat` command for that. The output won't make much sense unless the file is a text file. The following command shows the contents of the **os-release** file stored in the **/etc** directory:

```bash
cat /etc/os-release
```

This is a useful command because it tells you which Linux distribution you're running:

```output
NAME="Ubuntu"
VERSION="18.04.2 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.2 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
```

The **/etc** directory is a special one in Linux. It contains system-configuration files. You don't want to delete any files from this directory unless you know what you're doing.

### `sudo` command

Some Bash commands can only be run by the root user; a system administrator or superuser. If you try one of these commands without sufficient privileges, it fails. For example, only users logged in as a superuser can use `cat` to display the contents of **/etc/at.deny**:

```bash
cat /etc/at.deny
```

**at.deny** is a special file that determines who can use other Bash commands to submit jobs for later execution.

You don't want to run as root most of the time; it's too dangerous. To run commands that require admin privilege without logging in as a superuser, you'll preface the commands with `sudo`:

```bash
sudo cat /etc/at.deny
```

`sudo` stands for "superuser do." When you use it, you're telling the shell that for this one command, you're acting with the root-user level of permission.

### `cd`, `mkdir`, and `rmdir` commands

`cd` stands for "change directory," and it does exactly what the name suggests: it changes the current directory to another directory. It enables you to move from one directory to another just like its counterpart in Windows. The following command changes to a subdirectory of the current directory named **orders**:

```bash
cd orders
```

You can move up a directory by specifying `..` as the directory name:

```bash
cd ..
```

This command changes to your home directory; the one you land in when you first log in:

```bash
cd ~
```

You can create directories by using the `mkdir` command. The following command creates a subdirectory named **orders** in the current working directory:

```bash
mkdir orders
```

If you want to create a subdirectory and another subdirectory under it with one command, use the `--parents` flag:

```bash
mkdir --parents orders/2019
```

The `rmdir` command deletes (removes) a directory, but only if it's empty. If it's not empty, you'll get a warning instead. Fortunately, you can use the `rm` command to delete directories that aren't empty in combination with the `-r` (recursive) flag. The command would then look like so, `rm -r`.

### `rm` command

The `rm` command is short for "remove." As you'd expect, `rm` deletes files. So this command puts an end to **0001.jpg**:

```bash
rm 0001.jpg
```

And this command deletes all the files in the current directory:

```bash
rm *
```

Be wary of `rm`. It's a dangerous command.

Running `rm` with a `-i` flag lets you think before you delete:

```bash
rm -i *
```

Make it a habit to include `-i` in every `rm` command, and you might avoid falling victim to one of Linux's biggest blunders. The dreaded `rm -rf /` command deletes every file on an entire drive. It works by recursively deleting all the subdirectories of root and their subdirectories. The `-f` (for "force") flag compounds the problem by suppressing prompts. *Don't do this.*

If you want to delete a subdirectory named **orders** that isn't empty, you can use the `rm` command this way:

```bash
rm -r orders
```

This deletes the **orders** subdirectory and everything in it, including other subdirectories.

### `cp` command

The `cp` command copies not just files, but entire directories (and subdirectories) if you want. To make a copy of **0001.jpg** named **0002.jpg**, use this command:

```bash
cp 0001.jpg 0002.jpg
```

If **0002.jpg** already exists, Bash silently replaces it. That's great if it's what you intended, but not so wonderful if you didn't realize you were about to overwrite the old version. 

Fortunately, if you use the `-i` (for "interactive") flag, Bash warns you before deleting existing files. This is much safer:

```bash
cp -i 0001.jpg 0002.jpg
```

Of course, you can use wildcards to copy several files at once. To copy all the files in the current directory to a subdirectory named **photos**, do this:

```bash
cp * photos
```

To copy all the files in a subdirectory named **photos** into a subdirectory named **images**, do this:

```bash
cp photos/* images
```

This assumes that the **images** directory already exists. If it doesn't, you can create it *and* copy the contents of the **photos** directory by using this command:

```bash
cp -r photos images
```

The `-r` stands for "recursive." An added benefit of the `-r` flag is that if **photos** contains subdirectories of its own, they too are copied to the **images** directory.

### `ps` command

The `ps` command gives you a snapshot of all the currently running processes. By itself, with no arguments, it shows all your shell processes; in other words, not much. But it's a different story when you include a `-e` flag:

```bash
ps -e
```

`-e` lists *all* running processes, and there are typically many of them.

For a more comprehensive look at what processes are running in the system, use the `-ef` flag:

```bash
ps -ef 
```

This flag shows the names of all the running processes, their process identification numbers (PIDs), the PIDs of their parents (PPIDs), and when they began (STIME). It also shows what terminal, if any, they're attached to (TTY), how much CPU time they've racked up (TIME), and their full path names. Here is an abbreviated example:

```
UID         PID   PPID  C STIME TTY          TIME CMD
root          1      0  0 13:35 ?        00:00:03 /sbin/init
root          2      0  0 13:35 ?        00:00:00 [kthreadd]
root          3      2  0 13:35 ?        00:00:00 [rcu_gp]
root          4      2  0 13:35 ?        00:00:00 [rcu_par_gp]
root          5      2  0 13:35 ?        00:00:00 [kworker/0:0-cgr]
root          6      2  0 13:35 ?        00:00:00 [kworker/0:0H-kb]
root          8      2  0 13:35 ?        00:00:00 [mm_percpu_wq]
root          9      2  0 13:35 ?        00:00:01 [ksoftirqd/0]
root         10      2  0 13:35 ?        00:00:02 [rcu_sched]
```

As an aside, you might find documentation that shows `ps` being used this way:

```bash
ps aux
```

`ps aux` and `ps -ef` are the same. This duality traces back to historical differences between POSIX Unix systems (of which Linux is one) and BSD Unix systems (the most common of which is macOS). In the beginning, POSIX used `-ef` while the BSD required `aux`. Today, both operating-system families accept either format.

This serves as an excellent reminder of why you should look closely at the manual for all Linux commands. Learning Bash is like learning English as a second language. There are many exceptions to the rules.

### `w` command

Users come, users go, and sometimes you get users you don't want at all. When an employee leaves to pursue other opportunities, the sysadmin is called upon to ensure that the worker can no longer log in to the company's computer systems. Sysadmins are also expected to know who's logged in, and who shouldn't be.

To find out who's on your servers, Linux provides the `w` (for "who") command. It displays information about the users currently on the computer system and those users' activities. `w` shows user names, their IP addresses, when they logged in, what processes they're currently running, and how much time those processes are consuming. It's a valuable tool for sysadmins.

## Bash I/O operators

You can do a lot in Linux just by exercising Bash commands and their many options. But you can really get work done when you combine commands by using I/O operators:

- `<` for redirecting input to a source other than the keyboard
- `>` for redirecting output to destination other than the screen
- `>>` for doing the same, but appending rather than overwriting
- `|` for piping output from one command to the input of another

Suppose you want to list everything in the current directory but capture the output in a file named **listing.txt**. The following command does just that:

```bash
ls > listing.txt
```

If **listing.txt** already exists, it gets overwritten. If you use the `>>` operator instead, the output from `ls` is appended to what's already in **listing.txt**:

```bash
ls >> listing.txt
```

The piping operator is extremely powerful (and often used). It redirects the output of the first command to the input of the second command. Let's say you use `cat` to display the contents of a large file, but the content scrolls by too quickly for you to read. You can make the output more manageable by piping the results to another command such as `more`. The following command lists all the currently running processes. But once the screen is full, the output pauses until you select **Enter** to show the next line:

```bash
ps -ef | more
```

You can also pipe output to `head` to see just the first several lines:

```bash
ps -ef | head
```

Or suppose you want to filter the output to include only the lines that contain the word "daemon." One way to do that is by piping the output from `ps` to Linux's useful `grep` tool:

```bash
ps -ef | grep daemon
```

The output might look like this:

```output
azureus+  52463  50702  0 23:28 pts/0    00:00:00 grep --color=auto deamon
azureuser@bash-vm:~$ ps -ef | grep daemon
root        449      1  0 13:35 ?        00:00:17 /usr/lib/linux-tools/4.18.0-1018-azure/hv_kvp_daemon -n
root        988      1  0 13:35 ?        00:00:00 /usr/lib/accountsservice/accounts-daemon
message+   1002      1  0 13:35 ?        00:00:00 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
daemon     1035      1  0 13:35 ?        00:00:00 /usr/sbin/atd -f
root       1037      1  0 13:35 ?        00:00:00 /usr/bin/python3 -u /usr/sbin/waagent -daemon
root       1039      1  0 13:35 ?        00:00:00 /usr/lib/linux-tools/4.18.0-1018-azure/hv_vss_daemon -n
azureus+  52477  50702  0 23:28 pts/0    00:00:00 grep --color=auto daemon
```

You can also use files as input. By default, standard input comes from the keyboard, but it too can be redirected. To get input from a file instead of the keyboard, use the `<` operator. One common sysadmin task is to sort the contents of a file. As the name suggests, `sort` sorts text in alphabetical order:

```bash
sort < file.txt
```

To save the sorted results to a new file, you can redirect input *and* output:

```bash
sort < file.txt > sorted_file.txt
```

You can use I/O operators to chain Linux commands as needed. Consider the following command:

```bash
cat file.txt | fmt | pr | lpr
```

The output from `cat` goes to `fmt`, the output from `fmt` goes to `pr`, and so on. `fmt` formats the results into a tidy paragraph. `pr` paginates the results. And `lpr` sends the paginated output to the printer. All in a single line!
