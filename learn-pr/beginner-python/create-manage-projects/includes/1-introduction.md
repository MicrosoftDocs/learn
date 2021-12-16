At this point, you've created small programs that used the libraries that come with the installation of Python. They work well. But as you build more advanced programs, you need to ask yourself a question: how much of this new functionality do I write, and how much is already written that I can use in my own programs?

As a developer, you're likely to build many programs on one machine. Those programs might also be used on other machines. However, some of these machines might have versions of Python installed that are not what you expect. Or, they might have libraries installed that are of lower or higher version than your program needs. 

So what do you do? You need to find a way for your program to work in isolation, so it doesn't disturb what's installed on the target machine. You also want to make sure that a machine doesn't disable your program because it has the wrong Python version or library version installed.

## Scenario: Let's build a program

To build more advanced programs, you want to start with a good approach. You want to think of the program that you build as more of a project, with the code spread out over many files. If possible, you also want to use libraries that others have written, to speed up development time.

## Learning objectives

By the end of this module, you'll be able to:

- Create a Python project.
- Develop and run your code in isolation on a machine.
- Use libraries that someone else has written.
- Restore a project from a list of dependencies.

## Prerequisites

- Familiarity with the terminal
- Knowledge of how to run commands from the terminal
- Experience with writing a program or two in Python (recommended)
