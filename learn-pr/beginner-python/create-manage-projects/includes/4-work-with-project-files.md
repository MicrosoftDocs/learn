At this point, you know of virtual environments and how to install a package. Now it's time to start thinking about two things, how to distribute this project to others if you collaborate and also a little on how you can manage your dependencies over time. You are likely to want to remove a dependency that's no longer used for example.

## Freeze - Create a project file

You've seen the command `pip freeze` being used to list what packages are installed in your virtual environment. This command has more than one use though. Imagine that you want to collaborate on a project with other developers. 

A good way to collaborate is to, for example, use GitHub. You don't want to check in all the files you have, but only the application code and a list of packages you depend on for the program to function. Why only check in a list of packages and not the packages themselves? A list takes a lot less space than checking in the packages. 

> [!NOTE]
> Thanks to `pip`, all you need is a list.

### Share a project

To share your project so that others can work on it, you need to perform a series of steps. Here's the steps you need:

1. Call `pip freeze > requirements.txt`, this command will create a _requirements.txt_ file, with all the packages the program needs.
1. Create a _.gitignore_ file, and check in your application code and _requirement.txt_.
1. Check in the code to GitHub.

### Consume a project

To consume a project as a contributor (a fellow developer), take the following steps:

1. Fetch the project from GitHub.
1. Create a virtual environment and place yourself in it.
1. Restore the project with `pip install -r requirements.txt`, it will look for _requirements.txt_ and fetch and install the packages listed therein.
1. Run your app.

## Manage dependencies

Packages come in different versions. Every time a package is fixed for bugs or have more features added to it, its version number usually is upgraded. For the sake of your program, you might need a specific version of a package. You want to keep your project updated so it uses the latest versions of a package. Here's the main reasons why upgrading your packages is a good idea:

- **Bug fixes**. The library you use might have issues, a feature that doesn't work as intended and the authors goes into fix it. You most likely want to upgrade the package as soon as such a fix is in place.
- **Security issues**. Your package might have a security vulnerability. Once such a fix is released, you want to upgrade the package to protect your company and your customers.
- **Additional features**. More features are nice, it's not a strong reason to upgrade the package, but if it's a feature you've been waiting for, you might want to upgrade for that reason.

### How to upgrade

To upgrade a package, there's a couple of approaches you could be using:

- **Install the latest version**, you can check for the latest available version and install that as soon as it's available. A word of caution, check whether that version is compatible with the other dependencies you might be using.
- **Upgrade a package**. In this case, you upgrade to the latest package, without specifying what the exact version number is.

### Install a specific version

To install a specific version, you use a `===` right after the package name and a version number. Here's how you could type:

```bash
pip install python-dateutil===1.4
```

The above would install 1.4, if it's available.

So how do you know what versions exist? There are many ways to find this out, one way, is to specify a version that you know doesn't exist, the resulting error will tell you what version does exist. Here's how you can type, using a nonsense string `randomwords`:

```bash
pip install python-dateutil===randomwords
```

Here's the resulting output:

```output
ERROR: Could not find a version that satisfies the requirement python-dateutil===randomwords (from versions: 1.4, 1.4.1, 1.5, 2.1, 2.2, 2.3, 2.4.0, 2.4.1, 2.4.1.post1, 2.4.2, 2.5.0, 2.5.1, 2.5.2, 2.5.3, 2.6.0, 2.6.1, 2.7.0, 2.7.1, 2.7.2, 2.7.3, 2.7.4, 2.7.5, 2.8.0, 2.8.1, 2.8.2)
ERROR: No matching distribution found for python-dateutil===randomwords
```

The output tells us what does exist.

By calling `pip freeze` we are also told what specific versions it already installed for us, when we gave it only the package name as argument:

```output
pip-autoremove==0.10.0
python-dateutil==2.8.2
six==1.16.0
```

In the above listing, it shows that "2.8.2" is installed. Should we want to change that to a lower version (if some other package we have requires it), we can type for example `pip install python-dateutil===2.8.0`.

## Upgrade a package

Packages change over time as previously stated. To upgrade a package, you can type the following code:

```bash
pip install <name of package> --upgrade
```

### Semantic versioning

A thing to know about packages is that they use something called semantic versioning. This means that if you look at a number like version "1.2.3", you can break down that number:

| Major | Minor | Patch |
| ----- | ----- | ----- |
| 1     | 2     | 3     |

The leftmost number is called `major`, if this number increases, many things have changed, you can no longer assume that methods are named the same or have the same number of arguments as before. The middle number is referred to as `minor` and if it changes it means a feature has been added. The rightmost number is referred to as `patch`, if this number increases it means most likely that a bug has been corrected.

### Apply upgrade strategy

So why does all this matter for upgrading your package? It has to do with how careful you need to be. Sometimes you are in a situation where you can't, or are not allowed to change the major and minor values but you welcome bug fixes. At this point you can specify this as part of the upgrade command:

```bash
pip install "python-dateutil==2.7.*" --upgrade
```

Here, you specify that you want you only want to upgrade to if there are new patch versions, using this pattern "2.7.*", meaning if you are on version 2.7.1, you are ok to upgrade to 2.7.2 for example, as the rightmost numbers is about patch versions. However, you are not ok with upgrading the minor version, that is, from 2.7 to 2.8.

There's a lot more to be said on the topic of upgrading your packages, but now you have an idea of what these version numbers mean and when to upgrade.

## Clean up unused packages

Sometimes, you might realize you no longer need a certain Python package and you want to remove it. For such a case, you can use `pip uninstall`:

```bash
pip uninstall python-dateutil
```

However, if you run `pip freeze`, you see how it only removed the `python-dateutil` library, this can be problematic as your project now might contain many unused libraries, which take up space. To clear out everything this package depended on, you can either do like so:

```python
pip freeze > requirements.txt
pip uninstall -r requirements.txt -y
```

> [!WARNING]
> This would remove all installed packages, by first writing them to a _requirements.txt_ list and then remove all packages in that list.

A better approach is to use the `autoremove` library:

```bash
pip install pip-autoremove
pip-autoremove python-dateutil -y
```

Now if you run `pip freeze`, you see that it contains only the  output:

```output
pip-autoremove==0.10.0
```
