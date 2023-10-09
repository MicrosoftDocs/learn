In this exercise, you'll learn how to use virtual environments as a way to not affect globally installed packages or other programs running on your machine.

## Create a virtual environment

Create a virtual environment by using `venv`.

1. Open a new console window and run the following command:

   ```console
   python -m venv env
   ```

   You now have an *env* directory created in your terminal.

1. To activate the virtual environment, run the following command on Windows:

   ```console
   .\env\Scripts\activate
   ```

   Or, this command on Linux, WSL or macOS:
  
   ```bash
   source env/bin/activate
   ```

   You now see `(env)` in your terminal. That means you've activated your virtual environment and isolated yourself from the rest of your machine.

## Install a library

Now that you're inside your virtual environment, you can install a library and know that the library will exist only in the virtual environment.

1. Run `pip freeze` to see installed libraries in your environment:

   ```console
   pip freeze
   ```

   You should get no response. Next, let's see how the output of `pip freeze` changes when you add a library (a package).

1. Run `pip install` to install a library:

   ```console
   pip install python-dateutil
   ```

   A large output of text says it's installing your library, and it should end with the following sentence:

   ```output
   Successfully installed python-dateutil-2.8.2 six-1.16.0 
   ``` 

1. Rerun `pip freeze` to see how your list of libraries has changed:

   ```console
   pip freeze
   ```

   Now you should see the following list:

   ```output
   python-dateutil==2.8.2
   six==1.16.0
   ```

## Deactivate a virtual environment

So far, you've created a virtual environment and added a package to it. However, you might be working on several Python projects and need to change between them. To do that, you need step out of (*deactivate*) your virtual environment.

Run the `deactivate` command:

```console
deactivate
```

Note how your terminal prompt changes from `(env)` to how it looked before.

Congratulations! You've managed to successfully create and use a virtual environment.
