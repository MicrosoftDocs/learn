In this exercise, you'll deploy a Jakarta EE application to JBoss EAP on Azure App Service. You use the Maven plug-in to configure the project, compile and deploy the application, and configure a data source.

## Configure the app with the Maven Plugin for Azure App Service

Let's configure the application by executing the configuration goal in the Maven Plugin for Azure App Service.

```bash
./mvnw com.microsoft.azure:azure-webapp-maven-plugin:2.13.0:config
```

> [!IMPORTANT]  
> If you change the region of your MySQL server, you should also change to the same region for your Jakarta EE application server to minimize latency delays.  
> In the command, select Java 11 for Java version and JBoss EAP 7 for runtime stack.

|  Input element  |  Value  |
| ---- | ---- |
| `Create new run configuration (Y/N) [Y]:` | `Y` |
|  `Define value for OS [Linux]:`  |  `Linux`  |
|  `Define value for javaVersion [Java 17]:`  |  `1: Java 17`  |
|  `Define value for runtimeStack:`  |  `3: Jbosseap 7`  |
|  `Define value for pricingTier [P1v3]:`  |  `P1v3`  |
|  `Confirm (Y/N) [Y]:` | `Y` |

After you run the command, you'll get messages like the following in the terminal:

```output
 ./mvnw com.microsoft.azure:azure-webapp-maven-plugin:2.13.0:config
[INFO] Scanning for projects...
[INFO] 
[INFO] ---------< com.microsoft.azure.samples:jakartaee-app-on-jboss >---------
[INFO] Building jakartaee-app-on-jboss 0.1-SNAPSHOT
[INFO] --------------------------------[ war ]---------------------------------
[INFO] 
[INFO] --- azure-webapp-maven-plugin:2.13.0:config (default-cli) @ jakartaee-app-on-jboss ---
Create new run configuration (Y/N) [Y]: 
Define value for OS [Linux]:
  1: Windows
* 2: Linux
  3: Docker
Enter your choice: 
Define value for javaVersion [Java 17]:
* 1: Java 17
Enter your choice: 
Define value for webContainer [Tomcat 10.0]:
* 1: Tomcat 10.0
  2: Tomcat 9.0
  3: Jbosseap 7
Enter your choice: 3
Define value for pricingTier [P1v3]:
* 1: P1v3
  2: P2v3
  3: P3v3
Enter your choice: 
Please confirm webapp properties
AppName : jakartaee-app-on-jboss-1740086485353
ResourceGroup : jakartaee-app-on-jboss-1740086485353-rg
Region : centralus
PricingTier : P1v3
OS : Linux
Java Version: Java 17
Web server stack: Jbosseap 7
Deploy to slot : false
Confirm (Y/N) [Y]: 
[INFO] Saving configuration to pom.
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  03:00 min
[INFO] Finished at: 2025-02-21T06:24:11+09:00
[INFO] ------------------------------------------------------------------------
```

After the command finishes, you can see that following entry is added in your Maven `pom.xml` file.

```xml
  <build>
    <finalName>ROOT</finalName>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-war-plugin</artifactId>
        <version>3.4.0</version>
      </plugin>
        <plugin>
            <groupId>com.microsoft.azure</groupId>
            <artifactId>azure-webapp-maven-plugin</artifactId>
            <version>2.13.0</version>
            <configuration>
                <schemaVersion>v2</schemaVersion>
                <resourceGroup>jakartaee-app-on-jboss-1625038814881-rg</resourceGroup>
                <appName>jakartaee-app-on-jboss-1625038814881</appName>
                <pricingTier>P1v3</pricingTier>
                <region>centralus</region>
                <runtime>
                    <os>Linux</os>
                    <javaVersion>Java 17</javaVersion>
                    <webContainer>Jbosseap 7</webContainer>
                </runtime>
                <deployment>
                    <resources>
                        <resource>
                            <directory>${project.basedir}/target</directory>
                            <includes>
                                <include>*.war</include>
                            </includes>
                        </resource>
                    </resources>
                </deployment>
            </configuration>
        </plugin>
    </plugins>
  </build>
```

