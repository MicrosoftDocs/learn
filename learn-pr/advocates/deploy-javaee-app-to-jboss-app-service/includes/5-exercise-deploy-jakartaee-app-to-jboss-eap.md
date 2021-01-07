In this page, You will learn how to deploy  a Java EE (Jakarta EE) Application to JBoss EAP on Azure App Service.  


## Configure App and Deploy to JBoss EAP on Azure App Service

You already clone the GitHub repository in the previous section, so you already have source code of Sample Application. 

In this section, at first we will configure the project to prepare the deployment by using `Azure App Service Maven Plugin`. After that we will compile the source code and create an artifact as WAR file. Finally we will deploy the artifact to JBoss EAP on Azure App Service.

### Configure the App with Azure App Service Maven Plugin

In order to configure the Application to deploy to JBoss EAP on Azure App Service, please execute the following command.

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
```

Then you can see following messages in the terminal.

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

In the command messages, you need input the following value.   
Especially in this time, we will deploy the application to JBoss EAP, so please select `Java 8` for `javaVersion` and `Jbosseap 7.2` for `runtimeStack`.

|  Input Element  |  Value  |
| ---- | ---- |
|  Please choose a Web Container Web App [<create>]: |  `1: <create>`  |
|  Define value for OS [Linux]:  |  `Linux`  |
|  Define value for pricingTier [P1v2]:  |  `P1v2`  |
|  Define value for javaVersion [Java 8]:  |  `1: Java 8`  |
|  Define value for runtimeStack:  |  `1: Jbosseap 7.2`  |
|  Confirm (Y/N) [Y]: | `y` |


After finshed the command, You can see following entry is added in `pom.xml`.

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

### Compile & Create Java Package for Deploy

After configure the Azure App Service Deployment settings, you need to compile and package the source code. In order to compile and package the code, please execute the following command?

```bash
mvn clean package
```

Then you can see following in the terminal.

```text
[INFO] Packaging webapp
[INFO] Assembling webapp [jakartaee-app-on-jboss] in [/Users/********/Desktop/microprofile-samples/MySQL/jakartaee-app-on-jboss/target/ROOT]
[INFO] Processing war project
[INFO] Copying webapp resources [/Users/********/Desktop/microprofile-samples/MySQL/jakartaee-app-on-jboss/src/main/webapp]
[INFO] Webapp assembled in [276 msecs]
[INFO] Building war: /Users/********/Desktop/microprofile-samples/MySQL/jakartaee-app-on-jboss/target/ROOT.war
[INFO] WEB-INF/web.xml already added, skipping
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  6.631 s
[INFO] Finished at: 2020-11-27T17:07:21+09:00
[INFO] ------------------------------------------------------------------------
```


### Deploy Java EE App to JBoss EAP on Azure App Service

After compile and package the code, you can deploy it to the JBoss EAP on Azure App Service. In order to deploy the application, please execute the following command.

```bash
mvn azure-webapp:deploy
```

Then you can see following message in the terminal.

```text
[INFO] Auth Type : AZURE_CLI, Auth Files : [/Users/********/.azure/azureProfile.json, /Users/********/.azure/accessTokens.json]
[INFO] Subscription : My Subscription(********-****-****-****-************)
[INFO] Target Web App doesn't exist. Creating a new one...
[INFO] Creating App Service Plan 'ServicePlancd5a2677-324c-47d7'...
[INFO] Successfully created App Service Plan.
[INFO] Successfully created Web App.
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 1 resource to /Users/********/Desktop/microprofile-samples/MySQL/jakartaee-app-on-jboss/target/azure-webapp/jakartaee-app-on-jboss-1606464084546-c16ffb02-b9f4-4673-907a-7719393772cd
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

Especially following line is very important. It showes the URL of the EndPoint for your service. So in order to access to your service in following step, please remember it.

```text
[INFO] Successfully deployed the artifact to  
https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net
```


## Configure DB Connection from JBoss EAP

In our Sample Application, it will communicate with MySQL DB to show the data. In order to access to the `Azure Database for MySQL`, you need configure the `DataSource` in JBoss EAP, and you need specify the JNDI name into your source code.

In this module, we will connect to MySQL Database. If you deploy the Sample Application, you already include a MySQL JDBC Driver in your deployment package `(ROOT.war)`. Bacause in the Maven Project Configuration in `pom.xml`, we specify the MySQL JDBC Driver as follows.

```xml
    <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>${mysql-jdbc-driver}</version>
    </dependency>
```

As a result, JBoss EAP automatically install the JDBC Driver during the Deployment. And you can refer the name of MySQL JDBC Driver as follows.

```text
ROOT.war_com.mysql.cj.jdbc.Driver_8_0
```

### Create the MySQL DataSource in JBoss EAP

