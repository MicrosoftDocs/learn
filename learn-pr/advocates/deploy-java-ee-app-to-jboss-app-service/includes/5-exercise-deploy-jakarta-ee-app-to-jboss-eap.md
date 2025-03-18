In this unit, you deploy a Jakarta EE application to Red Hat JBoss Enterprise Application Platform (JBoss EAP) on Azure App Service. You use the Maven Plugin for Azure App Service to configure the project, compile and deploy the application, and configure a data source.

## Configure the app

Configure the app with the Maven Plugin for Azure App Service by using the following steps:

1. Run the config goal of the Azure plug-in interactively by using the following command:

    ```bash
    ./mvnw com.microsoft.azure:azure-webapp-maven-plugin:2.13.0:config
    ```

    > [!IMPORTANT]
    > If you change the region of your MySQL server, you should match that region to the region of your Jakarta EE application server in order to minimize latency delays.

1. Use the values in the following table to answer the interactive prompts:

    | Input element                             | Value           |
    |-------------------------------------------|-----------------|
    | `Create new run configuration (Y/N) [Y]:` | `Y`             |
    | `Define value for OS [Linux]:`            | `Linux`         |
    | `Define value for javaVersion [Java 17]:` | `1: Java 17`    |
    | `Define value for runtimeStack:`          | `3: Jbosseap 7` |
    | `Define value for pricingTier [P1v3]:`    | `P1v3`          |
    | `Confirm (Y/N) [Y]:`                      | `Y`             |

    The following output is typical:

    ```output
    [INFO] Saving configuration to pom.
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  03:00 min
    [INFO] Finished at: 2025-02-21T06:24:11+09:00
    [INFO] ------------------------------------------------------------------------
    ```

    After you use the Maven command, the following example is a typical addition to your Maven **pom.xml** file:

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
                <resourceGroup>jakartaee-app-on-jboss-rg</resourceGroup>
                <appName>jakartaee-app-on-jboss</appName>
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

1. Check the `<region>` element in your **pom.xml** file. If its value doesn't match the installation location of MySQL, change it to the same location.

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

1. Add the following XML to the `<resources>` element of your **pom.xml** file. This configuration is used to deploy the startup file, which you update later in this unit.

    ```xml
    <resource>
      <type>startup</type>
      <directory>${project.basedir}/src/main/webapp/WEB-INF/</directory>
      <includes>
        <include>createMySQLDataSource.sh</include>
      </includes>
    </resource>
    ```

    The resource `<type>` value of `startup` deploys the specified script as the **startup.sh** file for Linux or **startup.cmd** for Windows. The deployment location is **/home/site/scripts/**.

    > [!NOTE]
    > You can choose the deployment option and deployment location by specifying `type` in one of the following ways:
    >
    > - `type=war` deploys the WAR file to **/home/site/wwwroot/app.war** if `path` isn't specified.
    > - `type=war&path=webapps/<appname>` deploys the WAR file to **/home/site/wwwroot/webapps/\<appname\>**.
    > - `type=jar` deploys the WAR file to **/home/site/wwwroot/app.jar**. The `path` parameter is ignored.
    > - `type=ear` deploys the WAR file to **/home/site/wwwroot/app.ear**. The `path` parameter is ignored.
    > - `type=lib` deploys the JAR to **/home/site/libs**. You must specify `path` parameter.
    > - `type=static` deploys the script to **/home/site/scripts**. You must specify the `path` parameter.
    > - `type=startup` deploys the script as **startup.sh** on Linux, or **startup.cmd** on Windows. The script is deployed to **/home/site/scripts/**. The `path` parameter is ignored.
    > - `type=zip` unzips the **.zip** file to **/home/site/wwwroot**. The `path` parameter is optional.

1. Check the values for the `resourceGroup` and `appName` elements in your **pom.xml** file.

1. Assign the values for `resourceGroup` and `appName` to
environment variables by using the following commands:

    ```bash
    export RESOURCE_GROUP_NAME=<resource-group>
    export WEB_APP_NAME=<app-name>
    ```

## Compile and build the Jakarta EE app

After you configure the Azure App Service deployment settings, compile and package the source code by using the following command:

```bash
./mvnw clean package
```

The following output is typical:

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

You should see output that includes a success message and the URL of the deployed application. Be sure to save aside the URL for later use.

## Configure a database connection

The sample application connects to your MySQL database and displays data. The Maven project configuration in the **pom.xml** file specifies the MySQL JDBC driver as shown in the following example:

```xml
<dependency>
  <groupId>mysql</groupId>
  <artifactId>mysql-connector-java</artifactId>
  <version>${mysql-jdbc-driver}</version>
</dependency>
```

As a result, JBoss EAP automatically installs the JDBC driver `ROOT.war_com.mysql.cj.jdbc.Driver_9_2` to your deployment package **ROOT.war**.

## Create the MySQL DataSource object in JBoss EAP

To access Azure Database for MySQL, you need to configure the `DataSource` object in JBoss EAP and specify the Java Naming and Directory Interface (JNDI) name in your source code. To create a MySQL `DataSource` object in JBoss EAP, you use the **/WEB-INF/createMySQLDataSource.sh** startup shell script. The following example shows an unconfigured version of the script already in Azure App Service:

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
> When you create the datasource, you don't specify a password for the MySQL connection. The environment variable `AZURE_MYSQL_CONNECTIONSTRING` is specified in the `--connection-url` parameter. This environment variable is automatically set when the service connection is created later.
>
> The service connection value is set to `jdbc:mysql://$MYSQL_SERVER_INSTANCE.mysql.database.azure.com:3306/world?serverTimezone=UTC&sslmode=required&user=aad_jbossapp`, which uses the `aad_jbossapp` username without a password.
> By appending `&authenticationPlugins=com.azure.identity.extensions.jdbc.mysql.AzureMysqlAuthenticationPlugin` to this URL, Microsoft Entra ID authentication is enabled for the `aad_jbossapp` user.