> [!IMPORTANT]
> Check the `<region>` element. If it's not the same installation location as MySQL, change it to the same location.

For this deployment, please modify the `webContainer` value to `Jbosseap 8` for the JBoss EAP 8 environment on Azure App Service.

```xml
                <runtime>
                    <os>Linux</os>
                    <javaVersion>Java 17</javaVersion>
                    <webContainer>Jbosseap 8</webContainer> <!-- Change this value -->
                </runtime>
```

After adding the above configuration for deploying to the Azure, add the following XML entries to deploy the startup file. The resource `<type>startup</type>` deploys the specified script as `startup.sh` (Linux) or `startup.cmd` (Windows) to `/home/site/scripts/`. We configure the startup script in the following step.

```xml
          </runtime>
          <deployment>
            <resources>
              <!-- Please add following lines -->
              <resource>
                <type>startup</type>
                <directory>${project.basedir}/src/main/webapp/WEB-INF/</directory>
                <includes>
                  <include>createMySQLDataSource.sh</include>
                </includes>
              </resource>
              <!-- Please add following lines -->
```

> [!NOTE]  
> You can specify the following resource to deploy in the XML:
> - `type=<war|jar|ear|lib|startup|static|zip>`
> 
>    - `type=war` will deploy the war file to `/home/site/wwwroot/app.war` if `path` is _not_ specified  
>    - `type=war&path=webapps/<appname>\` will behave exactly like wardeploy by unzipping app to /home/site/wwwroot/webapps/\<appname\>  
>    - `type=jar` will deploy the war file to `/home/site/wwwroot/app.jar`. `path` parameter will be ignored  
>    - `type=ear` will deploy the war file to `/home/site/wwwroot/app.ear`. `path` parameter will be ignored  
>    - `type=lib` will deploy the jar to /home/site/libs. `path` parameter must be specified
>    - `type=static` will deploy the script to `/home/site/scripts`. `path` parameter must specified  
>    - `type=startup` will deploy the script as `startup.sh` (Linux) or `startup.cmd` (Windows) to `/home/site/scripts/`. `path` parameter will be ignored  
>    - `type=zip` will unzip the zip to `/home/site/wwwroot`. `path` parameter is optional.

Now, check the values for the resource group name and application name from the above XML file. Note these names or better assign them to environment variables.

```xml
<resourceGroup>jakartaee-app-on-jboss-1625038814881-rg</resourceGroup>
<appName>jakartaee-app-on-jboss-1625038814881</appName>
```

If you're using Bash, configure the environment variables with the following command. You'll use these values later.

```bash
export RESOURCEGROUP_NAME=jakartaee-app-on-jboss-1625038814881-rg
export WEBAPP_NAME=jakartaee-app-on-jboss-1625038814881
```

## Compile and build the Jakarta EE app

After you configure the Azure App Service deployment settings, compile and package the source code.

```bash
./mvnw clean package
```

The following output appears in the terminal:

```output
[INFO] --- war:3.4.0:war (default-war) @ jakartaee-app-on-jboss ---
[INFO] Packaging webapp
[INFO] Assembling webapp [jakartaee-app-on-jboss] in [/private/tmp/mslearn-jakarta-ee-azure/target/ROOT]
[INFO] Processing war project
[INFO] Copying webapp resources [/private/tmp/mslearn-jakarta-ee-azure/src/main/webapp]
[INFO] Building war: /private/tmp/mslearn-jakarta-ee-azure/target/ROOT.war
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  4.881 s
[INFO] Finished at: 2025-02-21T06:32:30+09:00
[INFO] ------------------------------------------------------------------------
```

## Deploy the Jakarta EE app to JBoss EAP on Azure App Service

After you compile and package the code, deploy the application:

```bash
./mvnw azure-webapp:deploy
```

The following message appears in the terminal:

```output
[INFO] Start creating App Service plan (asp-jakartaee-app-on-jboss-eap8-yoshio)...
[INFO] App Service plan (asp-jakartaee-app-on-jboss-eap8-yoshio) is successfully created
[INFO] Start creating Web App(jakartaee-app-on-jboss-eap8-yoshio)...
[INFO] Web App(jakartaee-app-on-jboss-eap8-yoshio) is successfully created
[INFO] Trying to deploy external resources to jakartaee-app-on-jboss-eap8-yoshio...
[INFO] Successfully deployed the resources to jakartaee-app-on-jboss-eap8-yoshio
[INFO] Trying to deploy artifact to jakartaee-app-on-jboss-eap8-yoshio...
[INFO] Deploying (/mslearn-jakarta-ee-azure/target/ROOT.war)[war]  ...
[INFO] Deploying (/mslearn-jakarta-ee-azure/src/main/webapp/WEB-INF/createMySQLDataSource.sh)[startup]  ...
[INFO] Application url: https://jakartaee-app-on-jboss-eap8-yoshio.azurewebsites.net                
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  04:01 min
[INFO] Finished at: 2025-02-21T06:37:21+09:00
[INFO] ------------------------------------------------------------------------
```

Note the URL of the deployed application, particularly the following line in the Maven output:

```output
[INFO] Successfully deployed the artifact to https://jakartaee-app-on-jboss-1625038814881.azurewebsites.net
```

## Configure a database connection

The sample application connects to your MySQL Database and display data.

In the Maven project configuration in `pom.xml`, we specified the MySQL JDBC driver as follows:

```xml
    <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>${mysql-jdbc-driver}</version>
    </dependency>
