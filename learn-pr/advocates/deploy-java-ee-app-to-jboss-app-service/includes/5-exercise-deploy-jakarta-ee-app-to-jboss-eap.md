In this exercise, you'll deploy a Java EE (Jakarta EE) application to JBoss EAP on Azure App Service. You use the Maven plug-in to configure the project, compile and deploy the application, and configure a data source.

## Configure the app with the Maven Plugin for Azure App Service

Let's configure the application by executing the configuration goal in the Maven Plugin for Azure App Service.

```bash
./mvnw com.microsoft.azure:azure-webapp-maven-plugin:2.9.0:config
```

> [!IMPORTANT]  
> If you change the region of your MySQL server, you should also change to the same region for your Java EE application server to minimize latency delays.  
> In the command, select Java 11 for Java version and JBoss EAP 7 for runtime stack.

|  Input element  |  Value  |
| ---- | ---- |
|  `Available subscriptions:` | `Your appropriate subsctioption` |
|  `Choose a Web Container Web App [\<create\>]:` |  `1: <create>`  |
|  `Define value for OS [Linux]:`  |  `Linux`  |
|  `Define value for javaVersion [Java 17]:`  |  `2: Java 11`  |
|  `Define value for runtimeStack:`  |  `1: Jbosseap 7`  |
|  `Define value for pricingTier [P1v3]:`  |  `P1v3`  |
|  `Confirm (Y/N) [Y]:` | `Y` |

After you run the command, you'll get messages like the following in the terminal:

```output
$ ./mvnw com.microsoft.azure:azure-webapp-maven-plugin:2.9.0:config
[INFO] Scanning for projects...
[INFO] 
[INFO] ---------< com.microsoft.azure.samples:jakartaee-app-on-jboss >---------
[INFO] Building jakartaee-app-on-jboss 1.0-SNAPSHOT
[INFO] --------------------------------[ war ]---------------------------------
[INFO] 
[INFO] --- azure-webapp-maven-plugin:2.5.0:config (default-cli) @ jakartaee-app-on-jboss ---
[WARNING] The POM for com.microsoft.azure.applicationinsights.v2015_05_01:azure-mgmt-insights:jar:1.0.0-beta is invalid, transitive dependencies (if any) will not be available, enable debug logging for more details
[INFO] Auth type: OAUTH2
Username: YOUR_EMAIL_ADDRESS@microsoft.com
Available subscriptions:
[INFO] Subscription: YOUR_SUBSCRIPTION(********-****-****-****-************)
[INFO] It may take a few minutes to load all Java Web Apps, please be patient.
Web Container Web Apps in subscription Microsoft Azure Internal Billing-CDA:
* 1: <create>
  2: jakartaee-app-on-jboss-yoshio (linux, jbosseap 7.2-java8)
Please choose a Web Container Web App [<create>]: 
Define value for OS [Linux]:
* 1: Linux
  2: Windows
  3: Docker
Enter your choice: 
Define value for javaVersion [Java 8]:
* 1: Java 8
  2: Java 11
Enter your choice: 
Define value for runtimeStack:
  1: Jbosseap 7.2
  2: Jbosseap 7
* 3: Tomcat 8.5
  4: Tomcat 9.0
Enter your choice: 1
Define value for pricingTier [P1v3]:
  1: P3v3
  2: P2v3
* 3: P1v3
Enter your choice: 
Please confirm webapp properties
Subscription Id : ********-****-****-****-************
AppName : jakartaee-app-on-jboss-1625038814881
ResourceGroup : jakartaee-app-on-jboss-1625038814881-rg
Region : westeurope
PricingTier : P1v3
OS : Linux
Java : Java 8
Web server stack: Jbosseap 7.2
Deploy to slot : false
Confirm (Y/N) [Y]: 
[INFO] Saving configuration to pom.
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  01:43 min
[INFO] Finished at: 2021-06-30T16:40:47+09:00
[INFO] ------------------------------------------------------------------------
$ 
```

