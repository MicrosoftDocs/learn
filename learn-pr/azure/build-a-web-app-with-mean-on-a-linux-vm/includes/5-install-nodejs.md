Here you install Node.js, the **N** in the MEAN acronym. Like MongoDB, Node.js is open source. 

Node.js acts as the server-side host for your web application and handle inbound HTTP traffic. Node.js also provides you with a way to communicate with your MongoDB installation, which you see later.

## What versions of Node.js are available?

You can get Node.js in two ways:

- **Long Term Support (LTS)**: LTS is considered to be more stable and is recommended for most users and for production environments.
- **Current**: Current is for those users who want to experiment with the latest features. Because it can introduce breaking changes between releases, it isn't recommended for production environments.

Here you use Node.js LTS.

## How do I install Node.js?

Like MongoDB, you can run Node.js on Windows, macOS, and Linux. Node.js also supports Unix-based operating systems such as SunOS and AIX.

Just like with MongoDB, here you register the Node.js repository so that `apt` can locate the package.

Recall that you're working with an Ubuntu VM. Later, you can [check out the installation guide](https://nodejs.org/en/download/package-manager?azure-portal=true) to learn how to install Node.js on your favorite platform.

## Install Node.js

Here, you install Node.js. As with MongoDB, the process involves registering the Node.js repository so that `apt` can locate the package.

> [!IMPORTANT]
> Here, you'll work from the SSH connection to the Ubuntu VM that you created earlier in this module.

1. Register the Node.js repository so the package manager can locate the packages using the following command. This step can take up to 10 mins or more depending on your internet connection. You might see a deprecation warning for this script that causes a short delay, but the installation does complete.

    ```bash
    curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    ```

1. Install the Node.js package:

    ```bash
    sudo apt install nodejs
    ```

1. Run `node -v` to verify the installation:

    ```bash
    node -v
    ```

    The output shows that you have the latest LTS version of Node.js.

## Exit your SSH session

You're all done working directly on the VM for now. Run `exit` to leave the SSH session to your VM:

```bash
exit
```

You're now back at your Cloud Shell session.
