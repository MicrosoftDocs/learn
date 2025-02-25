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
ssh root@127.0.0.1 -L 9990:localhost:9990 -p 65171
root@127.0.0.1's password: 
Last login: Tue Feb 25 07:44:49 2025 from 169.254.129.2
   _|_|                                            
 _|    _|  _|_|_|_|  _|    _|  _|  _|_|    _|_|    
 _|_|_|_|      _|    _|    _|  _|_|      _|_|_|_|  
 _|    _|    _|      _|    _|  _|        _|        
 _|    _|  _|_|_|_|    _|_|_|  _|          _|_|_|

     J A V A   O N   A P P   S E R V I C E

Documentation: https://aka.ms/appservice

**NOTE**: No files or system changes outside of /home will persist beyond your application's current session. /home is your application's persistent storage and is shared across all the server instances.

root@jakartaee-e9de81f9:/# 
```

## Run the JBoss CLI command

After you sign in to the remote server, you can run the JBoss EAP admin CLI tool as `jboss-cli.sh`. The CLI command is in the `/opt/eap/bin/` directory.

Connect to JBoss EAP by using the following command:

```bash
/opt/eap/bin/jboss-cli.sh --connect
OpenJDK 64-Bit Server VM warning: Options -Xverify:none and -noverify were deprecated in JDK 13 and will likely be removed in a future release.
```

After you connect to the JBoss EAP Server, run the JBoss CLI command and get the JBoss server information:

```bash
[standalone@localhost:9990 /] :product-info
{
    "outcome" => "success",
    "result" => [{"summary" => {
        "host-name" => "jakartaee-e9de81f9",
        "instance-identifier" => "e0996cd1-25b3-42d4-a150-49fabf415ecc",
        "product-name" => "JBoss EAP",
        "product-version" => "8.0 Update 4.1",
        "product-community-identifier" => "Product",
        "product-home" => "/opt/eap",
        "standalone-or-domain-identifier" => "STANDALONE_SERVER",
        "host-operating-system" => "Ubuntu 22.04.5 LTS",
        "host-cpu" => {
            "host-cpu-arch" => "amd64",
            "host-core-count" => 2
        },
        "jvm" => {
            "name" => "OpenJDK 64-Bit Server VM",
            "java-version" => "17",
            "jvm-version" => "17.0.13",
            "jvm-vendor" => "Microsoft",
            "java-home" => "/usr/lib/jvm/msopenjdk-17-amd64"
        }
    }}]
}
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

2025-02-25T06:58:11.5107300Z Waiting for main process to exit. GLOBAL_PID_MAIN=123
2025-02-25T06:58:11.5109525Z Waiting for GLOBAL_PID_MAIN == 123
2025-02-25T06:58:12.7891598Z 2025-02-25 06:58:12,786 WARN  [org.apache.activemq.artemis.core.server.impl.FileLockNodeManager] (Thread-2 (ActiveMQ-scheduled-threads)) Lost the lock according to the monitor, notifying listeners
2025-02-25T06:58:14.3783443Z 2025-02-25 06:58:14,377 INFO  [org.jboss.as.jpa] (MSC service thread 1-2) WFLYJPA0002: Read persistence.xml for JPAWorldDatasourcePU
2025-02-25T06:58:14.7548991Z 2025-02-25 06:58:14,752 INFO  [org.jipijapa] (MSC service thread 1-3) JIPIORMV6020260: Second level cache enabled for ROOT.war#JPAWorldDatasourcePU
2025-02-25T06:58:14.7971763Z 2025-02-25 06:58:14,796 WARN  [org.apache.activemq.artemis.core.server.impl.FileLockNodeManager] (Thread-2 (ActiveMQ-scheduled-threads)) Lost the lock according to the monitor, notifying listeners
2025-02-25T06:58:14.9371057Z 2025-02-25 06:58:14,924 INFO  [org.jboss.weld.deployer] (MSC service thread 1-4) WFLYWELD0003: Processing weld deployment ROOT.war
2025-02-25T06:58:15.2875956Z 2025-02-25 06:58:15,280 INFO  [org.hibernate.validator.internal.util.Version] (MSC service thread 1-4) HV000001: Hibernate Validator 8.0.1.Final-redhat-00001
2025-02-25T06:58:16.0075988Z 2025-02-25 06:58:16,003 INFO  [org.infinispan.CONTAINER] (ServerService Thread Pool -- 78) ISPN000556: Starting user marshaller 'org.wildfly.clustering.infinispan.marshalling.jboss.JBossMarshaller'
2025-02-25T06:58:16.0534913Z 2025-02-25 06:58:16,048 INFO  [org.jipijapa] (MSC service thread 1-1) JIPIORMV6020260: Second level cache enabled for ROOT.war#JPAWorldDatasourcePU
2025-02-25T06:58:16.1970192Z 2025-02-25 06:58:16,192 INFO  [org.jboss.as.connector.deployers.jdbc] (MSC service thread 1-1) WFLYJCA0005: Deploying non-JDBC-compliant driver class com.mysql.cj.jdbc.Driver (version 9.2)
2025-02-25T06:58:16.2695781Z 2025-02-25 06:58:16,265 INFO  [org.jboss.weld.Version] (MSC service thread 1-1) WELD-000900: 5.1.2 (redhat)
2025-02-25T06:58:16.4228682Z 2025-02-25 06:58:16,421 INFO  [org.jboss.as.connector.deployers.jdbc] (MSC service thread 1-3) WFLYJCA0018: Started Driver service with driver-name = ROOT.war_com.mysql.cj.jdbc.Driver_9_2
2025-02-25T06:58:16.4261069Z 2025-02-25 06:58:16,425 INFO  [org.jboss.as.connector.subsystems.datasources.AbstractDataSourceService$AS7DataSourceDeployer] (MSC service thread 1-3) IJ020018: Enabling <validate-on-match> for java:jboss/datasources/JPAWorldDataSource
2025-02-25T06:58:16.4349571Z 2025-02-25 06:58:16,428 INFO  [org.jboss.as.connector.subsystems.datasources] (MSC service thread 1-3) WFLYJCA0001: Bound data source [java:jboss/datasources/JPAWorldDataSource]
2025-02-25T06:58:16.7892296Z 2025-02-25 06:58:16,787 INFO  [org.jboss.as.jpa] (ServerService Thread Pool -- 78) WFLYJPA0010: Starting Persistence Unit (phase 1 of 2) Service 'ROOT.war#JPAWorldDatasourcePU'
2025-02-25T06:58:16.8070373Z 2025-02-25 06:58:16,805 INFO  [org.hibernate.jpa.internal.util.LogHelper] (ServerService Thread Pool -- 78) HHH000204: Processing PersistenceUnitInfo [name: JPAWorldDatasourcePU]
```

## Exercise summary

In this unit, you learned how to configure and deploy a Jakarta EE 10 application to JBoss EAP on Azure App Service. Then, you used a `DataSource` object for connecting MySQL to JBoss EAP in a startup script.

You also learned how to access the remote server from both the CLI and the GUI by using a TCP tunnel. Finally, you accessed the log file from a local machine.