In order to create a MySQL `DataSource` in JBoss EAP, we created a startup shell script file as `createMySQLDataSource.sh` under the `/WEB-INF` directory. 

In the code, we created a MySQL DataSource using JBoss CLI command. And the variable in the script like connection string, user name and password will get from the Environment Variables as `MYSQL_CONNECTION_URL`, `MYSQL_USER` and `MYSQL_PASSWORD`.

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

In order to invoke the script during the start up of JBoss EAP, please execute the following command.  
After executed it, the script will be invoke every times when the Application Server restarted.

```azurecli
az webapp config set --startup-file=/home/site/wwwroot/webapps/ROOT/WEB-INF/createMySQLDataSource.sh \
-n ${WEBAPP_NAME} \
-g ${RESOURCEGROUP_NAME}
```

> [!WARNING]
> If your deployment artifact is not "ROOT.war", you need change the "--driver-name=YOUR_ARTIFACT.war_com.mysql.cj.jdbc.Driver_8_0" value too.

### Configure the Environment Variables for Connecting to MySQL

After specify the script file, you need to configure the Environment Variables in the Azure App Service. In order to configure the Environment Variables, please execute the following command.

```azurecli
az webapp config appsettings set \
  --resource-group ${RESOURCEGROUP_NAME} --name ${WEBAPP_NAME} \
  --settings \
  MYSQL_CONNECTION_URL='jdbc:mysql://mysqlserver-**********.mysql.database.azure.com:3306/world?useSSL=true&amp;requireSSL=false&amp;serverTimezone=JST' \
  MYSQL_PASSWORD=************ \
  MYSQL_USER=azureuser
```

> [!TIP]
> The value of "MYSQL_CONNECTION_URL", "MYSQL_USER" and "MYSQL_PASSWORD" was already got in the previous section.

### Confirm the DataSource Reference in the Code

Finally, in order to access to the MySQL from Your Application Code, You need configure the `DataSource` reference in Your Project. In this time, we implemented the DB access code by using `Java Persistence API (JPA)`. So we added the configuration for the `DataSource` reference in the `persistence.xml` which is the configuration file of the JPA.

Please confirm the following file.

```text
├── src
│   ├── main
│   │   ├── resources
│   │   │   └── META-INF
│   │   │       └── persistence.xml
```

And You need check whether the name of the `DataSource` equal to the previous configuration or not. In the above step, we created the JNDI name as `java:jboss/datasources/JPAWorldDataSource`. So we added a DataSource reference as `java:jboss/datasources/JPAWorldDataSource` in `<jta-data-source>` XML element as follows.

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

Then you can access to the MySQL DB referenced by the `Persisntence Unit` name in your  JPA code like follows.

```java
@Transactional(REQUIRED)
@RequestScoped
public class CityService {

    @PersistenceContext(unitName = "JPAWorldDatasourcePU")
    EntityManager em;
```

## Access to the Application

In this Sample Application, we implemented three RESTful endpoints. So we will confirm whether the three endpoint is available or not by using `curl` command or Web browser.

In order to access to the  Application, you need specify the Web Server name in the URL. For the URL, You already got in the previous section like follows. So please specify it. 

```text
[INFO] Successfully deployed the artifact to  
https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net
```

If you have the curl command, please execute following command. Then you can get all of the Continent Area infomation as JSON format.

![REST Endpoint Area](../media/rest-endpoint-area.png)

```bash
$ curl https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net/area
["North America","Asia","Africa","Europe","South America","Oceania","Antarctica"]$ 
```

And if you specify the Cotinent in the URL, you can get all of the countries in the specified continent like follows.

![REST Endpoint Continent](../media/rest-endpoint-continent.png)

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
{
  "name": "Bahrain",
  "code": "BHR"
}
{
  "name": "Brunei",
  "code": "BRN"
}
{
  "name": "Bhutan",
  "code": "BTN"
}
{
  "name": "China",
  "code": "CHN"
}
{
  "name": "Cyprus",
  "code": "CYP"
}
{
  "name": "Georgia",
  "code": "GEO"
}
{
  "name": "Hong Kong",
  "code": "HKG"
}
{
  "name": "Indonesia",
  "code": "IDN"
}
{
  "name": "India",
  "code": "IND"
}
{
  "name": "Iran",
  "code": "IRN"
}
{
  "name": "Iraq",
  "code": "IRQ"
}
{
  "name": "Israel",
  "code": "ISR"
}
{
  "name": "Jordan",
  "code": "JOR"
}
{
  "name": "Japan",
  "code": "JPN"
}
....
```

Finally, if you specify the Country Code after the `/countries`, you will be able to get all of the cities which has the population over 1 million persons in the Country.

![REST Endpoint Cities](../media/rest-endpoint-cities.png)

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

Then you could finish the confirmation of the Application. Exactlly you get the data from `Azure Database for MySQL`.
