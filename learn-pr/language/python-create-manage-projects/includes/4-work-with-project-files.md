At this point, you know about virtual environments and how to install a package. Now it's time to start thinking about how to distribute this project to others for collaboration, and how you can manage your dependencies over time. You're likely to want to remove a dependency that's no longer used, for example.

## Freeze: Create a project file

You've seen how to use the command `pip freeze` to list the packages that are installed in your virtual environment. This command has more than one use, though. 

Imagine that you want to collaborate on a project with other developers. A good way to collaborate is to, for example, use [GitHub](https://github.com/about?azure-portal=true). You don't want to check in all the files you have, but only the application code and a list of packages that you depend on for the program to function. Why check in only a list of packages and not the packages themselves? A list takes a lot less space than checking in the packages. 

> [!NOTE]
> Thanks to `pip`, all you need is a list.

### Share a project

To share your project in GitHub so that others can work on it, you would take the following steps:

1. Call `pip freeze > requirements.txt`. This command creates a _requirements.txt_ file with all the packages that the program needs.
1. Create a _.gitignore_ file, and check in your application code and _requirements.txt_.
1. Check in the code to GitHub.

### Consume a project

To consume a project as a contributor (a fellow developer), you would take the following steps:

1. Fetch the project from GitHub.
1. Create a virtual environment and place yourself in it.
1. Restore the project by using `pip install -r requirements.txt`. It will look for _requirements.txt_ and fetch and install the packages listed for that file.
1. Run your app.

## Manage dependencies

Packages come in different versions. Every time a package is fixed for bugs or has more features added to it, its version number usually changes. For the sake of your program, you might need a specific version of a package. You want to keep your project updated so it uses the latest version of a package. 

Here are the main reasons why upgrading your packages is a good idea:

- **Bug fixes**. The library that you use might have problems. For example, a feature doesn't work as intended and the author goes in to fix it. You most likely want to upgrade the package as soon as such a fix is in place.
- **Security issues**. Your package might have a security vulnerability. After such a fix is released, you want to upgrade the package to protect your company and your customers.
- **Additional features**. The release of more features is nice, though it isn't a strong reason to upgrade the package. Still, if there's a feature that you've been waiting for, you might want to upgrade for that reason.

You can use either of the following approaches to make sure that your packages stay up to date.

### Install the latest version

You can check for the latest available version of a package and install that as soon as it's available. 

> [!IMPORTANT]
> Check that any new version is compatible with other dependencies that you might be using.

To install a specific version, use `==` between the package name and the version number. Here's an example command:

```console
pip install python-dateutil==1.4
```

The preceding command would install version 1.4, if it's available.


There are many ways to find out what versions are available. One way is to specify a version that you know *doesn't* exist. The resulting error will tell you what version does exist. Here's an example command that uses the nonsense string `randomwords`:

```console
pip install python-dateutil==randomwords
```

Here's the resulting output, with a list of existing versions:

```output
ERROR: Could not find a version that satisfies the requirement python-dateutil==randomwords (from versions: 1.4, 1.4.1, 1.5, 2.1, 2.2, 2.3, 2.4.0, 2.4.1, 2.4.1.post1, 2.4.2, 2.5.0, 2.5.1, 2.5.2, 2.5.3, 2.6.0, 2.6.1, 2.7.0, 2.7.1, 2.7.2, 2.7.3, 2.7.4, 2.7.5, 2.8.0, 2.8.1, 2.8.2)
ERROR: No matching distribution found for python-dateutil==randomwords
```

Another way is to call `pip freeze`: 

``` console
pip freeze python-dateutil
```

The output shows what specific versions it already installed for us, when we gave it only the package name as argument:

```output
python-dateutil==2.8.2
six==1.16.0
```

The preceding example shows that version 2.8.2 is installed. If you want to change that to an earlier version (because another package that you have requires it), you can use a command like this example: `pip install python-dateutil==2.8.0`.

### Upgrade a package

Packages change over time, as previously stated. You can upgrade to the latest package without specifying what the exact version number is. Use this command:

```console
pip install <name of package> --upgrade
```

## Apply an update strategy

Packages use something called *semantic versioning*. This means that if you look at a number like version "1.2.3," you can break down that number:

| Major | Minor | Patch |
| ----- | ----- | ----- |
| 1     | 2     | 3     |

- The leftmost number is called `Major`. If this number increases, many things have changed, and you can no longer assume that methods are named the same or have the same number of arguments as before. 
- The middle number is called `Minor`. If it changes, a feature has been added. 
- The rightmost number is called `Patch`. If this number increases, it most likely means that a bug has been corrected.

Why does all this matter for upgrading your package? It has to do with how careful you need to be. Sometimes, you're in a situation where you can't (or aren't allowed to) change the major and minor values, but you welcome bug fixes. You can specify this as part of the upgrade command:

```console
pip install "python-dateutil==2.7.*" --upgrade
```

In the preceding example, you specify that you want to upgrade only if there are new patch versions that use the "2.7.*" pattern. That means if you're on version 2.7.1, you're OK to upgrade to 2.7.2 (for example), because the rightmost number is about patch version. However, you're not OK with upgrading the minor version--for example, from 2.7 to 2.8.

## Clean up unused packages

Sometimes, you might realize that you no longer need a certain Python package and you want to remove it. For such a case, you can use `pip uninstall`:

```console
pip uninstall python-dateutil
```

However, if you run `pip freeze`, you see how the preceding command removed only the `python-dateutil` library. 

```output
six==1.16.0
```


This can be problematic, because your project now might contain many unused libraries that take up space. To clear out everything that this package depended on, you can write all installed packages to a *requirements.txt* list, like this:

```console
pip freeze > requirements.txt
```

Then remove all the packages in that list, like this:

```console
pip uninstall -r requirements.txt -y
```

> [!WARNING]
> The preceding commands would remove all installed packages, by first writing them to a _requirements.txt_ list and then removing all packages in that list. 

