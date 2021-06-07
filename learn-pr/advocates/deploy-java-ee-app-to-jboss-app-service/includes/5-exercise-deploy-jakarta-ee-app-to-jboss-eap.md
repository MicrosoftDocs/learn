In this exercise, you'll deploy a Java EE (Jakarta EE) application to JBoss EAP on Azure App Service. You'll use the Maven plug-in to configure the project, compile and deploy the application, and configure a data source.

## Configure the app with the Maven Plugin for Azure App Service

Please confirmed `pom.xml` file and add the `<plugins>` entry in the XML file with following options.

|  Configurable element  |  Value  |
| ---- | ---- |
|  `subscriptionId` | `Your appropriate subscription` |
|  `resourceGroup` |  `Your appropriate resource group name`  |
|  `appName`  |  `Your Azure App Service Instance Name`  |
|  `region`  |  `Your appropriate install location`  |

```xml
<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">  
  <modelVersion>4.0.0</modelVersion>  
  <groupId>com.microsoft.azure.samples</groupId>  
  <artifactId>jakartaee-app-on-jboss</artifactId>  
  <version>1.0-SNAPSHOT</version>  
  <packaging>war</packaging>  
  <properties> 
    <maven.compiler.source>8</maven.compiler.source>  
    <maven.compiler.target>8</maven.compiler.target>  
    <failOnMissingWebXml>false</failOnMissingWebXml>  
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>  
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>  
    <jakarta.jakartaee-api.version>8.0.0</jakarta.jakartaee-api.version>  
    <junit-jupiter.version>5.5.0</junit-jupiter.version>  
    <mockito-core.version>3.1.0</mockito-core.version>  
    <mysql-jdbc-driver>8.0.22</mysql-jdbc-driver>  
    <openapi-ui>1.1.4</openapi-ui> 
  </properties>  
  <dependencies> 
    <dependency> 
      <groupId>jakarta.platform</groupId>  
      <artifactId>jakarta.jakartaee-api</artifactId>  
      <version>${jakarta.jakartaee-api.version}</version>  
      <scope>provided</scope> 
    </dependency>  
    <dependency> 
      <groupId>org.junit.jupiter</groupId>  
      <artifactId>junit-jupiter</artifactId>  
      <version>${junit-jupiter.version}</version>  
      <scope>test</scope> 
    </dependency>  
    <dependency> 
      <groupId>org.mockito</groupId>  
      <artifactId>mockito-core</artifactId>  
      <version>${mockito-core.version}</version>  
      <scope>test</scope> 
    </dependency>  
    <dependency> 
      <groupId>mysql</groupId>  
      <artifactId>mysql-connector-java</artifactId>  
      <version>${mysql-jdbc-driver}</version> 
    </dependency>  
    <dependency> 
      <groupId>io.swagger.core.v3</groupId>  
      <artifactId>swagger-jaxrs2</artifactId>  
      <version>2.1.5</version> 
    </dependency>  
    <dependency> 
      <groupId>io.swagger.core.v3</groupId>  
      <artifactId>swagger-jaxrs2-servlet-initializer</artifactId>  
      <version>2.1.5</version> 
    </dependency>  
    <dependency> 
      <groupId>org.microprofile-ext.openapi-ext</groupId>  
      <artifactId>openapi-ui</artifactId>  
      <version>1.1.4</version> 
    </dependency> 
  </dependencies>  
  <build> 
    <finalName>ROOT</finalName>  
    <plugins> 
      <plugin>
        <groupId>com.microsoft.azure</groupId>
        <artifactId>azure-webapp-maven-plugin</artifactId>
        <version>1.15.0</version>
        <configuration>
          <schemaVersion>v2</schemaVersion>
          <subscriptionId>********-****-****-****-************</subscriptionId>
          <resourceGroup>jakartaee-app-on-jboss-1623043825268-rg</resourceGroup>
          <appName>jakartaee-app-on-jboss-1623043825268</appName>
          <pricingTier>P3v3</pricingTier>
          <region>westeurope</region>
          <runtime>
            <os>Linux</os>
            <javaVersion>Java 8</javaVersion>
            <webContainer>Jbosseap 7.2</webContainer>
          </runtime>
          <deployment>
            <resources>
              <resource>
                <directory>${project.basedir}/target</directory>
                <includes>
                  <include>*.war</include>
                </includes>
              </resource>
              <resource>
                <type>startup</type>
                <directory>${project.basedir}/src/main/webapp/WEB-INF/</directory>
                <includes>
                  <include>createMySQLDataSource.sh</include>
                </includes>
              </resource>
            </resources>
          </deployment>
        </configuration>
      </plugin>
    </plugins> 
  </build> 
</project>
```