```

As a result, JBoss EAP automatically installs the JDBC driver to your deployment package (`ROOT.war`). You can refer to the name of MySQL JDBC driver as follows:

```text
ROOT.war_com.mysql.cj.jdbc.Driver_9_2
```

## Create the MySQL DataSource object in JBoss EAP

To access Azure Database for MySQL, you need to configure the `DataSource` object in JBoss EAP and specify the JNDI name in your source code.

To create a MySQL `DataSource` object in JBoss EAP, we created the following startup shell script. The script file is `createMySQLDataSource.sh` under the `/WEB-INF` directory.

The source of the script file is shown next. This script file has already been uploaded to App Service, but it hasn't yet been configured to be invoked.

```shell
#!/bin/bash
# In order to use the variables in CLI scripts
# https://access.redhat.com/solutions/321513
sed -i -e "s|.*<resolve-parameter-values.*|<resolve-parameter-values>true</resolve-parameter-values>|g" /opt/eap/bin/jboss-cli.xml
/opt/eap/bin/jboss-cli.sh --connect <<EOF
data-source add --name=JPAWorldDataSourceDS \
--jndi-name=java:jboss/datasources/JPAWorldDataSource \
--connection-url=${AZURE_MYSQL_CONNECTIONSTRING}&characterEncoding=utf8&sslMode=REQUIRED&serverTimezone=UTC&authenticationPlugins=com.azure.identity.extensions.jdbc.mysql.AzureMysqlAuthenticationPlugin \
--driver-name=ROOT.war_com.mysql.cj.jdbc.Driver_9_2 \
--min-pool-size=5 \
--max-pool-size=20 \
--blocking-timeout-wait-millis=5000 \
--enabled=true \
--driver-class=com.mysql.cj.jdbc.Driver \
--jta=true \
--use-java-context=true \
--valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.mysql.MySQLValidConnectionChecker \
--exception-sorter-class-name=com.mysql.cj.jdbc.integration.jboss.ExtendedMysqlExceptionSorter
exit
EOF
```

> [!NOTE]
> It is important to note that when creating the data source, no password is specified for the MySQL connection.
> The environment variable `${AZURE_MYSQL_CONNECTIONSTRING}` is specified in the `--connection-url`. This environment variable will be automatically set when the `Service Connector` is created later.
> In practice, the value will be set as shown below. As you can see, the username `aad_jbossapp` is specified, but no password is provided.
> `jdbc:mysql://$$MYSQL_SERVER_INSTANCE.mysql.database.azure.com:3306/world?serverTimezone=UTC&sslmode=required&user=aad_jbossapp`
> By appending `&authenticationPlugins=com.azure.identity.extensions.jdbc.mysql.AzureMysqlAuthenticationPlugin` to this URL, Azure AD authentication is enabled for the `aad_jbossapp` user.

