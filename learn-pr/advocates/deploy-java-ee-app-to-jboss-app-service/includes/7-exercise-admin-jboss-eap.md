In this exercise, we'll access the JBoss Admin interface and stream its logs

### Create a TCP Tunnel

To access the remote server, you need to create a TCP Tunnel between your remote server and your local machine.
Execute the following command:

```azurecli
$ az webapp create-remote-connection -n jakartaee-app-on-jboss-1606464084546 \
  -g jakartaee-app-on-jboss-1606464084546-rg

Verifying if app is running....
App is running. Trying to establish tunnel connection...
Opening tunnel on port: 59445
SSH is available { username: root, password: Docker! }
Ctrl + C to close
```

Then you'll get the following information from the command result:

|  Required Information  |  Value  |
| ---- | ---- |
|  Opening tunnel on port  |  PORT_NUMBER (ex. 59445)  |
|  username  |  root  |
|  password  |  Docker!  |

### SSH with TCP Tunnel

You now need to sign in to the Server by using a `ssh` command.
Open a new command terminal and execute the following command:

```bash
ssh root@127.0.0.1 -L 9990:localhost:9990 -p $PORT_NUMBER (ex. 59445)
```

> [!TIP]
> If you would like to access to the JBoss EAP Admin Web Console, please specify the `-L 9990:localhost:9990` option. Then access `http://localhost:9990/console` for the JBoss Web Console. If you don't need to login the JBoss Web Console, you can remove the "-L" option.

You'll see following messages when you sign in to the Server:

```bash
The authenticity of host '[127.0.0.1]:59445 ([127.0.0.1]:59445)' can't be established.
ECDSA key fingerprint is SHA256:vHsp1b3+7NtnHISvZ6aKS82pww+e5L6CUc9fKaPZGDQ.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '[127.0.0.1]:59445' (ECDSA) to the list of known hosts.
root@127.0.0.1's password: 
Last login: Fri Nov 27 06:41:33 2020 from yoshio-jbosseap_kudu_1_d7fdf00b.yoshio-jbosseap_nw
  _____                               
  /  _  \ __________ _________   ____  
 /  /_\  \___   /  |  \_  __ \_/ __ \ 
/    |    \/    /|  |  /|  | \/\  ___/ 
\____|__  /_____ \____/ |__|    \___  >
        \/      \/                  \/ 
A P P   S E R V I C E   O N   L I N U X

Documentation: http://aka.ms/webapp-linux

**NOTE**: No files or system changes outside of /home will persist beyond your application's current session. /home is your application's persistent storage and is shared across all the server instances.


-bash-4.2# 
```

### Execute the JBoss CLI

After signing in to the remote server, you can execute the JBoss EAP Admin CLI Tool as `jboss-cli.sh`.
The CLI command is located on `/opt/eap/bin/` directory.
Connect to JBoss EAP by using following command:

```bash
-bash-4.2# /opt/eap/bin/jboss-cli.sh --connect
Picked up JAVA_TOOL_OPTIONS: -Xmx2402M -Djava.net.preferIPv4Stack=true 
```

After connecting to the JBoss EAP Server, execute the JBoss CLI command and get the JBoss Server Information:

```bash
[standalone@localhost:9990 /] :product-info
{
    "outcome" => "success",
    "result" => [{"summary" => {
        "host-name" => "05b2037f748e",
        "instance-identifier" => "895f0c88-5c7d-440f-9e45-e972f5cc14a5",
        "product-name" => "JBoss EAP",
        "product-version" => "7.2.9.GA",
        "product-community-identifier" => "Product",
        "product-home" => "/opt/eap",
        "last-update-date" => "8/27/20 1:09 PM",
        "standalone-or-domain-identifier" => "STANDALONE_SERVER",
        "host-operating-system" => "Red Hat Enterprise Linux Server 7.8 (Ma
ipo)",
        "host-cpu" => {
            "host-cpu-arch" => "amd64",
            "host-core-count" => 1
        },
        "jvm" => {
            "name" => "OpenJDK 64-Bit Server VM",
            "java-version" => "1.8",
            "jvm-version" => "1.8.0_262",
            "jvm-vendor" => "Oracle Corporation",
            "java-home" => "/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.262.b10-0
.el7_8.x86_64/jre"
        }
    }}]
}
```

You can get all of the deployed Applications from following command:

```bash
[standalone@localhost:9990 /] ls deployment
ROOT.war          activemq-rar.rar  
```

Next, test the database connection by executing the following command:

```bash
[standalone@localhost:9990 /] /subsystem=datasources/data-source="JPAWorldDataSourceDS":test-connection-in-pool
{
    "outcome" => "success",
    "result" => [true]
}
```

### Access the JBoss EAP Admin Web Console

Next let us access the JBossAdmin Web Console.
First, create an admin user and password for authentication:

```bash
-bash-4.2# /opt/eap/bin/add-user.sh -u admin -p admin -r ManagementRealm
```

Now you can access the Web Console from your Local environment.
Using a browser, access the following URL:

```html
http://127.0.0.1:9990/console
```

Then you'll see the following Sign-on Screen and you can sign in with the previously created user name and password:

:::image type="content" source="../media/jboss-admin-console1.png" alt-text="Admin Console Auth Window":::

After signing in to the Web Console, you'll see the following screen:

:::image type="content" source="../media/jboss-admin-console2.png" alt-text="Admin Console Top Page":::

You can confirm your created Datasource from `Configuration` -> `Subsystems` -> `Datasources & Drivers` -> `Datasources`.

:::image type="content" source="../media/jboss-admin-console3.png" alt-text="Admin Console DataSources List":::

You can also confirm your RESTful endpoints of your application from `Runtime` -> `system` -> `JAX-RS` -> `Your Application`.

:::image type="content" source="../media/jboss-admin-console4.png" alt-text="Admin Console RESTful Endpoint":::

> [!WARNING]
> If you directly access to the Remote Server via the JBoss CLI command or Web Console and add or update some configuration, the configuration will be cleared and deleted after the Azure App Services instance is rebooted. To persist the configuration, configure this in a Start up script.
For example, we created the `createMySQLDataSource.sh` in previous section as a startup script.

## Open a Log stream

Next let's sign in to the server and access the Application log.
You can access the Application sign in your local machine, by executing the following command:

```azurecli
az webapp log tail --name ${WEBAPP_NAME} \
 --resource-group ${RESOURCEGROUP_NAME}
```

After executing the above command, you'll get your log output:

```azurecli
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

## Exercise Summary

In this unit, you learned how to configure and deploy a Java EE 8 (Jakarta EE) Application to JBoss EAP on Azure App Service.
Then we created a `DataSource` for connecting MySQL to JBoss EAP in a startup script.
We also learned how to access the Remote Server from both CLI and GUI using a TCP Tunnel.
Finally, we accessed the log file from our local machine.
