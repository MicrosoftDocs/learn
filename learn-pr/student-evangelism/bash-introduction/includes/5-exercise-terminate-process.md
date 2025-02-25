Computers are imperfect. Sooner or later, something *will* go wrong. That's why you have a job as a sysadmin; it's up to you to troubleshoot and fix system problems.

Imagine that a Python application is causing problems. Perhaps it's taking up too much CPU time, or maybe it stopped responding. In either case, you want to stop the application. To identify a process or application, you can use `ps` and `grep`. Then, to stop it, you can use the `kill` command. Let's practice this in your Linux virtual machine.

## Start a misbehaving process

If you're going to kill a process, you need a process to kill. Let's create one.

1. Get back to your home base by typing the following command:

    ```bash
    cd ~
    ```

1. In Azure Cloud Shell, enter the following command to start Linux's [`vi`](https://wikipedia.org/wiki/Vi) editor:

    ```bash
    vi bad.py
    ```

    `vi` is a widely used text editor that Linux inherited from Unix. Love it or hate it, a Bash user needs to know the basics of `vi`.

1. Select the **i** key to put `vi` in insert mode. Then type in the following Python program:

    ```python
    i = 0
    while i == 0:
        pass
    ```

    This program, when executed, runs in an infinite loop—clearly not something you want running on your server.

1. Select the **Esc** key to exit insert mode. Then type the following command followed by the **Enter** key to save the program and exit `vi`:

    ```vim
    :wq
    ```

    Be sure to include the colon at the beginning of the command. As for the remainder of the command, `w` stands for "write" and `q` stands for "quit."

1. Now use the following command to start the program and leave it running in the background:

    ```bash
    python3 bad.py &
    ```

    Be sure to include the ampersand (`&`) at the end of the command. Otherwise, you won't return to the Bash prompt. In Bash, the ampersand runs a command and returns to the command line, even if the command hasn't finished running.

It's not obvious, but **bad.py** is now running in the background and stealing CPU cycles from other processes. Let's take a close look at what's happening.

## Kill the process

To kill a process, you need the process name or process ID. This is a job for `ps`.

1. To refresh your memory, a `ps -ef` command lists all running processes and displays a great deal of information about each. Use the following command to list all running processes and filter the results to lines that contain "python":

    ```bash
    ps -ef | grep python
    ```

    The results should look something like this:

    ```output
    yourname+    342    254 99 23:34 pts/1    00:00:31 python3 bad.py
    yourname+    344    254  0 23:35 pts/1    00:00:00 grep --color=auto python
    ```

1. From the listing, it appears that **bad.py** is consuming 99 percent of the server's CPU time. The program is living up to its name.

    The `kill` command kills a running process based on its process ID. (A related command named `killall` kills a process based on the process name.) When you call `kill`, you have to decide what kind of "signal" to use to kill the process. Use the following command to display a list of signal types:

    ```bash
    kill -l
    ```

1. If you were killing a daemon process—one that runs in the background and provides vital services to the operating system—you might want to kill it and immediately restart it. To do that, you could use a `SIGHUP` signal.

    In this example, you want to kill the process without restarting it. Therefore, you want to use the `SIGKILL` signal, which corresponds to the number 9. To that end, grab **bad.py**'s process ID from the `ps -ef` output (it's in the second column) and use the following command to terminate the process. Replace `PROCESS_ID` with the process ID.

    ```bash
    kill -9 PROCESS_ID
    ```

    The same command can also be entered as `kill -s SIGKILL PROCESS_ID`. Whether you use a signal's name or number is up to you.

1. Finish by running `ps` again to confirm that **bad.py** is no longer running.

Another common use for `ps` and `kill` is to identify and terminate "zombie processes," which are child processes left behind by poorly written programs.
