In this exercise, you'll work on a Python project that a colleague has created. You've fetched it from GitHub, and you need to restore it so you can work with it. You might also need to upgrade dependencies.

## Create a virtual environment

Before you start, create a virtual environment and place yourself in it. By doing so, you isolate yourself from the rest of your machine. Your environment should be isolated so you don't affect the rest of the machine when you install libraries.

1. Run `venv env`, to create a virtual environment called *env*:

   ```console
   python -m venv env
   ```

   You should now see a new _env_ subdirectory.

1. To activate the virtual environment, run the following command on Windows:

   ```console 
   C:\ .. \env\Scripts\activate
   ```

   Or, this command on Linux, WSL or macOS:
  
   ```bash
   source env/bin/activate
   ```

   Your command prompt should start with `(env)` to indicate the name of the virtual environment.

## Install dependencies for a project

You have access to some source code and a _requirements.txt_ file. The .txt file contains libraries that you want to download. You need to download these libraries so your program will function as intended.

1. Create the *src* directory and the needed files from the terminal.

   Run the following commands on Windows, one line at a time:

   ```console
   md src
   cd src
   type nul > app.py
   type nul > requirements.txt
   ```

   Or, these commands on Linux, WSL or macOS, one line at a time:

    ```bash
    mkdir src
    cd src
    touch app.py 
    touch requirements.txt
    ```

    These are your files:

    ```output
    src/
      app.py
      requirements.txt
    ```

1. Add the following content to _app.py_:

   ```python
   from datetime import *
   from dateutil.relativedelta import *
   now = datetime.now()
   print(now)
    
   now = now + relativedelta(months=1, weeks=1, hour=10)
    
   print(now)
   ```

1. Add the following content to _requirements.txt_:

   ```output
   python-dateutil==2.8.2
   six==1.16.0
   ```

1. Run `pip install` to install libraries specified in _requirements.txt_:

   ```console
   pip install -r requirements.txt
   ```

   You'll see output similar to the following text:

   ```output
   Collecting python-dateutil==2.8.2
     Using cached python_dateutil-2.8.2-py2.py3-none-any.whl (247 kB)
   Collecting six==1.16.0
     Using cached six-1.16.0-py2.py3-none-any.whl (11 kB)
   Installing collected packages: six, python-dateutil
   Successfully installed python-dateutil-2.8.2 six-1.16.0
   ```

Congratulations! You've successfully restored a project that had nothing but application files and a _requirements.txt_ file in it.

## Upgrade a package

Imagine that the project you created is using an older version of the library `python-dateutil`. Also, your team has asked you to install only fixes. In other words, the team wants you to upgrade the patch version and not install a major update, because that might be risky for your application and potentially break it.

Let's first simulate being on an earlier version of `python-dateutil`.

1. Run `pip install`:

   ```console
   pip install python-dateutil==2.7.4
   ```

   Other versions will be uninstalled before the specified version is installed:

   ```output
   Installing collected packages: python-dateutil
     Attempting uninstall: python-dateutil
       Found existing installation: python-dateutil 2.8.2
       Uninstalling python-dateutil-2.8.2:
         Successfully uninstalled python-dateutil-2.8.2
   Successfully installed python-dateutil-2.7.4
   ```

   Now, you should be on version 2.7.4. Next, you want to try to upgrade to the latest patch version.

1. Run `pip install --upgrade`:

   ```console
   pip install "python-dateutil==2.7.*" --upgrade
   ```

   The last line of your output should say "Successfully installed python-dateutil-2.7.5." That means it upgraded the package by looking at the rightmost number.

Congratulations! You've upgraded your library in a responsible way.  
