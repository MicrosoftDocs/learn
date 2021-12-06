When you start off building a program, you think about different aspects, what the program should do, what libraries I need and how to architect and maintain the program over time. These are important questions that you need to consider during development but also as you maintain the program over time.

A good start is learning how to manage your program and a way to do that is to think of the program as a project. Python approaches this using something called virtual environments.

## Virtual environment

You have a development machine, on that machine you might have one version of Python installed or one version of a library that you meant to use. What happens when you move it to a machine that might have a different version of Python installed or different versions of the libraries you depend on? One thing you don't want to do is to assume it will just work and that you can just install the latest version of whatever libraries you depend on. If you do that, you might end up destroying other programs ability to function on the target machine. So what's the solution? The solution is to find a way for your app to work in isolation. 

Python's solution for these problems is called virtual environment and is something you can create using a library called `venv`.

The idea is that you perform the following actions in the below order:

1. **Create a virtual environment**, now you have an environment that won't affect the rest of the machine.
1. **Step into the virtual environment**, where you specify the python version and libraries you need.
1. **Develop your program**. At this point, you are good to go and can work on developing your Python program.

### Create a virtual environment

Creating a virtual environment is done by calling the `venv` module. The module expects a name as an argument.

To create the virtual environment, take the following steps:

1. Navigate to the directory where you mean your project to live.
1. Call the `venv` module like so:

   ```bash
   python3 -m venv env
   ```

   How you call it differs slightly depending on operation system.

   At this point, some directories are created for you:

   ```output
   /env
     /bin
     /include
     lib
   ```

   `env` is directory that your virtual environment needs to keep track of which version of Python you are using, what libraries you are using and so on. The `env` is not a place where you want to put your program files. The suggestion here is to put your files into `src` directory or similar, so a project structure could look like so:

   ```output
   /env
   /src
     program.py  
   ```

### Activate it

At this point, you have a virtual environment, but you haven't started using it. To use it, you need to _activate_ it by calling an `activate` script in your `env` directory. Here's how the activation can look on macOS:

```bash
# Windows
env\bin\activate

# Linux, WSL or macOS
source env/bin/activate
```

Calling `activate` changes your prompt, it will now be preceded with (env) and look something like so:

```bash
(env) -> path/to/project
```

At this point, you are inside of your virtual environment, and anything you do happens in isolation.

## What's a package?

One of the main advantages with using external libraries to speed up the development time of your program. You can fetch such library on the Internet. But by fetching and installing these libraries via virtual environment, you ensure that you only install theses libraries for the virtual environment and not globally for the entire machine. A library is also referred to as a package.

## Install a package

The way to install a package is using `pip`. `pip` uses the Python Package Index, or PyPi for short, to know where to fetch the packages from. PyPi is located at https://pypi.org/, where that you can go to and browse to see what packages are available.

### Perform install

To install a package run `pip install`, like in the below example:

```bash
pip install python-dateutil
```

If you run the above command, you will download and install `dateutil` a package for parsing they yml file format. Once installed, you will see the package listed if you expand the `lib` directory under `env` like so:

```output
/env
  /lib
    /dateutil
```

To see what packages are now installed in your virtual environment, you can run `pip freeze`, this command will produce a list of installed packages in the terminal:

```output
python-dateutil==2.8.2
six==1.16.0
```

> [!NOTE]
> The reason this list above contains more than just `pipdate` is that `pipdate` itself relies on other libraries that's also fetched.

To ensure these packages only exist in our virtual environment, lets step out of said environment by calling `deactivate`, like so for macOS:

```bash
deactivate
```

You will notice how the terminal prompt changes to being preceded by (env) being removed and instead revert back to this appearance:

```bash
path/to/project
```

By running `pip freeze` and you will see a much longer list of dependencies. This list indicates that you see all the packages installed on your machine rather than what's installed in your virtual environment.

### More ways to install a package

However there are many more ways to install a package from, like the below:

- **source**, you can have a set of files on your machine. To install from source, you could type like so:

   ```bash
   cd <to where the package is on your machine>
   python3 -m pip install .
   ```

- **version control**, you can install from a version control like so:

   ```bash
   git+https://github.com/your-repo.git
   ```

- **an archive**. It's possible to install from a compressed file, like so:

   ```bash
   python3 -m pip install package.tar.gz
   ```

## Use an installed package

Ok great, so you have a dependency installed. So how do you use it in code? What you need to do is to ensure you a directory for your files, the suggestion is to call it `src` and that you add an entry point python file called `app.py`. Now add some code to call `pipdate`:

```python
from datetime import *
from dateutil.relativedelta import *
now = datetime.now()
print(now)

now = now + relativedelta(months=1, weeks=1, hour=10)

print(now)
```
