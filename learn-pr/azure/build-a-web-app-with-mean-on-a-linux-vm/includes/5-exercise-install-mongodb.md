In this unit, you will install MongoDB on your Ubuntu Linux virtual machine to act as a data store for your upcoming sample web application.

## Install MongoDB

1. From Cloud Shell, SSH into your VM.

    ```bash
    ssh <vm-admin-username>@<vm-public-ip>
    ```

1. Import the encryption key for the MongoDB repository. This will allow the package manager to verify that the mongodb packages you install are coming from MongoDB Inc.

    ```bash
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
    ```

    The **sudo** command means that we want to run the specified command with administrative privileges.

1. Register the MongoDB Ubuntu repository so the package manager can locate the mongodb packages.

    > [!NOTE]
    > This command is different for different versions of Ubuntu. To find out which version of Ubuntu you're using, run: `uname -v`.
    > This command will output something like this: `#21~16.04.1-Ubuntu SMP Fri Aug 10 12:36:09 UTC 2018`.
    >
    > This output indicates that we're running Ubuntu version 16.04.1.
    > Refer to the [Install MongoDB Community Edition on Ubuntu](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/) documentation to get the exact command for your version.

    On Ubuntu 16.04, we run this command:

    ```bash
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
    ```

1. Update the package database so we have the latest package information.

    ```bash
    sudo apt-get update
    ```

1. Install the MongoDB package onto our VM.

    ```bash
    sudo apt-get install -y mongodb-org
    ```

1. Start the MongoDB service so you can connect to it later.

    ```bash
    sudo service mongod start
    ```

## Summary

We now have MongoDB installed on our Ubuntu Linux VM. MongoDB will serve as your backing data store for the information you save and retrieve in your web application.