Configure your App Service instance to invoke the startup script by using the following command:

```azurecli
az webapp config set \
    --resource-group ${RESOURCE_GROUP_NAME} \
    --name ${WEB_APP_NAME} \
    --startup-file '/home/site/scripts/startup.sh'
```

After the script runs, the application server invokes it every time the application server is restarted.

> [!NOTE]
> If your deployment artifact isn't **ROOT.war**, change the `--driver-name=YOUR_ARTIFACT.war_com.mysql.cj.jdbc.Driver_9_2` value, too.

## Configure the service connection for MySQL flexible server

After you configure the startup script, configure App Service to use Service Connector for the MySQL flexible server connection by using the following steps:

1. Set environment variables by using the following commands:

    ```azurecli
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
        --resource-group $RESOURCE_GROUP_NAME \
        --query "[0].id" \
        --output tsv)
    ```

    The environment variables are used for the following purposes:

    - `PASSWORDLESS_USER_NAME_SUFFIX` is the suffix for the username used to connect to the MySQL flexible server. The username created has the prefix `aad_` followed by the specified suffix.
    - `SOURCE_WEB_APP_ID` is the ID of the Azure App Service instance used to connect to the MySQL flexible server.
    - `MYSQL_ID` is the ID of the MySQL flexible server.
    - `TARGET_MYSQL_ID` specifies the database name as `$MYSQL_ID/databases/world` to establish a connection with a user who has permission to access the `world` database.
    - `MANAGED_ID` is the managed identity used to connect to the MySQL flexible server.

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

1. At the SQL prompt, check the list of users registered in MySQL by using the following query:

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

    You should see an `aad_jbossapp` user that uses the `aad_auth` plugin. From JBoss EAP deployed on Azure, you can connect to the MySQL flexible server using the `aad_jbossapp` username without a password.

## Confirm the DataSource reference in the code

To access the MySQL database from your application, you need to configure the data source reference in your application project.

The database access code is implemented using the Java Persistence API (JPA). The configuration for the `DataSource` reference is in the JPA configuration file **persistence.xml**.

Use the following steps to confirm the `DataSource` reference:

1. Open the **src/main/resources/META-INF/persistence.xml** file and check to see if the `DataSource` name matches the name used in the configuration. The startup script already created the JNDI name as `java:jboss/datasources/JPAWorldDataSource`, as shown in the following example:

    ```xml
    <persistence-unit name="JPAWorldDatasourcePU" transaction-type="JTA">
      <jta-data-source>java:jboss/datasources/JPAWorldDataSource</jta-data-source>
      <exclude-unlisted-classes>false</exclude-unlisted-classes>
      <properties>
        <property name="hibernate.generate_statistics" value="true" />
        <property name="hibernate.dialect" value="org.hibernate.dialect.MySQLDialect" />
      </properties>
    </persistence-unit>
    ```

1. Access the MySQL database in the `PersistenceContext` unit name as shown in the following example:

    ```java
    @Transactional(REQUIRED)
    @RequestScoped
    public class CityService {

        @PersistenceContext(unitName = "JPAWorldDatasourcePU")
        EntityManager em;
    ```

## Access the application

The sample application implements three REST endpoints. To access the application and retrieve data, use the following steps:

### [Browser](#tab/browser)

1. Use your browser to navigate to the application URL, which was shown in the output when you deployed the application.

1. To get all the continent information in JSON format, use the `GET` method on the `area` endpoint.

    :::image type="content" source="../media/rest-endpoint-area.png" alt-text="Screenshot of the area endpoint." lightbox="../media/rest-endpoint-area.png":::

1. To get all the countries and regions in a specified continent, use the `GET` method on the `area` endpoint and specify a `continent` path parameter.

    :::image type="content" source="../media/rest-endpoint-continent.png" alt-text="Screenshot of the area endpoint with a continent path parameter." lightbox="../media/rest-endpoint-continent.png":::

1. To get all the cities that have a population greater than one million within the country or region specified, use the `GET` method on the `countries` endpoint and specify a `countrycode` path parameter.

    :::image type="content" source="../media/rest-endpoint-cities.png" alt-text="Screenshot of the countries endpoint with the countrycode path parameter." lightbox="../media/rest-endpoint-cities.png":::

### [Bash](#tab/bash)

1. To get all the continent information in JSON format, use the following command:

    ```bash
    curl https://${WEB_APP_NAME}.azurewebsites.net/area
    ```

    The following output is typical:

    ```output
    ["North America","Asia","Africa","Europe","South America","Oceania","Antarctica"]
    ```

1. To get all the countries and regions in a specified continent, use the following command:

    ```bash
    curl https://${WEB_APP_NAME}.azurewebsites.net/area/Asia | jq '.[] | { name: .name, code: .code }'
    ```

    This example uses `Asia` and produces the following output:

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

1. To get all the cities that have a population greater than one million within the country or region specified, use the following command:

    ```bash
    curl https://${WEB_APP_NAME}.azurewebsites.net/countries/JPN | jq '.[].name'
    ```

    This example uses `JPN` and produces the following output:

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

In this unit, you validated the application REST endpoints and confirmed that your application can get data from your MySQL database. In the next unit, you examine the server logs.
