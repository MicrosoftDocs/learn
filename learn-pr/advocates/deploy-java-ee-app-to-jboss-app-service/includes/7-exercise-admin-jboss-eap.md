In this exercise, you'll access the JBoss administration tools and stream the application logs.

## Create a TCP tunnel

To access the remote server, you need to create a TCP tunnel between your remote server and your local machine. Run the following command:

```azcli
az webapp create-remote-connection -n ${WEBAPP_NAME} -g ${RESOURCEGROUP_NAME}
```

The command returns the following result:

```output
Verifying if app is running....
App is running. Trying to establish tunnel connection...
Opening tunnel on port: 59445
SSH is available { username: root, password: Docker! }
Ctrl + C to close
```

You get the following information from the command result:

|  Required information  |  Value  |
| ---- | ---- |
|  `Opening tunnel on port`  |  `PORT_NUMBER` (for example, `59445`)  |
|  `username`  |  `root`  |
|  `password`  |  `Docker!`  |

Take note of the password and the port number. These two values are used in the next section.

## Sign in by using SSH and the TCP tunnel

You now need to sign in to the server by using an `ssh` command. Open a new command terminal and run the following command:

```bash
export PORT_NUMBER=<the port number from above>
ssh root@127.0.0.1 -L 9990:localhost:9990 -p $PORT_NUMBER 
```

> [!TIP]
> If you want to access to the JBoss EAP admin web console, specify the `-L 9990:localhost:9990` option. Then access `http://localhost:9990/console` for the JBoss web console. If you don't need to sign in to the JBoss web console, you can remove the "-L" option.

You see the following messages when you sign in to the server.

```output
The authenticity of host '[127.0.0.1]:59445 ([127.0.0.1]:59445)' can't be established.
ECDSA key fingerprint is SHA256:vHsp1b3+7NtnHISvZ6aKS82pww+e5L6CUc9fKaPZGDQ.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '[127.0.0.1]:59445' (ECDSA) to the list of known hosts.
root@127.0.0.1's password:
   _|_|
 _|    _|  _|_|_|_|  _|    _|  _|  _|_|    _|_|
 _|_|_|_|      _|    _|    _|  _|_|      _|_|_|_|
 _|    _|    _|      _|    _|  _|        _|
 _|    _|  _|_|_|_|    _|_|_|  _|          _|_|_|

     J A V A   O N   A P P   S E R V I C E

Documentation: https://aka.ms/appservice

**NOTE**: No files or system changes outside of /home will persist beyond your application's current session. /home is your application's persistent storage and is shared across all the server instances.
```

## Run the JBoss CLI command

After you sign in to the remote server, you can run the JBoss EAP admin CLI tool as `jboss-cli.sh`. The CLI command is in the `/opt/eap/bin/` directory.

Connect to JBoss EAP by using the following command:

```bash
/opt/eap/bin/jboss-cli.sh --connect
Picked up JAVA_TOOL_OPTIONS: -Xmx2402M -Djava.net.preferIPv4Stack=true 
```

After you connect to the JBoss EAP Server, run the JBoss CLI command and get the JBoss server information:

```bash
[standalone@localhost:9990 /] :product-info
{
    "outcome" => "success",
    "result" => [{"summary" => {
        "host-name" => "295cf7c97684",
        "instance-identifier" => "24bb4e37-ac89-42bc-b87e-d635d37a56f3",
        "product-name" => "JBoss EAP",
        "product-version" => "7.4.2.GA",
        "product-community-identifier" => "Product",
        "product-home" => "/opt/eap",
        "last-update-date" => "4/26/22, 10:29 PM",
        "standalone-or-domain-identifier" => "STANDALONE_SERVER",
        "host-operating-system" => "Ubuntu 20.04.4 LTS",
        "host-cpu" => {
            "host-cpu-arch" => "amd64",
            "host-core-count" => 2
        },
        "jvm" => {
            "name" => "OpenJDK 64-Bit Server VM",
            "java-version" => "11",
            "jvm-version" => "11.0.14.1",
            "jvm-vendor" => "Microsoft",
            "java-home" => "/usr/lib/jvm/msopenjdk-11-amd64"
        }
    }}]
```

You can get all the deployed applications from the following command:

```bash
[standalone@localhost:9990 /] ls deployment
ROOT.war
```

Next, test the database connection by running the following command:

```bash
[standalone@localhost:9990 /] /subsystem=datasources/data-source="JPAWorldDataSourceDS":test-connection-in-pool
{
    "outcome" => "success",
    "result" => [true]
}
```

