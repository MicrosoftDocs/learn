In this unit, you will install Node.js - the **N** in the MEAN acronym - on an Azure-hosted Ubuntu Linux virtual machine. Node.js will serve as our runtime for handling our HTTP traffic and hosting our web application.

## Install Node.js

1. **If you aren't still SSHed into your VM from the previous exercise**, SSH in.

    ```bash
    ssh <vm-admin-username>@<vm-public-ip>
    ```

1. Register the Node.js package repository so **apt-get** can find the right package to install on your virtual machine.

    ```bash
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    ```

1. Install the Node.js package on your Linux system.

    ```bash
    sudo apt-get install -y Node.js
    ```

1. Verify the Node.js installation succeeded by running the following simple Node.js command.

    ```bash
    node -v
    ```

    The output should be something like `v8.11.4`, with the version reflecting the latest Node.js version that's available when you install the package.

## Summary

With Node.js installed on your virtual machine, we can start building a web application that it will be responsible for running.