Now, configure your App Service instance to invoke the startup script:

# [Linux/Mac OS X](#tab/linux)

```azurecli
az webapp config set --startup-file '/home/site/scripts/startup.sh' \
-n ${WEBAPP_NAME} \
-g ${RESOURCEGROUP_NAME}
```

# [Git-bash for Windows](#tab/windows)

```azurecli
export MSYS_NO_PATHCONV=1
az webapp config set --startup-file '/home/site/scripts/startup.sh' \
-n ${WEBAPP_NAME} \
-g ${RESOURCEGROUP_NAME}
```
---

After the script runs, it'll be invoked every time the application server is restarted.

> [!NOTE]
> If your deployment artifact isn't `ROOT.war`, you need to change the `--driver-name=YOUR_ARTIFACT.war_com.mysql.cj.jdbc.Driver_9_2` value too.

## Configure the e Service Connector for MySQL flexible server

After you configure the startup script, configure App Service to use Service Connector for MySQL flexible server connection:

First, set the following environment variables. `PASSLESS_USER_NAME_SUFFIX` is the suffix for the username used to connect to the MySQL flexible server. In practice, the username created will have the prefix `aad_` followed by the specified suffix. `SOURCE_WEBAPP_ID` is the ID of the Azure App Service used to connect to the MySQL flexible server. `MYSQL_ID` is the ID of the MySQL flexible server. In this case, we want to establish a connection with a user who has permissions to access the world database, so `TARGET_MYSQL_ID` specifies the database name as `/database/world`. `MANAGEDID` is the managed identity used to connect to the MySQL flexible server.

```azurecli
export PASSLESS_USER_NAME_SUFFIX=jbossapp
export SOURCE_WEBAPP_ID=$(az webapp list -g  $RESOURCEGROUP_NAME --query "[0].id" -o tsv)
export MYSQL_ID=$(az mysql flexible-server list -g $RESOURCEGROUP_NAME --query "[0].id" -o tsv)
export TARGET_MYSQL_ID=$MYSQL_ID/databases/world 
export MANAGEDID=$(az identity list -g $RESOURCEGROUP_NAME --query "[0].id" -o tsv)
```

Add the extension for `serviceconnector-passwordless` and create the `Service Connector`. Please execute the following commands.

```azurecli
az extension add --name serviceconnector-passwordless --upgrade

az webapp connection create mysql-flexible -g $RESOURCEGROUP_NAME --connection $PASSLESS_USER_NAME_SUFFIX \
--source-id $SOURCE_WEBAPP_ID \
--target-id $TARGET_MYSQL_ID \
--client-type java \
--system-identity mysql-identity-id=$MANAGEDID
```

After executing the above commands, please check the list of users registered in MySQL again. You should see that a user named `aad_jbossapp` has been added, which uses the `aad_auth` plugin. From JBoss EAP deployed on Azure, you will be able to connect to the MySQL flexible server using this `aad_jbossapp` username without a password.

```mysql
mysql> SELECT user, host, plugin FROM mysql.user;
+----------------------------------+-----------+-----------------------+
| user                             | host      | plugin                |
+----------------------------------+-----------+-----------------------+
| aad_jbossapp                     | %         | aad_auth              |
| azureuser                        | %         | mysql_native_password |
| $CURRENT_AZ_LOGIN_USER_NAME#EXT#@| %         | aad_auth              |
| azure_superuser                  | 127.0.0.1 | mysql_native_password |
| azure_superuser                  | localhost | mysql_native_password |
| mysql.infoschema                 | localhost | caching_sha2_password |
| mysql.session                    | localhost | caching_sha2_password |
| mysql.sys                        | localhost | caching_sha2_password |
+----------------------------------+-----------+-----------------------+
8 rows in set (2.06 sec)
```

