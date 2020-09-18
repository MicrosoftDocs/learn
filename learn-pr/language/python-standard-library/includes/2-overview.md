Before we begin to work with the Python standard library, let's get a clear understanding of exactly what it is, how it relates to the Python programming language, how it's divided into manageable parts, and how to harness it.

## What is the Python standard library?

The Python standard library is a vast collection of functions, types, and services that address a wide array of programming needs.  These are not part of the Python language, but the functions are distributed with the Python interpreter, and are available to every Python program.

The library is split up into modules.  Some modules are *built-in*, meaning you can start using them without notifying the Python compiler ahead of time.  Other modules must be imported first.

Some of the code in those modules is written in the C programming language, which can address a lower-level set of operating system and hardware functionality than Python.  The developers of Python use this low-level access to the computer's memory, processor, file system, operating system, and so on, to implement efficient features.  Because C is a lower-level programming language, it is powerful, but also more complicated than Python. It often requires a significant amount of code to accomplish tasks that are trivial in Python.  By packaging up C code and making it available to Python, you get the best of both worlds.

## What is a module?

A *module* is simply a code file.  Later in this module, we'll build a module so you can get some experience working with them.  The modules that are a part of the Python standard library are complex and rich with features, but ultimately, they are just code files.

When we refer to a module, we might be referencing the concept of a module (as a code file) or the functionality supported by the code file.  For example, when we refer to the `zipfile` module, we are referring to the collection of functions that support compressing and decompressing file data using the ZIP archive standard.

## What can you do with the standard library?

The standard library spans a wide spectrum of functionality, including:

- Date and time modules
- Numeric and mathematical modules
- File system modules
- Operating system modules
- Modules for reading and writing specific data formats, such as HTML, XML, and JSON
- Modules for working with Internet protocols, such as HTTP, SMTP, FTP, and so on
- Modules for working with multimedia data, such as sound and video
- Modules for working with localized information, such as presenting currency and dates
- And many more

For a complete listing of modules in the Python standard library, see [The Python Standard Library](https://docs.python.org/3/library/?azure-portal=true).

### Built-in functions versus importing modules

There's some debate as to the exact meaning of a built-in function. Generally speaking, it's a function that has been built into the Python interpreter. They are usually functions that are used so often that it would be laborious to import them each time you need them.  For example, given that almost every Python program needs to `print()` something, it makes sense to include that as a built-in function.

Other features and functions are useful, but are only needed occasionally.  In these cases, you can tell the Python compiler that you expect to use them in your program by using the `import` statement in an exercise in this module.

With third-party packages (often open-source libraries of functionalities built by a community of volunteer developers), you first need to download and install the libraries locally, then use an `import` statement to tell the Python compiler that you intend to use the functions in your code.  You use a Python command-line utility called `pip` to install a package locally for use in your program.  We'll install, import, and call functions from a package in an exercise in this module.


### How can I find what I'm looking for?

With such a massive number of modules in the Python standard library, not to mention across all the third-party libraries that are available, finding the right module might feel a bit daunting.

First, you do not need to learn it all.  There's no way you can read all the standard library documentation, much less the documentation from all other popular Python libraries, so don't even try.  In time, you'll become familiar with a subset of modules and libraries that affect the kind of work you are tasked with.

Second, you should start by searching for a solution to the specific problem you're trying to solve. While you may not have all the details worked out in your mind, you should be able to formulate a good set of keywords to describe the problem.

After you can clearly state your problem, the next step is to become a detective.  You'll turn to search engines to look for candidate solutions.  It's likely that there are a dozen different ways to solve your problem.  You may spend a few minutes, hours, or even a day reviewing the approaches to solving the problem.  And it's likely that some of those approaches will require modules from the Python standard library, third-party packages, or both.

You might wonder if it's *cheating* to search for the solution.  Are you somehow less of a programmer for not knowing everything?  Not at all.  Everyone does it; especially experienced professional developers.  There's both a rich community and a proud tradition of developers helping other developers online.  No one can know everything.  

Admittedly, you should understand the Python language well. If you copy code from blogs, articles, or videos, then you should spend time understanding what it does and figure out how to incorporate it into your work as if it were your own. But you should never feel guilty about *stealing* someone's approach to solving a given problem.  That's why they posted it on the internet!

## Recap


- A module is a file containing functions that implement functionality.  The Python standard library is made up of over 200 modules containing thousands of functions.
- Some important, commonly used functions are built directly into the Python compiler and interpreter.  
- You must use an `import` statement to tell the Python compiler which modules in the Python standard library contain the functions, types, services, and so on, that you will be using in your code.
- Searching online is a valid way to discover the modules and functions from the Python standard library (and other third-party packages) that can be combined to solve a programming problem that you're facing.
