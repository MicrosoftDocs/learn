Zypper automatically includes a package's dependencies when you use it to install a package.

Let's get MariaDB installed on your server. In this exercise, you add it to your growing application stack by searching for and installing it with zypper.  

## ssh into the virtual machine

Refresh the repositories to ensure you’re working with the latest metadata index  

```console
sudo zypper refresh
```

:::image type="content" source="../media/zypper-refresh-inline.png" alt-text="Screenshot of console output of zypper refresh." lightbox="../media/zypper-refresh-expanded.png":::

In this case, repositories should already be up to date because you used YaST in the previous exercise. If you choose to use zypper and skip this initial refresh step, you get an error if the metadata changed, and you must run it before you can get started.  

## Install a software package with zypper 

1. Search for mariadb.
    
    ```console 
    zypper search maria
    ```

    or

    ```console
    zypper se maria
    ```

    :::image type="content" source="../media/zypper-search.png" alt-text="Screenshot of console output performing a zypper search for Maria D B.":::

1. Packages that contain the string maria in their name are listed. If there's an "I" in the first column, it means this package is already installed. 

1. To install a package, enter:  

    ```console
    sudo zypper install mariadb
    ```

    which prompts you confirm you want to continue with the installation.

    > [!NOTE]
    > In the sample screen shown, can you identify the error in the command line? If you answered, the command does not include sudo, you’re correct. Because an install changes the machine, you must use sudo to get admin rights to proceed.

    :::image type="content" source="../media/zypper-install-mariadb-error.png" alt-text="Screenshot of console output of zypper installing Maria D B with an error.":::

1. Do search for the package again, now it should have the "I" in the first column.

## Use zypper to install a pattern

> [!NOTE]
> This is a challenge task. Instead of following step-by-step instructions to perform the task, you will rely on knowledge previously gained to complete the task.

zypper can install single packages or entire patterns. Your task is to install the lamp_server pattern using the zypper command.

As a reminder, patterns are a predefined group of packages for a certain functionality, for example, a file-server or a graphical environment. They look like packages but have "pattern" in their name.

:::image type="content" source="../media/zypper-pattern-install-inline.png" alt-text="Screenshot of console output showing zypper pattern install." lightbox="../media/zypper-pattern-install-expanded.png":::