## Confirm the DataSource reference in the code

To access the MySQL database from your application, you need to configure the data source reference in your application project. We implemented the database access code by using Java Persistence API (JPA).

The configuration for the `DataSource` reference has been added in `persistence.xml`, which is the configuration file of the JPA.

Access the following file:

```text
├── src
│   ├── main
│   │   ├── resources
│   │   │   └── META-INF
│   │   │       └── persistence.xml
```

Check if the `DataSource` name matches the name used in the configuration. The code already created the JNDI name as `java:jboss/datasources/JPAWorldDataSource`:

```xml
  <persistence-unit name="JPAWorldDatasourcePU" transaction-type="JTA">
    <jta-data-source>java:jboss/datasources/JPAWorldDataSource</jta-data-source>
    <exclude-unlisted-classes>false</exclude-unlisted-classes>
    <properties>
      <property name="hibernate.generate_statistics" value="true" />
      <property name="hibernate.dialect" value="org.hibernate.dialect.MySQLDialect" />
    </properties>
  </persistence-unit>
</persistence>
```

Then you can access the MySQL database referenced in the `PersistenceContext` unit name as follows:

```java
@Transactional(REQUIRED)
@RequestScoped
public class CityService {

    @PersistenceContext(unitName = "JPAWorldDatasourcePU")
    EntityManager em;
```

## Access the application

In the sample application, we implemented three REST endpoints. You can access the application and validate these endpoints by using a web browser or a `curl` command.

To access the application, you need to reference the application URL, which you got from an earlier section:

```output
[INFO] Successfully deployed the artifact to  
https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net
```

Run the following command to get all the continent information in JSON format.

:::image type="content" source="../media/rest-endpoint-area.png" alt-text="Screenshot that shows area as the REST endpoint.":::

```bash
$ curl https://${WEBAPP_NAME}.azurewebsites.net/area
```

```bash
["North America","Asia","Africa","Europe","South America","Oceania","Antarctica"]$ 
```

If you specify the continent in the URL, you can get all the countries/regions in the specified continent.

:::image type="content" source="../media/rest-endpoint-continent.png" alt-text="Screenshot that shows continent as the REST endpoint.":::

```bash
$ curl https://${WEBAPP_NAME}.azurewebsites.net/area/Asia | jq '.[] | { name: .name, code: .code }'
```

```bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--   100 16189  100 16189    0     0  65278      0 --:--:-- --:--:-- --:--:-- 65542
{
  "name": "Afghanistan",
  "code": "AFG"
}
{
  "name": "United Arab Emirates",
  "code": "ARE"
}
{
  "name": "Armenia",
  "code": "ARM"
}
{
  "name": "Azerbaijan",
  "code": "AZE"
}
{
  "name": "Bangladesh",
  "code": "BGD"
}
....
```

Finally, if you specify a country/region code after `/countries`, you can get all the cities that have population greater than 1 million within the country/region.

:::image type="content" source="../media/rest-endpoint-cities.png" alt-text="Screenshot that shows cities as the REST endpoint.":::

```bash
$ curl https://${WEBAPP_NAME}.azurewebsites.net/countries/JPN | jq '.[].name'
```

```bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--   100   788  100   788    0     0   2671      0 --:--:-- --:--:-- --:--:--  2662
"Tokyo"
"Jokohama [Yokohama]"
"Osaka"
"Nagoya"
"Sapporo"
"Kioto"
"Kobe"
"Fukuoka"
"Kawasaki"
"Hiroshima"
"Kitakyushu"
```

## Exercise summary

You've now validated the application REST endpoints and tested that your application can get data from your MySQL database.

In the next unit, you'll examine the server logs.
