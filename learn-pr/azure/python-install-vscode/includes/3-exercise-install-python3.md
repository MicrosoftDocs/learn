In the previous unit, you ran a command to determine whether you had Python 3 installed.  If you need to install Python 3, choose your operating system, below, then follow the instructions.

If you determined that you already have Python 3 installed, please scroll to the bottom of this page and click the `Continue` button.

::: zone pivot="windows"

### Install Python on Windows

At the time this module was written, Python 3.8 is the latest version of Python available, so we'll be referring to that version in the following instructions.

Also, these instructions are specifically for Windows 10.  If you're using a previous version of Windows, the basic instructions are the same, though the wording in some steps might be slightly different.

#### Step 1 - Download the Python 3.8 installer for Windows.

Open a web browser and navigate to:

[https://www.python.org/downloads/](https://www.python.org/downloads/?azure-portal=true)

Click the button with the text "Download Python 3.x".  When your browser prompts you to save the file, take note of the download path, then save it to your local hard drive.  Most web browsers save downloaded files into your `Downloads` folder.

#### Step 2 - Locate and run the installer application.

Depending on which web browser you use, you may have the option to execute the file immediately after it has successfully downloaded.  

If not, you can open Windows Explorer, navigate to the download path from the previous step, then double-click the file.  The file's name should be `python-3.8.0.exe`.

#### Step 3 - Choose options and begin the installation process.

After the installer's dialog appears, add a check to the option `Add Python 3.8 to PATH`.

Next, take note of the installation path under the words `Install Now`.

If you're satisfied with the location where Python will be installed, click `Install Now`.

If you want to change the installation path, select `Customize installation`.

The first page of options is titled "Optional Features".  There's no need to change the default selections.  Click the `Next` button.

The second page of options is titled "Advanced Options".  Near the bottom, you can change the installation path under `Customize install location`.

Once you're satisfied with the path, select the `Install` button.

#### Step 4 - Accept the User Account Control dialog.

Next you'll see Windows' User Account Control dialog, which asks "Do you want to allow this app to make changes to your device?"

Select the `Yes` button to continue.

#### Step 5 - Close the installer.

Click the `Close` button.

#### Step 6 - Check your installation.

To confirm that Python 3 is installed correctly, type the following command at the bash prompt and press the `Enter` or `Return` key on your keyboard:

```bash
py --version
```

You should see the word `Python` with a set of numbers separated with the `.` character.  Here's an example of the output you might see:

```output
Python 3.8.0
```
As long as the first of the three numbers is `3`, then congratulations!  You successfully installed Python 3 on your Windows computer.

::: zone-end

::: zone pivot="linux"

## Install Python on Linux

As you're likely aware, different Linux distributions use different package managers.  Most popular Linux distributions include either APT (Advanced Packaging Tool) or YUM (Yellowdog Updater, Modified).

We provide instructions for APT and YUM below.  If your distribution of Linux uses a different package manager, you may need to perform a search for: `[your Linux distribution] install python 3`.

![Important]
Not sure whether to use the APT or YUM instructions?  Try using the APT instructions first.  If you get an error message, you can try the YUM instructions instead.

### APT

#### Step 1 - Open a Terminal window.

Assuming you're running a Linux graphical user interface desktop environment, locate, and launch a terminal window using the Terminal icon.

#### Step 2 - Update the apt package indexes.

```bash
sudo apt-get update
```
The `apt-get update` command updates the list of packages (the package indexes) from the repositories and Personal Package Archives (PPAs) it knows about so `apt-get` can find the latest version of the packages and their dependencies that you want to install.

Using the `sudo` command temporarily elevates your permissions to root, the most powerful level of the system.  Invoking `sudo` usually means you'll be asked for your user account's password.

`apt-get update` will display all of the items it will update, and may ask you to approve by typing `y` or `yes`, then the `enter` or `return` key.

#### Step 3 - Install Python 3.

Type the following command at the bash prompt and press the `Enter` or `Return` key on your keyboard:

```bash
sudo apt-get install python3
```

`apt-get install` will locate the appropriate packages from the package index, download the necessary files, and install them into the appropriate folders.

#### Step 4 - Check your installation.

To confirm that Python 3 is installed correctly, type the following command at the bash prompt and press the `Enter` or `Return` key on your keyboard:

```bash
python3 --version
```

You should see the word `Python` with a set of numbers separated with the `.` character.  Here's an example of the output you might see:

```output
Python 3.6.7
```
As long as the first of the three numbers is `3`, then Python 3 was successfully installed on your system.

However, if the installation failed, you may see an error message.  Use a search engine and type the exact error message into the search bar to find possible causes and solutions.


### YUM

The YUM package manager is used primarily by Red Hat based systems, like Red Hat Enterprise Linux and Fedora, as well as CentOS.  If your system doesn't have APT installed, you can try YUM instead. 

#### Step 1 - Open a Terminal window.

Assuming you're running a Linux graphical user interface desktop environment, locate and launch a terminal window using the Terminal icon.

#### Step 2 - Update the YUM package indexes.

Type the following command at the bash prompt and select the `Enter` or `Return` keys on your keyboard:

```bash
sudo yum update
```
`yum update` will make sure all packages and their dependencies are up to date.  This is a good practice before installing new software.

#### Step 3 - Install Python 3.

Type the following command at the bash prompt and select the `Enter` or `Return` keys on your keyboard:

```bash
yum install rh-python36
```

#### Step 4 - Check your installation.

To confirm that Python 3 is installed correctly, type the following command at the bash prompt and press the `Enter` or `Return` key on your keyboard:

```bash
python3 --version
```

You should see the word `Python` with a set of numbers separated with the `.` character.  Here's an example of the output you might see:

```output
Python 3.6.7
```
As long as the first of the three numbers is `3`, then Python 3 was successfully installed on your system.

However, if the installation failed, you may see an error message.  If this happens, continue on to Step 5, below.

#### Step 5 - (Optional) Enable the Software Collections feature in bash

Software Collections allow you to install multiple versions of the same software components on your system.  Therefore, you must specify which 

```bash
scl enable rh-python36 bash
```
Now, retry Step 4.  The output should resemble the following output:

```output
Python 3.6.7
```
As long as the first of the three numbers is `3`, the Python 3 was successfully installed on your system, albeit in the context of a Software Collection.

`scl enable` launches a new bash session setting Python 3.6 as the default Python version.  However, Python 3.6 is only the default Python for this shell session.  If you exit the session or open a new session from another terminal, then bash will revert to Python 2.7 as the default Python version.

For more information about working with Software Collections, view the following hyperlink:

[https://access.redhat.com/documentation/en-us/red_hat_software_collections/2/html/2.4_release_notes/chap-rhscl](https://access.redhat.com/documentation/en-us/red_hat_software_collections/2/html/2.4_release_notes/chap-rhscl?azure-portal=true).

![Important]
If you needed to use `scl enable` to run `python3 --version`, then you may need to enter this command each time you want to work in Python.  There are workarounds to this, but this is the intended functionality of Software Collections.  See the following article for a possible work-around: [https://access.redhat.com/solutions/527703](https://access.redhat.com/solutions/527703?azure-portal=true).

::: zone-end


::: zone pivot="macos"

### Install Python on macOS

The steps that follow will download the Python installer directly from the Python website.

![Note]
Alternatively, you can use Homebrew to install Python and Visual Studio Code.  For instructions, visit this URL instead:
[https://docs.brew.sh/Homebrew-and-Python](https://docs.brew.sh/Homebrew-and-Python?azure-portal=true)

#### Step 1: Navigate to the Python downloads website and download the installer.

Navigate your web browser to:

[https://www.python.org/downloads/](https://www.python.org/downloads/?azure-portal=true)

The website should automatically direct you to a page specifically for `Mac OS X`.  Click the large button with the text "Download Python 3.8.0".

You may see a popup asking whether you allow downloads on "python.org".  Click the "Allow" button.

After a few moments, a file named `python-3.8.0-mascosx10.9.pkg' should be downloaded to the Downloads stack in your Dock.

#### Step 2: Launch the Python installer and allow a accept options for a standard install.

Double-click the `.pkg` file you just downloaded to launch the installer.  The Python installer will ask to install, verify and accept various options and license agreements.  Please take the time to read through these prompts to understand what the installer will do to your computer.

When the installation process finishes, a Finder window will appear with the contents of the Python folder.  You also should see a "Congratulations!" screen at the successful completion of the installation process, at which point you can choose the "Close" button to exit the installer.

If you're prompted to move the Python installer to the Trash, you may do so.

#### Step 3: Check to ensure that Python 3 was installed correctly.

Using Spotlight (`[command]` + `[spacebar]`) type `terminal` and use the `[return]` (or `[enter]`) key to launch Terminal.

At the Terminal prompt, type the following and press the `[return]` (or `[enter]`) key.  

```bash
python3 --version
```

You should see the word `Python` with a set of numbers separated with the `.` character.  Here's an example of the output you might see:

```output
Python 3.8.0
```
As long as the first of the three numbers is `3`, then Python 3 was successfully installed on your system.


::: zone-end