Most applications need a database. MongoDB, the "M" in the MEAN stack, is one of the most popular NoSQL database solutions, and it's free and open source. A NoSQL database doesn't require data to be structured in a pre-defined way as it would with a relational database like SQL Server or MySQL.

MongoDB stores its data in JSON-like documents that don't require rigid data structures. We then interact with MongoDB using queries and commands sent as JavaScript Object Notation (JSON).

## MongoDB versions

There are two versions of MongoDB available:

- MongoDB Community Server
- MongoDB Enterprise Server

In this module, we're going to use MongoDB Community Server, version 3.6 at the time of this writing, for our web application data store.

## How to install MongoDB

MongoDB can be installed on Linux, macOS, and Windows. We will be installing it on our Ubuntu Linux VM for this module, but the recommended package manager differs by OS and distribution. The installation process for all operating systems is well-documented in the [MongoDB install documentation](https://docs.mongodb.com/manual/administration/install-community/).

To install on our Ubuntu VM, we will use the **apt-get** package manager.