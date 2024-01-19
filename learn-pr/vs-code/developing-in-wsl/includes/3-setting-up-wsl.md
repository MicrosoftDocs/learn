Installing WSL can be accomplished in just a few steps. We’ll be using the `wsl –install command`. This command will enable the features necessary to run WSL and install the Ubuntu distribution of Linux. 

> [!NOTE]
> You must make sure that you're running Windows 11 or Windows 10 version 2004+ (Build 19041 and higher) to run the WSL install command.

We'll also be creating a Python project to later use in VS Code.

Another thing to note, though this module is focused on how we can leverage WSL and VS Code, WSL install is independent of VS Code, and you can use WSL anywhere and on its own. 

## Installing WSL and a Linux Distribution 

:::image type="content" source="../media/3-wsl-install.png" alt-text="Screenshot of the Windows terminal and the wsl install command.":::

### Enable the Windows Subsystem for Linux: 

1. Open PowerShell as Administrator and run: `wsl --install` in the terminal.

    This command enables the necessary Windows features and installs the Ubuntu distribution by default. You can later choose to install a different Linux Distribution. Given its popularity, we’ll be using Ubuntu for this module.  

2. Restart Your Computer: A restart is required to complete the installation and apply changes. 

### Set Up Your Linux Distribution: 

A Linux distribution (distro) is a customized version of the Linux operating system with a specific set of software packages and configurations tailored for different purposes or user preferences. Ubuntu is a popular Linux distro known for its user-friendly interface and extensive software ecosystem, making it an accessible choice for many users. 

1. Upon restart, open the newly installed Linux distribution from the Start menu. 

2. Follow the prompts to create a user account and password for your Linux distribution. 

## Creating a Python Project

Many languages work in WSL and for this module we’ve selected Python. It’s a great language for beginners because it has a simple and readable syntax, offers a wide range of libraries and resources, and has a large and supportive community, making it easy for beginners to find help and resources when they encounter challenges. 

### Install Python 

Python should be installed by default on your WSL distro. To verify, run: `python3 –version` in your WSL terminal. If you do not see a version displayed then run the following: 

1. `sudo apt update`
2. `sudo apt install python3 python3-pip` 

### The WSL Filesystem 

Now we will need to create a folder for our project. When working in WSL, files are stored in the WSL file system. Both your Windows and Linux files are stored on the same physical hard drive. However, they exist in separate file systems: 

- **WSL File System:** Here, the files are stored in a Linux-compatible format. This system is separate from the native Windows file system and is designed to support Linux operations and tools. 

- **Windows File System:** This is the standard file system used by Windows, optimized for Windows applications and tools. 
 
Although both file systems coexist on the same physical drive, it's important to manage files within their respective environments to maintain compatibility and performance. 

WSL allows access to Windows files, but for development, especially with tools like VS Code, it’s recommended to store and manage files in the WSL file system. 

### Creating a folder in WSL 

1. **Create the Folder:** To create the folder, use the command: `mkdir helloWorld`. 

2. **Navigate to the Folder:** To navigate to that folder, use the command: `cd helloWorld`.

3. **Check the Current Folder:** To verify the folder you are in, use the command `pwd`. You should see a message printed on the screen showing the path of the folder you are currently in. 

4. **Create a New Python File:** To create a new Python file named hello.py that prints a hello message when executed, use the command: `echo 'print("hello from python on ubuntu on WSL!")' >> hello.py` 

5. **Execute the Program:** To run your new program, use the command: `python3 hello.py`

Great, now we have a Python project to continue working with. Let's look at how we can set up the WSL Extension for Visual Studio Code.