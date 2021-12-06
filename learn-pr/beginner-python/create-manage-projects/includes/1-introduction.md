At this point, you've created some programs, smaller programs that have been using the libraries that come with the installation of Python. However, as you build more advanced programs, you need to ask yourself a question: how much of this new functionality do I write and how much is already written that I can use in my own program?

As a developer, you are likely to build many programs on one and the same machine and those programs might be used on other machines as well. However, some of these machines might have versions of pythons installed that's not what you expect or they might have libraries installed that is of lower or higher version than your program needs. So what do you do?  You need to find a way for your program to work in isolation, so it doesn't disturb what's installed on the target machine or it renders your program in a state where it can't run, because it has the wrong version of a Python or a library installed.

## Scenario: Let's build a program

You've written your first programs, they work well, but you are looking to build more advanced programs and to do that you want to make sure you have a good approach moving forward. You want to think of the program you build as more of a project, with the code spread out over many files. If possible, you also want to use libraries written by others to speed up the time of development.

## Learning objectives

By the end of this module, you'll be able to:

- Create a Python project.
- Develop and run your code in isolation on a machine.
- Use libraries written by someone else.
- Restore a project from a list of dependencies it consists of.

## Prerequisites

- Familiar with the terminal.
- Know how to run commands from the terminal.
- Recommended to have written a program or two in Python.
