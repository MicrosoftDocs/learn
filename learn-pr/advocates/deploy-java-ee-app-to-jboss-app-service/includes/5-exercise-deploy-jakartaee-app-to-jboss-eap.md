In this exercise, you'll deploy a Java EE (Jakarta EE) Application to JBoss EAP on Azure App Service.

We'll need to follow the following steps:

1. Configure the project to prepare the deployment by using `Maven Plugin for Azure App Service`.
1. Compile the application and create a WAR package.
1. Deploy the WAR package to JBoss EAP on Azure App Service.

### Configure the App with Maven Plugin for Azure App Service

Let's configure our application by executing the config goal in the Maven plugin for Azure App Service:

```bash
./mvnw com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
```

> [!IMPORTANT]
> If you changed the region of your MySQL server, it's advisable to also change to the same region for your Java EE application to minimize latency delays.

In the command, select `Java 8` for `javaVersion` and `Jbosseap 7.2` for `runtimeStack`:

|  Input Element  |  Value  |
| ---- | ---- |
|  Choose a Web Container Web App [<create>]: |  `1: <create>`  |
|  Define value for OS [Linux]:  |  `Linux`  |
|  Define value for pricingTier [P1v2]:  |  `P1v2`  |
|  Define value for javaVersion [Java 8]:  |  `1: Java 8`  |
|  Define value for runtimeStack:  |  `1: Jbosseap 7.2`  |
|  Confirm (Y/N) [Y]: | `y` |

After executing the command, you'll see the following messages in the terminal:

```bash
[INFO] Scanning for projects...
[INFO] 
[INFO] ---------< com.microsoft.azure.samples:jakartaee-app-on-jboss >---------
[INFO] Building jakartaee-app-on-jboss 1.0-SNAPSHOT
[INFO] --------------------------------[ war ]---------------------------------
[INFO] 
[INFO] Auth Type : AZURE_CLI, Auth Files : [/Users/yoterada/.azure/azureProfile.json, /Users/yoterada/.azure/accessTokens.json]
Available subscriptions:
   1: My Subscription(********-****-****-****-************)
Please choose a subscription [My Subscription]: 1
[INFO] It may take a few minutes to load all Java Web Apps, please be patient.
Web Container Web Apps in subscription My Subscription:
* 1: <create>
Please choose a Web Container Web App [<create>]: 
Define value for OS [Linux]:
* 1: Linux
  2: Docker
  3: Windows
Enter your choice: 
Define value for pricingTier [P1v2]:
   1: B1
   2: B2
   3: B3
   4: D1
   5: F1
*  6: P1v2
   7: P2v2
   8: P3v2
   9: S1
  10: S2
  11: S3
Enter your choice: 
Define value for javaVersion [Java 8]:
* 1: Java 8
  2: Java 11
Enter your choice: 
Define value for runtimeStack:
  1: Jbosseap 7.2
* 2: Tomcat 8.5
  3: Tomcat 9.0
Enter your choice: 1
Please confirm webapp properties
Subscription Id : ********-****-****-****-************
AppName : jakartaee-app-on-jboss-1606464084546
ResourceGroup : jakartaee-app-on-jboss-1606464084546-rg
Region : westeurope
PricingTier : PremiumV2_P1v2
OS : Linux
Java : Java 8
Web server stack: Jbosseap 7.2
Deploy to slot : false
Confirm (Y/N) [Y]: y
[INFO] Saving configuration to pom.
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  55.093 s
[INFO] Finished at: 2020-11-27T17:01:43+09:00
[INFO] ------------------------------------------------------------------------
```

After the command is completed, you can see following entry is added in your Maven `pom.xml`:

```xml
    <plugins>
      <plugin>
        <groupId>com.microsoft.azure</groupId>
        <artifactId>azure-webapp-maven-plugin</artifactId>
        <version>1.12.0</version>
        <configuration>
          <schemaVersion>v2</schemaVersion>
          <subscriptionId>********-****-****-****-************</subscriptionId>
          <resourceGroup>jakartaee-app-on-jboss-1606464084546-rg</resourceGroup>
          <appName>jakartaee-app-on-jboss-1606464084546</appName>
          <pricingTier>P1v2</pricingTier>
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
            </resources>
          </deployment>
        </configuration>
      </plugin>
    </plugins>
```

> [!IMPORTANT]
> Check the `<region>` element, if it is not the same install location as MySQL, please modify to the same location.

### Compile and build the Java EE App

After configuring the Azure App Service Deployment settings, compile and package the source code:

```bash
./mvnw clean package
```

Then you can see following output in the terminal:

```text
[INFO] Packaging webapp
[INFO] Assembling webapp [jakartaee-app-on-jboss] in [/Users/********/Desktop/MySQL/jakartaee-app-on-jboss/target/ROOT]
[INFO] Processing war project
[INFO] Copying webapp resources [/Users/********/Desktop/MySQL/jakartaee-app-on-jboss/src/main/webapp]
[INFO] Webapp assembled in [276 msecs]
[INFO] Building war: /Users/********/Desktop/MySQL/jakartaee-app-on-jboss/target/ROOT.war
[INFO] WEB-INF/web.xml already added, skipping
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  6.631 s
[INFO] Finished at: 2020-11-27T17:07:21+09:00
[INFO] ------------------------------------------------------------------------
```

### Deploy Java EE application to JBoss EAP on Azure App Service

