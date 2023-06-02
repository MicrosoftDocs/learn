Most programs that you write will rely on code written by others. This code often comes in the form of packages, which are external modules or libraries that you include in your project. As with any project that requires a set of resources, it's important to consider how you'll ensure that the right resources are available for your program.

A good start is learning how to manage your program. A way to do that is to think of the program as a project. Python approaches this by using something called virtual environments.

## What's a virtual environment?

You have a development machine. On that machine, you might have one version of Python installed or one version of a library that you meant to use. What happens when you move your program to a machine that has a different version of Python installed or different versions of the libraries that you depend on? 

One thing you don't want to do is assume that your program will work and that you can just install the latest version of whatever libraries you depend on. If you do that, you might end up destroying the ability of the other programs to function on the target machine. The solution is to find a way for your app to work in isolation. 

Python's solution for these problems is a virtual environment. A virtual environment is a self-contained copy of everything needed to run your program. This includes the Python interpreter and any libraries your program needs. By using a virtual environment, you can ensure your program will have access to the correct versions and resources to run correctly.

The basic workflow looks like this:

1. Create a virtual environment that won't affect the rest of the machine.
1. Step into the virtual environment, where you specify the Python version and libraries that you need.
1. Develop your program.

### Create a virtual environment

You create a virtual environment by calling the `venv` module. The module expects a name as an argument. You'll set up your own virtual environment in the next unit, so you don't need to run any of the following code.

Take the following steps:

1. Go to the directory where you want to keep your project.
1. Use the following command to call the `venv` module. 

   ```console
   python -m venv env
   ```

   At this point, some directories are created for you. The directory names differ slightly depending on your operating system. 

   The directories look like this in Windows:

   ```output
   /env
     /include
     /lib
     /Scripts
   ```

   The directories look like this in Linux and macOS:

   ```output
   /env
     /bin
     /include
     /lib
   ```

   Your environment needs the `env` directory to keep track of details like which version of Python and which libraries you're using. Don't put your program files in the `env` directory. We suggest that you put your files in a directory called `src` or something similar. The project structure might then look like this:

   ```output
   /env
   /src
     program.py  
   ```

### Activate the virtual environment

At this point, you have a virtual environment, but you haven't started using it. To use it, you need to activate it by calling an `activate` script. 

Here's how the activation looks on Windows:

```console
C:\ .. \env\Scripts\activate
```

Here's how the activation looks on Linux and macOS:

```bash
source env/bin/activate
```

Calling `activate` changes your prompt. It's now preceded with `(env)` and looks something like this example:

```output
(env) -> path/to/project
```

At this point, you're inside your virtual environment. Anything you do happens in isolation.

## What's a package?

One of the main advantages of using external libraries is to speed up the development time of your program. You can fetch such a library on the internet. But by fetching and installing these libraries through a virtual environment, you ensure that you install theses libraries only for the virtual environment and not globally for the entire machine. 

## Install a package

You install a package by using `pip`. The `pip` command uses the Python Package Index, or PyPi for short, to know where to get the packages. You can visit the [PyPi website](https://pypi.org/) to see what packages are available.

To install a package, run `pip install` from the `env` directory, like in this example:

```console
pip install python-dateutil
```

If you run the preceding command, you'll download and install `dateutil`, a package for parsing the .yml file format. After you install the package, you can see it listed if you expand the *lib* directory under *env*, like this:

```output
/env
  /lib
    /dateutil
```

To see what packages are now installed in your virtual environment, you can run `pip freeze`. This command produces a list of installed packages in the terminal:

```output
python-dateutil==2.8.2
six==1.16.0
```

> [!NOTE]
> The reason that the preceding list contains more than just `pipdate` is that `pipdate` itself relies on other libraries that are also fetched.

To ensure that these packages exist only in your virtual environment, try stepping out of that environment by calling `deactivate`:

```console
deactivate
```

Notice how the terminal prompt changes. It's no longer preceded by `(env)` and has reverted to this appearance:

```output
path/to/project
```

If you run `pip freeze`, you'll see a much longer list of dependencies. This list indicates that you see all the packages installed on your machine rather than just what's installed in your virtual environment.

### More ways to install a package

You can also use the following commands to install a package:

- Have a set of files on your machine and install from that source:

   ```console
   cd <to where the package is on your machine>
   python3 -m pip install .
   ```

- Install from a GitHub repository that provides version control:

   ```console
   git+https://github.com/your-repo.git
   ```

- Install from a compressed archive file:

   ```console
   python3 -m pip install package.tar.gz
   ```

## Use an installed package

You now have a package installed. How do you use it in code? 

Ensure that you have a directory for your files. We suggest that you call the directory *src* and add an entry-point Python file called *app.py*. Now add some code to call `dateutil`:

```python
from datetime import *
from dateutil.relativedelta import *
now = datetime.now()
print(now)

now = now + relativedelta(months=1, weeks=1, hour=10)

print(now)
```

Run the app:

```console
python newapp.py
```

The output should look something like this:

```output
2023-01-30 17:04:24.799976
2023-03-07 10:04:24.799976
```