Exit from the JBoss EAP CLI.

```bash
exit
```

## Access the JBoss EAP admin web console

Next, let's access the JBoss admin web console.

First, create an admin user and password for authentication:

```bash
/opt/eap/bin/add-user.sh -u admin -p admin -r ManagementRealm
```

You should see output similar to the following.

```bash
Picked up JAVA_TOOL_OPTIONS: -Xmx5480M -Djava.net.preferIPv4Stack=true
Updated user 'admin' to file '/opt/eap/standalone/configuration/mgmt-users.properties'
Updated user 'admin' to file '/opt/eap/domain/configuration/mgmt-users.properties'
```

Now you can access the web console from your local environment. By using a browser, access the following URL:

```html
http://127.0.0.1:9990/console
```

In the authentication dialog box, sign in with the previously created username and password:

:::image type="content" source="../media/jboss-admin-console-1.png" alt-text="Screenshot that shows the authentication dialog box for the admin console.":::

After you sign in to the web console, the following screen appears:

:::image type="content" source="../media/jboss-admin-console-2.png" alt-text="Screenshot that shows the main page of the admin console.":::

You can confirm your created data source from **Configuration** > **Subsystems** > **Datasources & Drivers** > **Datasources**.

:::image type="content" source="../media/jboss-admin-console-3.png" alt-text="Screenshot that shows the list of data sources on the admin console.":::

You can also confirm the RESTful endpoints of your application from **Runtime** > *System* > **JAX-RS** > *Your Application*.

:::image type="content" source="../media/jboss-admin-console-4.png" alt-text="Screenshot that shows RESTful endpoints on the admin console.":::

> [!WARNING]
> If you directly access the remote server via the JBoss CLI command or web console and add or update a configuration, the configuration will be cleared and deleted after the Azure App Service instance is restarted. To persist the configuration, configure this in a startup script. For example, we created the `createMySQLDataSource.sh` as a startup script in a previous unit.

## Open a log stream

Next, let's sign in to the server and access the application logs.
You can access the logs by signing in your local machine through the following command:

```azurecli
az webapp log tail --name ${WEBAPP_NAME} --resource-group ${RESOURCEGROUP_NAME}
```

After you run the command, you get your log output:

```output
az webapp log tail  -n jakartaee-app-on-jboss-1606464084546 \
  -g jakartaee-app-on-jboss-1606464084546-rg

2020-12-09T02:23:24.412067731Z: [INFO]  02:23:24,411 INFO  [org.wildfly.extension.undertow] (ServerService Thread Pool -- 82) WFLYUT0021: Registered web context: '/' for server 'default-server'
2020-12-09T02:23:24.455340165Z: [INFO]  02:23:24,453 INFO  [org.jboss.as.server] (Controller Boot Thread) WFLYSRV0010: Deployed "ROOT.war" (runtime-name : "ROOT.war")
2020-12-09T02:23:24.464834646Z: [INFO]  02:23:24,456 INFO  [org.jboss.as.server] (ServerService Thread Pool -- 45) WFLYSRV0010: Deployed "activemq-rar.rar" (runtime-name : "activemq-rar.rar")
2020-12-09T02:23:24.674103836Z: [INFO]  02:23:24,673 INFO  [org.jboss.as.server] (Controller Boot Thread) WFLYSRV0212: Resuming server
2020-12-09T02:23:24.676640538Z: [INFO]  02:23:24,675 INFO  [org.jboss.as] (Controller Boot Thread) WFLYSRV0025: JBoss EAP 7.2.9.GA (WildFly Core 6.0.30.Final-redhat-00001) started in 25914ms - Started 537 of 709 services (345 services are lazy, passive or on-demand)
2020-12-09T02:23:24.680203180Z: [INFO]  02:23:24,679 INFO  [org.jboss.as] (Controller Boot Thread) WFLYSRV0060: Http management interface listening on http://127.0.0.1:9990/management
2020-12-09T02:23:24.680950010Z: [INFO]  02:23:24,680 INFO  [org.jboss.as] (Controller Boot Thread) WFLYSRV0051: Admin console listening on http://127.0.0.1:9990
```

## Exercise summary

In this unit, you learned how to configure and deploy a Java EE 8 (Jakarta EE) application to JBoss EAP on Azure App Service. Then, you used a `DataSource` object for connecting MySQL to JBoss EAP in a startup script.

You also learned how to access the remote server from both the CLI and the GUI by using a TCP tunnel. Finally, you accessed the log file from a local machine.
