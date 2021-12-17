In this exercise, you'll be working on a Python project created by a colleague. You've fetched it from GitHub and you need to restore it so you can work with it, you may need to upgrade dependencies as well.

## Create a virtual environment

Before you start, you want to have created a virtual environment and placed yourself in it. By doing so, you've isolated yourself from the rest of your machine. Your environment should be isolated, because you would affect the rest of the machine if you install libraries, which you are about to do.

1. Run `venv env`, to create a virtual environment called "env":

   ```bash
   python3 -m venv env
   ```

   You should now see a new subdirectory named _env_.

1. To activate the virtual environment, run the following command:

   ```bash
   # On Linux, macOS or WSL
   source env/bin/activate

   # On Windows
   env\Scripts\activate.bat
   ```

   Your command prompt should start `(env)`, which is the name of the virtual environment.

## Install dependencies for a project

You have access to some source code and a _requirements.txt_ file. The mentioned file contains libraries that you are looking to download. You need to download these libraries so your program will function as intended.

1. Create the needed files from the terminal:

    ```bash
    mkdir src
    cd src
    touch app.py # on Windows, type nul > app.py
    touch requirements.txt # on Windows, type nul > requirements.txt 
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

   ```bash
   pip install -r requirements.txt
   ```

   You will see an output similar to the below text:

   ```output
   Using cached python_dateutil-2.8.2-py2.py3-none-any.whl (247 kB)
   Requirement already satisfied: six==1.16.0 in ./env/lib/python3.9/site-packages (from -r requirements.txt (line 2)) (1.16.0)
   Installing collected packages: python-dateutil
   Successfully installed python-dateutil-2.8.2
   ```

Congratulations, you've successfully managed to restore a project that had nothing but application files and a _requirements.txt_ file in it.

## Upgrade a package

Imagine the project you created was using an older version of the library `python-dateutil`. Furthermore, you've been asked by your team to only install fixes, meaning to only upgrade its patch version, and not install a major update because that might be risky for your application and potentially could lead to it breaking.

Let's first simulate being on lower version of `python-dateutil`.

1. Run `pip install`:

   ```bash
   pip install python-dateutil===2.7.4
   ```

   Now, you should be on version "2.7.4". Next, you want to try to upgrade to the latest patch version.

1. Run `pip install --upgrade`:

   ```bash
   pip install "python-dateutil==2.7.*" --upgrade
   ```

   Your output should say in the last line "Successfully installed python-dateutil-2.7.5". Which means it upgraded the package by looking at the rightmost number.

Congratulations, you've managed to upgrade your library in a responsible way.  