> [!IMPORTANT]
> Check the `<region>` element. If it's not the same installation location as MySQL, change it to the same location.

Now, check the values for the resource group name and application name from the above XML file. Note these names or better assign them to environment variables.

```xml
<resourceGroup>jakartaee-app-on-jboss-1623043825268-rg</resourceGroup>
<appName>jakartaee-app-on-jboss-1623043825268</appName>
```

If you are using the bash, configure the environment variables with the following command.

```bash
export WEBAPP_NAME=jakartaee-app-on-jboss-1606464084546
export RESOURCEGROUP_NAME=jakartaee-app-on-jboss-1606464084546-rg
```

## Compile and build the Java EE app

After you configured the Azure App Service deployment settings, compile and package the source code.

```bash
./mvnw clean package
```

The following output appears in the terminal:

```text
[INFO] Packaging webapp
[INFO] Assembling webapp [jakartaee-app-on-jboss] in [/private/tmp/mslearn-jakarta-ee-azure/target/ROOT]
[INFO] Processing war project
[INFO] Copying webapp resources [/private/tmp/mslearn-jakarta-ee-azure/src/main/webapp]
[INFO] Webapp assembled in [360 msecs]
[INFO] Building war: /private/tmp/mslearn-jakarta-ee-azure/target/ROOT.war
[INFO] WEB-INF/web.xml already added, skipping
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  5.315 s
[INFO] Finished at: 2021-06-07T14:52:45+09:00
[INFO] ------------------------------------------------------------------------
```

## Deploy the Java EE app to JBoss EAP on Azure App Service

After you compile and package the code, deploy the application:

```bash
./mvnw azure-webapp:deploy
```

The following message appears in the terminal:

```text
Auth type: AZURE_CLI
Default subscription: Microsoft Azure Internal Billing-CDA(********-****-****-****-************)
Username: YOUR_EMAIL_ADDRESS@************.com
[INFO] Subscription: Microsoft Azure Internal Billing-CDA(********-****-****-****-************)
[INFO] Creating resource group jakartaee-app-on-jboss-1623043825268-rg in region westeurope...
[INFO] Successfully created resource group jakartaee-app-on-jboss-1623043825268-rg.
[INFO] Creating app service plan...
[INFO] Successfully created app service plan asp-jakartaee-app-on-jboss-1623043825268.
[INFO] Creating web app jakartaee-app-on-jboss-1623043825268...
[INFO] Successfully created Web App jakartaee-app-on-jboss-1623043825268.
[INFO] Trying to deploy artifact to jakartaee-app-on-jboss-1623043825268...
[INFO] Deploying (/private/tmp/mslearn-jakarta-ee-azure/target/ROOT.war)[war]  ...
[INFO] Deploying (/private/tmp/mslearn-jakarta-ee-azure/src/main/webapp/WEB-INF/createMySQLDataSource.sh)[startup]  ...
[INFO] Successfully deployed the artifact to https://jakartaee-app-on-jboss-1623043825268.azurewebsites.net
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  02:20 min
[INFO] Finished at: 2021-06-07T14:55:16+09:00
[INFO] ------------------------------------------------------------------------
```

Note down the URL of the deployed application, particularly the following line in the Maven output:

```text
[INFO] Successfully deployed the artifact to  
https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net
```

## Configure a database connection

The sample application will connect to your MySQL Database and display data.

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
ROOT.war_com.mysql.cj.jdbc.Driver_8_0
```

## Create the MySQL DataSource object in JBoss EAP

To access Azure Database for MySQL, you need to configure the `DataSource` object in JBoss EAP and specify the JNDI name in your source code.

To create a MySQL `DataSource` object in JBoss EAP, we created the following startup shell script. The script file is `createMySQLDataSource.sh` under the `/WEB-INF` directory.

> [!NOTE]
> In the script, we bind the MySQL DataSource by using a JBoss CLI command. The connection string, username, and password use the environment variables `MYSQL_CONNECTION_URL`, `MYSQL_USER`, and `MYSQL_PASSWORD`.

```shell
#!/usr/bin/bash

