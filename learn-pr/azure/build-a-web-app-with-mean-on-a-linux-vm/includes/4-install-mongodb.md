Many applications require a database. Here you'll install MongoDB, the "M" in the MEAN stack. It's a popular NoSQL database solution that's free and open source. A NoSQL database doesn't require data to be structured in a predefined way like it would with a relational database like SQL Server or MySQL.

MongoDB stores its data in JSON-like documents that don't require rigid data structures. You interact with MongoDB using queries and commands sent using JavaScript Object Notation, or JSON.

## What MongoDB editions are available?

MongoDB provides two editions:

- MongoDB Community Server
- MongoDB Enterprise Server

Here you'll install MongoDB Community Server. Later, you'll use MongoDB to store information about books.

## How do I install MongoDB?

You can install MongoDB on Linux, macOS, and Windows. For learning purposes, here you'll install MongoDB on Ubuntu using Ubuntu's `apt` package manager.

The installation process varies depending on your operating system. If you're not familiar with Ubuntu, you can still follow along to get a sense for how things work.

Later, you can [check out the installation guide](https://docs.mongodb.com/manual/administration/install-community?azure-portal=true) to learn more.

## Install MongoDB

Here, you'll install MongoDB with just a few commands. You'll work from the SSH connection to the Ubuntu VM that you created in the previous unit.

 > [!NOTE]
 > The update can take up to 10 minutes.

1. First, we'll make sure all current packages are up to date:

    ```bash
    sudo apt update && sudo apt upgrade -y
    ```

    > [!NOTE]
    > The `sudo` part means that we want to run the command with administrative privileges.

1. Install the MongoDB package:

    ```bash
    sudo apt-get install -y mongodb
    ```

1. After the installation completes, the service should automatically start up. Let's confirm this by running the following command:

    ```bash
    sudo systemctl status mongodb
    ```

    You should see the service running:

    ```output
    azureuser@MeanStack:~$ sudo systemctl status mongodb
    ● mongodb.service - An object/document-oriented database
      Loaded: loaded (/lib/systemd/system/mongodb.service; enabled; vendor preset: enabled)
      Active: active (running) since Thu 2019-08-22 16:46:30 UTC; 9s ago
        Docs: man:mongod(1)
    Main PID: 18360 (mongod)
      CGroup: /system.slice/mongodb.service
              └─18360 /usr/bin/mongod --config /etc/mongodb.conf

    Aug 22 16:46:30 MeanStack systemd[1]: Started An object/document-oriented database.
    ```

1. Run `mongod --version` to verify the installation.

    ```bash
    mongod --version
    ```

Keep your SSH connection open for the next part.