After compiling and packaging the code, deploy the application by executing the following command:

```bash
./mvnw azure-webapp:deploy
```

Then you'll see the following message in the terminal:

```text
[INFO] Auth Type : AZURE_CLI, Auth Files : [/Users/********/.azure/azureProfile.json, /Users/********/.azure/accessTokens.json]
[INFO] Subscription : My Subscription(********-****-****-****-************)
[INFO] Target Web App doesn't exist. Creating a new one...
[INFO] Creating App Service Plan 'ServicePlancd5a2677-324c-47d7'...
[INFO] Successfully created App Service Plan.
[INFO] Successfully created Web App.
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 1 resource to /Users/********/Desktop/MySQL/jakartaee-app-on-jboss/target/azure-webapp/jakartaee-app-on-jboss-1606464084546-c16ffb02-b9f4-4673-907a-7719393772cd
[INFO] Trying to deploy artifact to jakartaee-app-on-jboss-1606464084546...
[INFO] Deploying the war file ROOT.war...
[INFO] Successfully deployed the artifact to https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  01:43 min
[INFO] Finished at: 2020-11-27T17:09:08+09:00
[INFO] ------------------------------------------------------------------------
```

Note down the URL of the deployed application, particularly the following line in the Maven output:

```text
[INFO] Successfully deployed the artifact to  
https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net
```

## Configure a Database Connection

In our sample application, it will connect to your MySQL Database and display data.
In the Maven project configuration in `pom.xml`, we specified the MySQL JDBC Driver as follows:

```xml
    <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>${mysql-jdbc-driver}</version>
    </dependency>
```

As a result, JBoss EAP automatically installs the JDBC Driver to your deployment package `(ROOT.war)`.
You can refer the name of MySQL JDBC Driver as follows:

```text
ROOT.war_com.mysql.cj.jdbc.Driver_8_0
```

### Create the MySQL DataSource in JBoss EAP

To access to the `Azure Database for MySQL`, you need to configure the `DataSource` in JBoss EAP, and specify the JNDI name in your source code.
To create a MySQL `DataSource` in JBoss EAP, we created a startup shell script file `createMySQLDataSource.sh` under the `/WEB-INF` directory.

> [!NOTE]
> In the script, we'll bind our MySQL DataSource using a JBoss CLI command. Our connection string, user name, and password will use the environment variables `MYSQL_CONNECTION_URL`, `MYSQL_USER`, and `MYSQL_PASSWORD`.

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

Let's configure your App Service instance to invoke the startup script:

```azurecli
az webapp config set --startup-file=/home/site/wwwroot/webapps/ROOT/WEB-INF/createMySQLDataSource.sh \
-n ${WEBAPP_NAME} \
-g ${RESOURCEGROUP_NAME}
```

After execution, the script will be invoked every time when the application server is restarted.
If your deployment artifact isn't "ROOT.war", you need to change the "--driver-name=YOUR_ARTIFACT.war_com.mysql.cj.jdbc.Driver_8_0" value too.

### Configure the Environment Variables for Connecting to MySQL

After you configured your startup script, configure your App service to use certain environment variables:

```azurecli
az webapp config appsettings set \
  --resource-group ${RESOURCEGROUP_NAME} --name ${WEBAPP_NAME} \
  --settings \
  MYSQL_CONNECTION_URL='jdbc:mysql://mysqlserver-**********.mysql.database.azure.com:3306/world?useSSL=true&amp;requireSSL=false&amp;serverTimezone=JST' \
  MYSQL_PASSWORD=************ \
  MYSQL_USER=azureuser
```

> [!TIP]
> The values of `MYSQL_CONNECTION_URL`, `MYSQL_USER` and `MYSQL_PASSWORD` were set from the previous unit.

### Confirm the DataSource Reference in the Code

To access the MySQL database from your application, you need to configure the data source reference in your application project. We implemented the DB access code by using `Java Persistence API (JPA)`.
The configuration for the `DataSource` reference has been added in the `persistence.xml`, which is the configuration file of the JPA.

Access the following file:

```text
├── src
│   ├── main
│   │   ├── resources
│   │   │   └── META-INF
│   │   │       └── persistence.xml
```

Check if the name of our `DataSource` matches the name used in the configuration.
In the above step, we created the JNDI name as `java:jboss/datasources/JPAWorldDataSource`.
So we added a DataSource reference as `java:jboss/datasources/JPAWorldDataSource` in `<jta-data-source>` XML element as follows:

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
We can access the application and validate these endpoints using a Web browser or `curl` command.

To access the application, you need to reference the application URL, which you got from the previous section:

```text
[INFO] Successfully deployed the artifact to  
https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net
```

Execute following command to get all of the continent information in JSON format.

:::image type="content" source="../media/rest-endpoint-area.png" alt-text="REST Endpoint Area":::

```bash
$ curl https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net/area
["North America","Asia","Africa","Europe","South America","Oceania","Antarctica"]$ 
```

And if you specify the continent in the URL, you can get all of the countries in the specified continent:

:::image type="content" source="../media/rest-endpoint-continent.png" alt-text="REST Endpoint Continent":::

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

Finally, if you specify a country code after the `/countries`, you can get all the cities, which have population greater than a million within the county:

:::image type="content" source="../media/rest-endpoint-cities.png" alt-text="REST Endpoint Cities":::

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

## Exercise Summary

You've now validated the application REST endpoints and tested that your application can get data from your MySQL database.
