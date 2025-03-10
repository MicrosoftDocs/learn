In this unit, you deploy a Jakarta EE application to JBoss EAP on Azure App Service. You use the Maven Plugin for Azure App Service to configure the project, compile and deploy the application, and configure a data source.

## Configure the app the Maven Plugin for Azure App Service

Configure the app with the Maven Plugin for Azure App Service by using the following steps:

1. Run the config goal of the Azure plug-in interactively by using the following command:

    ```bash
    ./mvnw com.microsoft.azure:azure-webapp-maven-plugin:2.13.0:config
    ```

    > [!IMPORTANT]  
    > If you change the region of your MySQL server, you should also change to the same region for your Jakarta EE application server to minimize latency delays.

    Use the values in the following table to answer the interactive prompts:

    |  Input element  |  Value  |
    | ---- | ---- |
    | `Create new run configuration (Y/N) [Y]:` | `Y` |
    |  `Define value for OS [Linux]:`  |  `Linux`  |
    |  `Define value for javaVersion [Java 17]:`  |  `1: Java 17`  |
    |  `Define value for runtimeStack:`  |  `3: Jbosseap 7`  |
    |  `Define value for pricingTier [P1v3]:`  |  `P1v3`  |
    |  `Confirm (Y/N) [Y]:` | `Y` |

    The following output is typical:

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

    After running the Maven command, the following example is a typical addition to your Maven `pom.xml` file:

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

1. Check the `<region>` element in **pom.xml**. If it's not the same installation location as MySQL, change it to the same location.

1. Use the following example to modify the `webContainer` value in your **pom.xml** file to `Jbosseap 8`, for the JBoss EAP 8 environment on Azure App Service:

    > [!TIP]
    > As of February 2025, the latest available version of JBoss EAP is 8.0 Update 4.1.

    ```xml
                    <runtime>
                        <os>Linux</os>
                        <javaVersion>Java 17</javaVersion>
                        <webContainer>Jbosseap 8</webContainer> <!-- Change this value -->
                    </runtime>
    ```

1. To deploy the startup file, add the following example to **pom.xml**. 

    ```xml
              </runtime>
              <deployment>
                <resources>
                  <!-- Add the following lines -->
                  <resource>
                    <type>startup</type>
                    <directory>${project.basedir}/src/main/webapp/WEB-INF/</directory>
                    <includes>
                      <include>createMySQLDataSource.sh</include>
                    </includes>
                  </resource>
                  <!-- Add the following lines -->
    ```

    The resource `<type>startup</type>` deploys the specified script as **startup.sh** for Linux or **startup.cmd** for Windows, to **/home/site/scripts/**.

    > [!NOTE]  
    > You can choose the deployment option and deployment location by specifying `type` in one of the following ways:
    >
    > - `type=war` deploys the WAR file to **/home/site/wwwroot/app.war** if `path` is not specified.
    > - `type=war&path=webapps/<appname>` deploys the WAR file to **/home/site/wwwroot/webapps/\<appname\>**.
    > - `type=jar` deploys the WAR file to **/home/site/wwwroot/app.jar**. The `path` parameter is ignored.
    > - `type=ear` deploys the WAR file to **/home/site/wwwroot/app.ear**. The `path` parameter is ignored.  
    > - `type=lib` deploys the JAR to **/home/site/libs**. You must specify `path` parameter.
    > - `type=static` deploys the script to **/home/site/scripts**. You must specify the `path` parameter.
    > - `type=startup` deploys the script as **startup.sh** on Linux, or  or **startup.cmd** on Windows. The script is deployed to **/home/site/scripts/**. The `path` parameter is ignored.
    > - `type=zip` unzips the **.zip** file to **/home/site/wwwroot**. The `path` parameter is optional.

1. Check the values for `resourceGroup` and `appName` in **pom.xml**, as in the following typical example:

    ```xml
    <resourceGroup>jakartaee-app-on-jboss-1625038814881-rg</resourceGroup>
    <appName>jakartaee-app-on-jboss-1625038814881</appName>
    ```

1. Assign the values for `resourceGroup` and `appName` to
environment variables by using the following commands:

    ```bash
    export RESOURCE_GROUP_NAME=jakartaee-app-on-jboss-1625038814881-rg
    export WEB_APP_NAME=jakartaee-app-on-jboss-1625038814881
    ```

