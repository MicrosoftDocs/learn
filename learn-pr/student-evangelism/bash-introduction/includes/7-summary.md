In this module, you learned the basics of using Bash. Among other things, you learned:

- How to use Azure Cloud Shell to create an Ubuntu Linux VM in Azure
- How to securely connect to the VM using SSH
- How Bash commands are structured
- Key Bash commands such as `ls`, `cat`, and `ps`
- How to use I/O operators in Bash commands to redirect input and output
- How to update the operating system on a Linux server
- How to find and terminate rogue processes
- How to use Bash to filter output in Cloud Shell
- How to delete an Azure resource group and everything it contains

If you want to take your knowledge of Bash to the next level, here are three books you might find valuable:

- [The Bash Guide](https://guide.bash.academy/)
- [Learn Shell](https://www.learnshell.org/)
- [Learning the Shell](http://linuxcommand.org/lc3_learning_the_shell.php)

Other notable books include [Learning the bash Shell, 3rd Edition](http://shop.oreilly.com/product/9780596009656.do), [The Linux Command Line](http://linuxcommand.org/tlcl.php), and [Advanced Bash-Scripting Guide](https://www.tldp.org/LDP/abs/html/).

## Check your knowledge

1. Bash is short for:
	- BAsic SHell
	- Bourne Again SHell
	- Better than All SHells
	- Bravo! Another SHell

1. Which of the following commands writes a list of processes associated with a user named "scottgu" to a file?
	- `cat | grep scottgu > processes.txt`
	- `cat > grep scottgu | processes.txt`
	- `pid -u > grep scottgu | processes.txt`
	- `ps -ef | grep scottgu > processes.txt`

1. Which of the following commands would you use to delete a subdirectory that isn't empty?
	- `rm`
	- `rmdir`
	- `nuke`
	- None of the above; a subdirectory that isn't empty can't be deleted

1. Which of the following commands reboots the server after 10 minutes?
	- `sudo shutdown -r +10` 
	- `sudo shutdown -r 10m` 
	- `sudo reboot +10` 
	- `sudo reboot +10m` 

1. Which of the following commands combines the contents of **foo.txt** and **bar.txt** into a new file named **foobar.txt**?
	- `concat foo.txt bar.txt > foobar.txt`
	- `concat foo.txt bar.txt | foobar.txt`
	- `cat foo.txt bar.txt | foobar.txt`
	- `cat foo.txt bar.txt > foobar.txt`

1. The purpose of the `sudo` command is to:
	- Execute a command with elevated privilege
	- Execute a program and leave it running in the background
	- Prevent system files from being deleted by non-administrative users
	- Prevent subdirectories from being deleted without confirmation

1. Which of the following statements is true regarding the command `python3 app.py &`?
	- It runs **app.py** after creating a restore point in the system
	- It runs **app.py** and prevents it from becoming a zombie process
	- It runs **app.py**, but only if it's located in the "/etc" directory
	- It runs **app.py** and returns immediately to the command prompt

1. Which of the following `vi` commands saves a file?
	- :q
	- :s
	- :w
	- None of the above
