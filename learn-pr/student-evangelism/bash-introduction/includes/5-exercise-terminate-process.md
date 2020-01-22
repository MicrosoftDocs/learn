Computers are imperfect. Sooner or later, something *will* go wrong. That's why you have a job as a sysadmin; it's up to you to troubleshoot and fix system problems.

Imagine that a Python application is causing problems. Perhaps it is taking up too much CPU time, or maybe it has frozen and stopped responding. In either case, you want to kill it off with extreme prejudice. To identify it, you can use `ps` and `grep`. Then, to knock it on its virtual head, you can use the `kill` command. Let's practice this in your Linux virtual machine.

## Start a misbehaving process

If you're going to kill a process, you need a process to kill. Let's create one.

1. In your Linux VM, type the following command to start Linux's [`vi`](https://wikipedia.org/wiki/Vi) editor:

	```bash
	vi bad.py
	```

	`vi` is a widely used text editor that Linux inherited from Unix. Love it or hate it, it pays for a sysadmin to know the basics of `vi`.

1. Press the **I** key to put `vi` in insert mode. Then type in the following Python program:

	```python
	i = 0
	while i == 0:
	    pass
	```

	This program, when executed, runs in an infinite loop — clearly not something you want running on your server.

1. After typing the program, press the **Esc** key to exit insert mode. Then type the following command followed by the **Enter** key to save the program and exit `vi`:

	```
	:wq
	```

	Be sure to include the colon at the beginning of the command. As for the remainder of the command, `w` stands for "write" and `q` stands for "quit."

1. Now use the following command to start the program and leave it running in the background:

	```bash
	python3 bad.py &
	```

	Be sure to include the ampersand at the end of the command. Otherwise, you won't return to the Bash prompt. In Bash, the ampersand executes a command and returns to the command line, even if the command hasn't finished running.

It's not obvious, but **bad.py** is now running in the background and stealing CPU cycles from other processes. Let's take a look under the hood to see what's happening.

## Kill the process

To kill a process, you need the process name or process ID. This is a job for `ps`.

1. To refresh your memory, a `ps -ef` command lists all running processes and displays a great deal of information about each. Use the following command to list all running processes and filter the results to those lines containing "python:"

	```bash
	ps -ef | grep python
	```

	The results should look something like this:

	```
	root        969      1  0 16:56 ?        00:00:00 /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
	root        972      1  0 16:56 ?        00:00:00 /usr/bin/python3 -u /usr/sbin/waagent -daemon
	root       1006      1  0 16:56 ?        00:00:00 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal
	root       1108    972  0 16:56 ?        00:00:23 python3 -u bin/WALinuxAgent-2.2.40-py2.7.egg -run-exthandlers
	azureus+  13079  12666 99 18:44 pts/1    00:23:33 python3 bad.py
	azureus+  14376  12666  0 19:08 pts/1    00:00:00 grep --color=auto python
	```

1. From the listing, it appears that **bad.py** is consuming 99% of the server's CPU time. The program is living up to its name.

	The `kill` command kills a running process given its process ID. (A related command named `killall` kills a process given the process name.) When you call `kill`, you have to decide what kind of "signal" to use to kill the process. Use the following command to display a list of signal types:

	```bash
	kill -l
	```

1. If you were killing a daemon process — one that runs in the background and provides vital services to the operating system — you might want to kill it and immediately restart it. To do that, you could use a SIGHUP signal, which kills and then restarts the process.

	In this example, you want to kill the process without restarting it. Therefore, you want to use the SIGKILL signal, which corresponds to the number 9. To that end, grab **bad.py**'s process ID from the `ps -ef` output (it's in the second column) and use the following command to terminate the process, replacing PROCESS_ID with the process ID:

	```bash
	kill -9 PROCESS_ID
	```

	The same command could also be entered as `kill -s SIGKILL PROCESS_ID`. Whether you use a signal's name or number is up to you.

1. Finish up by running `ps` again to confirm that **bad.py** is no longer running.

Another common use for `ps` and `kill` is to identify and terminate zombie processes, which are child processes left behind by poorly written programs. For more information, see https://wikipedia.org/wiki/Zombie_process.