After the command finishes, you can see that following entry is added in your Maven `pom.xml` file.

```xml
  <build>
    <finalName>ROOT</finalName>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-war-plugin</artifactId>
        <version>3.3.2</version>
      </plugin>
        <plugin>
            <groupId>com.microsoft.azure</groupId>
            <artifactId>azure-webapp-maven-plugin</artifactId>
            <version>2.9.0</version>
            <configuration>
                <schemaVersion>v2</schemaVersion>
                <resourceGroup>jakartaee-app-on-jboss-1625038814881-rg</resourceGroup>
                <appName>jakartaee-app-on-jboss-1625038814881</appName>
                <pricingTier>P1v3</pricingTier>
                <region>centralus</region>
                <runtime>
                    <os>Linux</os>
                    <javaVersion>Java 11</javaVersion>
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

After adding the above configuration for deploying to the Azure, add the following XML entries to deploy the startup file. The resource `<type>startup</type>` deploys the specified script as `startup.sh` (Linux) or `startup.cmd` (Windows) to `/home/site/scripts/`. We configure the startup script in the following step.

```xml
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

## Compile and build the Java EE app

After you configure the Azure App Service deployment settings, compile and package the source code.

```bash
./mvnw clean package
```

The following output appears in the terminal:

```output
[INFO] Packaging webapp
[INFO] Assembling webapp [jakartaee-app-on-jboss] in [/private/tmp/mslearn-jakarta-ee-azure/target/ROOT]
[INFO] Processing war project
[INFO] Copying webapp resources [/private/tmp/mslearn-jakarta-ee-azure/src/main/webapp]
[INFO] Webapp assembled in [369 msecs]
[INFO] Building war: /private/tmp/mslearn-jakarta-ee-azure/target/ROOT.war
[INFO] WEB-INF/web.xml already added, skipping
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  7.656 s
[INFO] Finished at: 2023-03-04T12:35:43-05:00
[INFO] ------------------------------------------------------------------------
```

## Deploy the Java EE app to JBoss EAP on Azure App Service

After you compile and package the code, deploy the application:

```bash
./mvnw azure-webapp:deploy
```

The following message appears in the terminal:

```output
[INFO] Creating resource group jakartaee-app-on-jboss-1625038814881-rg in region westeurope...
[INFO] Successfully created resource group jakartaee-app-on-jboss-1625038814881-rg.
[INFO] Creating app service plan...
[INFO] Successfully created app service plan asp-jakartaee-app-on-jboss-1625038814881.
[INFO] Creating web app jakartaee-app-on-jboss-1625038814881...
[INFO] Successfully created Web App jakartaee-app-on-jboss-1625038814881.
[INFO] Trying to deploy artifact to jakartaee-app-on-jboss-1625038814881...
[INFO] Deploying (/private/tmp/mslearn-jakarta-ee-azure/target/ROOT.war)[war]  ...
[INFO] Successfully deployed the artifact to https://jakartaee-app-on-jboss-1625038814881.azurewebsites.net
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  02:11 min
[INFO] Finished at: 2023-03-04T12:38:39-05:00
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
ROOT.war_com.mysql.cj.jdbc.Driver_8_0
```

## Create the MySQL DataSource object in JBoss EAP

To access Azure Database for MySQL, you need to configure the `DataSource` object in JBoss EAP and specify the JNDI name in your source code.

To create a MySQL `DataSource` object in JBoss EAP, we created the following startup shell script. The script file is `createMySQLDataSource.sh` under the `/WEB-INF` directory.

> [!NOTE]
> In the script, we bind the MySQL DataSource by using a JBoss CLI command. The connection string, username, and password use the environment variables `MYSQL_CONNECTION_URL`, `MYSQL_USER`, and `MYSQL_PASSWORD`.

The source of the script file is shown next. This script file has already been uploaded to App Service, but it hasn't yet been configured to be invoked.

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
exit
EOF
```

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