# In order to use the variables in JBoss CLI scripts
# https://access.redhat.com/solutions/321513
#
sed -i -e "s|.*<resolve-parameter-values.*|<resolve-parameter-values>true</resolve-parameter-values>|g" /opt/eap/bin/jboss-cli.xml

/opt/eap/bin/jboss-cli.sh --connect <<EOF
data-source add --name=JPAWorldDataSourceDS \
--jndi-name=java:jboss/datasources/JPAWorldDataSource \
--connection-url=${MYSQL_CONNECTION_URL} \
--driver-name=ROOT.war_com.mysql.cj.jdbc.Driver_8_0 \
--user-name=${MYSQL_USER} \
--password=${MYSQL_PASSWORD} \
--min-pool-size=5 \
--max-pool-size=20 \
--blocking-timeout-wait-millis=5000 \
--enabled=true \
--driver-class=com.mysql.cj.jdbc.Driver \
--jta=true \
--use-java-context=true \
--valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.mysql.MySQLValidConnectionChecker \
--exception-sorter-class-name=com.mysql.cj.jdbc.integration.jboss.ExtendedMysqlExceptionSorter
reload --use-current-server-config=true
exit
EOF
```

Now configure your App Service instance to invoke the startup script:

# [Linux/Mac OS X](#tab/linux)

```azurecli
az webapp config set --startup-file '/home/site/scripts/startup.sh' \
-n ${WEBAPP_NAME} \
-g ${RESOURCEGROUP_NAME}
```

# [Git BASH for Windows](#tab/windows)

```azurecli
export MSYS_NO_PATHCONV=1
az webapp config set --startup-file '/home/site/scripts/startup.sh' \
-n ${WEBAPP_NAME} \
-g ${RESOURCEGROUP_NAME}
```
---

After the script runs, it will be invoked every time the application server is restarted.

> [!NOTE]
> If your deployment artifact isn't `ROOT.war`, you need to change the `--driver-name=YOUR_ARTIFACT.war_com.mysql.cj.jdbc.Driver_8_0` value too.

## Configure the environment variables for connecting to MySQL

After you configure the startup script, configure App Service to use certain environment variables:

```azurecli
az webapp config appsettings set \
  --resource-group ${RESOURCEGROUP_NAME} --name ${WEBAPP_NAME} \
  --settings \
  MYSQL_CONNECTION_URL='jdbc:mysql://mysqlserver-**********.mysql.database.azure.com:3306/world?useSSL=true&requireSSL=false' \
  MYSQL_PASSWORD='************' \
  MYSQL_USER=azureuser
```

> [!TIP]
> The values of `MYSQL_CONNECTION_URL`, `MYSQL_USER` and `MYSQL_PASSWORD` were set from the previous unit.

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

Check if the `DataSource` name matches the name used in the configuration.
In an earlier step, you created the JNDI name as `java:jboss/datasources/JPAWorldDataSource`. So, add a `DataSource` reference as `java:jboss/datasources/JPAWorldDataSource` in the `<jta-data-source>` XML element as follows:

```xml
  <persistence-unit name="JPAWorldDatasourcePU" transaction-type="JTA">
    <jta-data-source>java:jboss/datasources/JPAWorldDataSource</jta-data-source>
    <exclude-unlisted-classes>false</exclude-unlisted-classes>
    <properties>
      <property name="hibernate.generate_statistics" value="true" />
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

In the sample application, we implemented three REST endpoints.
You can access the application and validate these endpoints by using a web browser or a `curl` command.

To access the application, you need to reference the application URL, which you got from an earlier section:

```text
[INFO] Successfully deployed the artifact to  
https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net
```

Run the following command to get all the continent information in JSON format.

:::image type="content" source="../media/rest-endpoint-area.png" alt-text="Screenshot that shows area as the REST endpoint.":::

```bash
$ curl https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net/area
["North America","Asia","Africa","Europe","South America","Oceania","Antarctica"]$ 
```

And if you specify the continent in the URL, you can get all the countries in the specified continent.

:::image type="content" source="../media/rest-endpoint-continent.png" alt-text="Screenshot that shows continent as the REST endpoint.":::

```bash
$ curl https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net/area/Asia | jq '.[] | { name: .name, code: .code }'
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

Finally, if you specify a country code after `/countries`, you can get all the cities that have population greater than 1 million within the country.

:::image type="content" source="../media/rest-endpoint-cities.png" alt-text="Screenshot that shows cities as the REST endpoint.":::

```bash
$ curl https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net/countries/JPN | jq '.[].name'
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
