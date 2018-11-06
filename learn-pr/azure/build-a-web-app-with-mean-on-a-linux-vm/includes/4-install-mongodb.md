Many applications require a database. Here you'll install MongoDB, the "M" in the MEAN stack. It's a popular NoSQL database solution that's free and open source. A NoSQL database doesn't require data to be structured in a pre-defined way as it would with a relational database like SQL Server or MySQL.

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

Here you'll install MongoDB with just a few commands. The process involves registering the MongoDB repository so that `apt` can locate the package.

> [!IMPORTANT]
> Here, you'll work from the SSH connection to the Ubuntu VM that you created in the previous unit.

1. Import the encryption key for the MongoDB repository. This  allows the package manager to verify that the packages you install are coming from MongoDB Inc.

    ```bash
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
    ```

    > [!NOTE]
    > The `sudo` part means that we want to run the command with administrative privileges.

1. Register the MongoDB repository so the package manager can locate the packages, like this.

    ```bash
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
    ```

1. Update the `apt` package database so you have the latest package information.

    ```bash
    sudo apt-get update
    ```

1. Install the MongoDB package.

    ```bash
    sudo apt-get install -y mongodb-org
    ```

1. Start the MongoDB service.

    ```bash
    sudo service mongod start
    ```

1. Run `mongod --version` to verify the installation.

    ```bash
    mongod --version
    ```

Keep your SSH connection open for the next part.