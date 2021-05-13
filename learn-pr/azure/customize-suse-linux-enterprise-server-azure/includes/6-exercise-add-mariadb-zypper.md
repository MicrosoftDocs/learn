For this exercise, you’ll be adding the successor of the MySQL database, mariadb, to your growing application stack using zypper.  

## ssh into the virtual machine

Refresh the repositories to ensure you’re working with the latest metadata index  

```console
sudo zypper refresh
```

In this case, repositories should already be up to date because you used YaST in the previous exercise. If you choose to use zypper and skip this initial refresh step, you will get an error if the metadata has changed and you’ll be forced to run it before you can get started.  

## Install a software package with zypper 

1. Search for mariadb. 
    ```console 
    zypper search maria
    ``` 
    or 
    ```console
    zypper se maria
    ```  
3. Packages that contain the string maria in their name are listed. If there is an "I" in the first column, it means this package is already installed. 
4. To install a package, you can either enter:  

    ```console
    sudo zypper install mariadb
    ```

    which prompts you confirm you want to continue with the installation.
    
    In the sample screen shown, can you identify the error in the command line? If you answered, the command does not include sudo, you’re correct. Because an install changes the machine, you must use sudo to get admin rights to proceed.  

1. Do search for the package again, now it should have the "I" in the first column. 

## Use zypper to install a pattern 

_(Please note, this is a challenge task. Instead of following step-by-step instructions to perform the task, you will rely on knowledge previously gained to complete the task.)_

**zypper has the ability to install entire patterns as well as single packages.  Your task is to install the lamp_server pattern using the zypper command. **

As a reminder, patterns are a pre-defined group of packages for a certain functionality, e.g. a file-server or a graphical environment. They look like packages but have "pattern” in their name.