## Compile and build the Jakarta EE app

After you configure the Azure App Service deployment settings, compile and package the source code by using the following command:

```bash
./mvnw clean package
```

The following is typical output:

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

After you compile and package the code, deploy the application by using the following command:

```bash
./mvnw azure-webapp:deploy
```

The following output is typical:

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

The output line that begins with `[INFO] Successfully deployed the artifact` contains the URL of the deployed application.

```output
[INFO] Successfully deployed the artifact to https://jakartaee-app-on-jboss-1625038814881.azurewebsites.net
```

## Configure a database connection

The sample application connects to your MySQL Database and displays data. In the Maven project configuration in the **pom.xml** file, you specified the MySQL JDBC driver using the following example:

```xml
    <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>${mysql-jdbc-driver}</version>
    </dependency>
```

As a result, JBoss EAP automatically installs the JDBC drive `ROOT.war_com.mysql.cj.jdbc.Driver_9_2` to your deployment package, **ROOT.war**.

## Create the MySQL DataSource object in JBoss EAP

To access Azure Database for MySQL, you need to configure the `DataSource` object in JBoss EAP and specify the JNDI name in your source code.

To create a MySQL `DataSource` object in JBoss EAP, you use the **/WEB-INF/createMySQLDataSource.sh** startup shell script. The following is a version of the script that's already been uploaded to App Service, but hasn't yet been configured:

```bash
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
> When you create the data source, you don't specify a password for the MySQL connection. The environment variable `AZURE_MYSQL_CONNECTIONSTRING` is specified in the `--connection-url` parameter. This environment variable will be automatically set when the service connection is created later.
> The service connection value will be set to `jdbc:mysql://$$MYSQL_SERVER_INSTANCE.mysql.database.azure.com:3306/world?serverTimezone=UTC&sslmode=required&user=aad_jbossapp`, which uses the `aad_jbossapp` username without a password.
> By appending `&authenticationPlugins=com.azure.identity.extensions.jdbc.mysql.AzureMysqlAuthenticationPlugin` to this URL, Azure AD authentication is enabled for the `aad_jbossapp` user.

Configure your App Service instance to invoke the startup script by using the following command:

```azurecli
az webapp config set \
    --resource-group ${RESOURCE_GROUP_NAME}
    --name ${WEB_APP_NAME} \
    --startup-file '/home/site/scripts/startup.sh' \
```

After the script runs, the application server invokes it every time the application server is restarted.

> [!NOTE]
> If your deployment artifact isn't **ROOT.war**, change the `--driver-name=YOUR_ARTIFACT.war_com.mysql.cj.jdbc.Driver_9_2` value, too.

## Configure the service connection for MySQL flexible server

After you configure the startup script, configure App Service to use Service Connector for the MySQL flexible server connection by using the following steps:

1. The following environment variables need to be set:

    - `PASSWORDLESS_USER_NAME_SUFFIX`, which is the suffix for the username used to connect to the MySQL flexible server. The username created will have the prefix `aad_` followed by the specified suffix.
    - `SOURCE_WEB_APP_ID`, which is the ID of the Azure App Service instance used to connect to the MySQL flexible server.
    - `MYSQL_ID`, which is the ID of the MySQL flexible server.
    - `TARGET_MYSQL_ID`, which specifies the database name as `world`, to establish a connection with a user who has permissions to access the `world` database.
    - `MANAGED_ID`, which is the managed identity used to connect to the MySQL flexible server.

    Set the environment variables by using the following commands:

    > [!NOTE]
    > The parameters in these commands apply to the Azure command line substitutions - such as `az webapp list` - not the `export` commands.

    ```bash
    export PASSWORDLESS_USER_NAME_SUFFIX=jbossapp
    export SOURCE_WEB_APP_ID=$(az webapp list \
        --resource-group  $RESOURCE_GROUP_NAME \ 
        --query "[0].id" \
        --output tsv)
    export MYSQL_ID=$(az mysql flexible-server list \
        --resource-group $RESOURCE_GROUP_NAME \
        --query "[0].id" \
        --output tsv)
    export TARGET_MYSQL_ID=$MYSQL_ID/databases/world 
    export MANAGED_ID=$(az identity list \
        --resource-group $RESOURCE_GROUP_NAME 
        --query "[0].id"
        --output tsv)
    ```

