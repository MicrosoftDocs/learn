After your cluster is provisioned, the next step is connecting to it. Azure DocumentDB supports connections from any MongoDB-compatible client because it implements the MongoDB wire protocol. You can connect using MongoDB Shell (`mongosh`), MongoDB Compass, or standard MongoDB drivers in your application code.

## Get your connection string

Every cluster has a connection string that clients use to connect. To find it:

1. Open your DocumentDB cluster in the Azure portal.
1. In the resource menu, under **Settings**, select **Connection strings**.
1. Copy the value from the **Connection string** field.

The connection string follows this format:

```text
mongodb+srv://<username>@<cluster-name>.mongocluster.cosmos.azure.com/?tls=true&authMechanism=SCRAM-SHA-256&retrywrites=false&maxIdleTimeMS=120000
```

> [!NOTE]
> There are two connection strings available in the portal: one for global read-write access and one the current cluster (Self), for most of these scenarios use the connection string for the current cluster to connect from your client.

Key components of the connection string:

- `mongodb+srv://`: The Service Record (SRV) connection format, which enables automatic service discovery via DNS.
- `<username>`: Your admin username. Replace this placeholder with the username you created during cluster setup.
- `<cluster-name>.mongocluster.cosmos.azure.com`: The cluster's endpoint.
- `tls=true`: Requires encrypted connections. Azure DocumentDB enforces Transport Layer Security (TLS) for all connections.
- `authMechanism=SCRAM-SHA-256`: The authentication protocol used by Azure DocumentDB.
- `retrywrites=false`: Disables automatic write retries, which is the recommended setting for Azure DocumentDB.
- `maxIdleTimeMS=120000`: Closes idle connections after 120 seconds.

> [!IMPORTANT]
> The connection string from the portal doesn't include the password. Replace the `<password>` placeholder with your admin password, or enter the password interactively when prompted by `mongosh`.

## Connect with MongoDB Shell

MongoDB Shell (`mongosh`) is a command-line tool for interacting with MongoDB-compatible databases. It's useful for testing connections, running queries, and managing databases.

**Connect with an interactive password prompt**:

```console
mongosh "mongodb+srv://<username>@<cluster-name>.mongocluster.cosmos.azure.com/?tls=true&authMechanism=SCRAM-SHA-256&retrywrites=false&maxIdleTimeMS=120000"
```

When prompted, enter your password. This method avoids exposing the password in your command history.

**Connect with the password inline**:

```console
mongosh "mongodb+srv://<cluster-name>.mongocluster.cosmos.azure.com/?tls=true&authMechanism=SCRAM-SHA-256&retrywrites=false&maxIdleTimeMS=120000" --username "<username>" --password "<password>"
```

After authenticating, you see a warning:

```output
------
   Warning: Non-Genuine MongoDB Detected
   This server or service appears to be an emulation of MongoDB rather than an official MongoDB product.
------
```

You can safely ignore this warning. It appears because the connection string contains `cosmos.azure`. Azure DocumentDB is a native Azure service, not a MongoDB product.

## Connect from the Azure portal

Azure DocumentDB provides a Quick Start experience in the portal that opens MongoDB Shell directly in Azure Cloud Shell. Before using it, ensure Cloud Shell can reach your cluster:

1. In your cluster, select **Networking** from the navigation menu.
1. In the **Public access** section, select **Allow public access from Azure services and resources within Azure to this cluster**.
1. Select **Save**.

Then open the shell:

1. In your cluster resource page, select **Quick start** from the navigation menu.
1. Select **Open MongoDB shell**.
1. Wait for the shell environment to start, then enter **Y** to accept the notice.
1. Enter your password when prompted.

This approach requires no local installation and is useful for quick tests.

## Verify your connection

After connecting, verify the connection is working:

```javascript
db.runCommand({connectionStatus: 1})
```

A successful response returns `ok: 1`. You can then explore the cluster:

```javascript
// List databases
show dbs

// Switch to a database
use cosmicworks

// List collections in the database
show collections
```

> [!NOTE]
> This example assumes that the database `cosmicworks` exists and contains collections. If your cluster doesn't yet have this database or collections, create them before running these commands or the results of the commands are empty.


## Connect from application code

In production applications, you connect using MongoDB drivers. Azure DocumentDB works with standard MongoDB drivers for all major programming languages. Here's an example of how the connection string is used:

```text
mongodb+srv://<username>:<password>@<cluster-name>.mongocluster.cosmos.azure.com/?tls=true&authMechanism=SCRAM-SHA-256&retrywrites=false&maxIdleTimeMS=120000
```

When connecting from application code, follow these practices:

- **Store credentials securely**: Use environment variables, Azure Key Vault, or your platform's secret management rather than hardcoding credentials in source code.
- **Use connection pooling**: MongoDB drivers manage connection pools automatically. Configure the pool size based on your application's concurrency requirements.
- **Handle the "Non-Genuine MongoDB" warning**: Some drivers log this warning. It doesn't affect functionality and can be suppressed in your logging configuration.
- **Enable TLS**: Azure DocumentDB requires and enforces TLS. Ensure your driver version supports TLS 1.2 or later.

With your cluster running and your connection verified, the next step is configuring compute, storage, and security settings to match your workload's requirements.
