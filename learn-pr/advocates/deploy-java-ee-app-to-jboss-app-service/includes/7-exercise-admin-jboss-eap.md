In this exercise, you access the JBoss administration tools and stream the application logs.

## Create a TCP tunnel

To access the remote server, create a TCP tunnel between your remote server and your local machine by using the following command:

```azurecli
az webapp create-remote-connection \
    --resource-group ${RESOURCE_GROUP_NAME} \
    --name ${WEB_APP_NAME}
```

The following output is typical:

```output
Verifying if app is running....
App is running. Trying to establish tunnel connection...
Opening tunnel on port: 59445
SSH is available { username: root, password: Docker! }
Ctrl + C to close
```

The output also provides the following information that you use in the next section:

| Required information     | Value                                |
|--------------------------|--------------------------------------|
| `Opening tunnel on port` | `PORT_NUMBER` (for example, `59445`) |
| `username`               | `root`                               |
| `password`               | `Docker!`                            |

## Sign in by using SSH and the TCP tunnel

To sign in to the server using SSH and a TCP tunnel, use the following steps:

1. Open a new command terminal.

1. Sign in to the server by using the following commands:

    ```bash
    export PORT_NUMBER=<the port number from above>
    ssh root@127.0.0.1 -L 9990:localhost:9990 -p $PORT_NUMBER 
    ```

    > [!TIP]
    > If you want to access to the JBoss EAP admin web console, specify the `-L 9990:localhost:9990` option. Then access the JBoss web console at `http://localhost:9990/console`. If you don't need to sign in to the JBoss web console, you can remove the `-L` option.

    The following output is typical:

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
    ```

## Run the JBoss CLI tool

After you sign in to the remote server, you can run the JBoss EAP admin CLI tool, **/opt/eap/bin/jboss-cli.sh**, by using the following steps:

1. Connect to JBoss EAP by using the following command:

    ```bash
    /opt/eap/bin/jboss-cli.sh --connect
    ```

    The following output is typical:

    ```output
    OpenJDK 64-Bit Server VM warning: Options -Xverify:none and -noverify were deprecated in JDK 13 and will likely be removed in a future release.
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

1. Use the following command to list all of the deployed applications:

    ```bash
    ls deployment
    ```

    The following output is typical:

    ```output
    ROOT.war
    ```

1. Test the database connection by using the following command:

    ```bash
    [standalone@localhost:9990 /] /subsystem=datasources/data-source="JPAWorldDataSourceDS":test-connection-in-pool
    ```

    The following output is typical:

    ```output
    {
        "outcome" => "success",
        "result" => [true]
    }
    ```

1. Exit from the JBoss EAP CLI by using the following command:

    ```bash
    exit
    ```

## Access the JBoss EAP admin web console

Next, access the JBoss admin web console by using the following steps:

1. Create an admin user and password for authentication by using the following command:

    ```bash
    /opt/eap/bin/add-user.sh -u admin -p admin -r ManagementRealm
    ```

    The following output is typical:

    ```output
    Picked up JAVA_TOOL_OPTIONS: -Xmx5480M -Djava.net.preferIPv4Stack=true
    Updated user 'admin' to file '/opt/eap/standalone/configuration/mgmt-users.properties'
    Updated user 'admin' to file '/opt/eap/domain/configuration/mgmt-users.properties'
    ```

1. Access the web console from a web browser in your local environment by using `http://127.0.0.1:9990/console`.

1. In the authentication dialog box, sign in with the previously created username and password.

    :::image type="content" source="../media/jboss-admin-console-authentication.png" alt-text="Screenshot of the authentication dialog box for the admin console." lightbox="../media/jboss-admin-console-authentication.png":::

    After you sign in to the web console, the following screen appears:

    :::image type="content" source="../media/jboss-admin-console-home-page.png" alt-text="Screenshot of the main page of the admin console." lightbox="../media/jboss-admin-console-home-page.png":::

1. Confirm that you created the datasource by selecting **Configuration** > **Subsystems** > **Datasources & Drivers** > **Datasources**.

    :::image type="content" source="../media/jboss-admin-console-configuration.png" alt-text="Screenshot of the list of data sources on the admin console." lightbox="../media/jboss-admin-console-configuration.png":::

1. Optionally, confirm the RESTful endpoints of your application by selecting **Runtime** > *your system* > **JAX-RS** > *your application*.

    :::image type="content" source="../media/jboss-admin-console-runtime.png" alt-text="Screenshot of the RESTful endpoints on the admin console." lightbox="../media/jboss-admin-console-runtime.png":::

    > [!WARNING]
    > If you directly access the remote server via the JBoss CLI command or web console and add or update a configuration, the configuration is cleared and deleted after the Azure App Service instance is restarted. To persist the configuration, use a startup script. Because of this need, you created the **createMySQLDataSource.sh** startup script in a previous unit.

## Open a log stream

Access the logs by using the following command:

```azurecli
az webapp log tail \
    --resource-group ${RESOURCE_GROUP_NAME} \
    --name ${WEB_APP_NAME}
```

The following output is typical:

```output
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

You also learned how to access the remote server from both the CLI and the UI by using a TCP tunnel. Finally, you accessed the log file from a local machine.