1. Add the extension for `serviceconnector-passwordless` and create the service connection by using the following commands:

    ```azurecli
    az extension add \
        --name serviceconnector-passwordless \
        --upgrade
    az webapp connection create mysql-flexible \
        --resource-group ${RESOURCE_GROUP_NAME} \
        --connection $PASSWORDLESS_USER_NAME_SUFFIX \
        --source-id $SOURCE_WEB_APP_ID \
        --target-id $TARGET_MYSQL_ID \
        --client-type java \
        --system-identity mysql-identity-id=$MANAGED_ID
    ```

    > [!NOTE]
    > if you get an error message like `Resource '********-****-****-****-************' does not exist or one of its queried reference-property objects are not present.`, re-run the command after a few seconds.

1. Check the list of users registered in MySQL again by using the following command:

    ```sql
    SELECT user, host, plugin FROM mysql.user;
    ```

    The following output is typical:

    ```output
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

    You should see that a user named `aad_jbossapp` has been added, which uses the `aad_auth` plugin. From JBoss EAP deployed on Azure, you can connect to the MySQL flexible server using the `aad_jbossapp` username without a password.

## Confirm the data source reference in the code

Previously, you implemented the database access code by using Java Persistence API (JPA). To configure the data source reference in your application project and access the MySQL database from your application, use the following steps:

1. The configuration for the `DataSource` reference was added in the configuration file of the JPA, **src/main/resources/META-INF/persistence.xml**. Check this file to see if the `DataSource` name matches the name used in the configuration. The code already created the JNDI name as `java:jboss/datasources/JPAWorldDataSource`, as in the following example:

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

1. Access the MySQL database referenced in the `PersistenceContext` unit name by using the following example:

    ```java
    @Transactional(REQUIRED)
    @RequestScoped
    public class CityService {
    
        @PersistenceContext(unitName = "JPAWorldDatasourcePU")
        EntityManager em;
    ```

## Access the application

In the sample application, you implemented three REST endpoints. You can access the application and validate these endpoints by using a web browser or a `curl` command. To access the application and retrieve data, use the following steps:

### [Browser](#tab/browser)

1. Use your browser to navigate to the application URL, which you got from previous output. The relevant line begins with `[INFO] Successfully deployed the artifact`, as in the following typical output:

    ```output
    [INFO] Successfully deployed the artifact to  
    https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net
    ```

1. Use the `GET` method on the `area` endpoint to get all of the continent information in JSON format.

    :::image type="content" source="../media/rest-endpoint-area.png" alt-text="Screenshot that shows area as the REST endpoint.":::

1. Specify a `continent` path parameter on the `area` endpoint and the `GET` method to retrieve all of the countries and regions in the specified continent.

    :::image type="content" source="../media/rest-endpoint-continent.png" alt-text="Screenshot that shows continent as the REST endpoint.":::

1. Specify a `countrycode` path parameter on the `countries` endpoint and the `GET` method to retrieve all of the cities that have a population greater than 1 million within the country or region specified.

    :::image type="content" source="../media/rest-endpoint-cities.png" alt-text="Screenshot that shows cities as the REST endpoint.":::

### [Bash](#tab/bash)

1. Use the following command to retrieve all of the continents, in JSON format:

    ```bash
    curl https://${WEB_APP_NAME}.azurewebsites.net/area
    ```

    The following output is typical:

    ```output
    ["North America","Asia","Africa","Europe","South America","Oceania","Antarctica"]
    ```

1. Use the following command to retrieve all of the countries and regions in a specified continent:

    ```bash
    curl https://${WEB_APP_NAME}.azurewebsites.net/area/Asia | jq '.[] | { name: .name, code: .code }'
    ```

    In this example, the user specified `Asia`. The following output is typical:

    ```output
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
    ```

1. Retrieve all of the cities that have a population greater than 1 million within the specified country or region, by using the following command:

    ```bash
    curl https://${WEB_APP_NAME}.azurewebsites.net/countries/JPN | jq '.[].name'
    ```

    In this example, the user specified `JPN`. The following output is typical:

    ```output
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

---

## Exercise summary

In this unit, you validated the application REST endpoints and tested that your application can get data from your MySQL database. In the next unit, you examine the server logs.
