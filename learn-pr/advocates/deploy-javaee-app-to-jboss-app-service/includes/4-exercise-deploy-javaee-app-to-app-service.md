# Build and Deploy Java EE (Jakarta EE) Application to JBoss EAP on Azure  App Service

In this page, You will learn how to deploy  a Java EE (Jakarta EE) Application to JBoss EAP on Azure App Service.  
This is a general Java EE (Jakarta EE) application. In the project, we used following technologies.

- Java EE 8 (Jakarta EE 8)
	- [JPA 2.2](https://jakarta.ee/specifications/persistence/2.2/)
	- [CDI 2.0](https://jakarta.ee/specifications/cdi/2.0/)
	- [JSON-B 1.0](https://jakarta.ee/specifications/jsonb/1.0/)
	- [JAX-RS 2.1](https://jakarta.ee/specifications/restful-ws/2.1/)

## Execute Azure App Service Maven Plugin


```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
```

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

You can see following entry is added in `pom.xml`.

```
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

## Create Package for Deploy

```bash
mvn clean package
```

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


## Deploy Java EE App to JBoss EAP on Azure App Service

```bash
mvn azure-webapp:deploy
```

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


## Configure the MySQL Connection String to App Service

In order to configure the connection information for MySQL, please execute the following command.

```azurecli
az webapp config appsettings set \
  --resource-group ${RESOURCEGROUP_NAME} --name ${WEBAPP_NAME} \
  --settings \
  MYSQL_CONNECTION_URL='jdbc:mysql://mysqlserver-**********.mysql.database.azure.com:3306/world?useSSL=true&amp;requireSSL=false&amp;serverTimezone=JST' \
  MYSQL_PASSWORD=************ \
  MYSQL_USER=azureuser
```

## Create the MySQL DataSource in JBoss EAP

In order to create MySQL DataSource Resouce during the startup of JBoss EAP, please execute the following command? After executed it, the script will be invoke every times when the Application Server restarted.

```azurecli
az webapp config set --startup-file=/home/site/wwwroot/webapps/ROOT/WEB-INF/createMySQLDataSource.sh \
-n ${WEBAPP_NAME} \
-g ${RESOURCEGROUP_NAME}
```

Following code is wrote on the script file. We created a MySQL DataSource by JBoss CLI command. And the connection string,user name and password can get from the Environment Variables.

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
--max-pool-size=5 \
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


## Access to the Application

```bash
$ curl https://jakartaee-app-on-jboss-1606464084546.azurewebsites.net/area
["North America","Asia","Africa","Europe","South America","Oceania","Antarctica"]$ 
```

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
{
  "name": "Kazakstan",
  "code": "KAZ"
}
{
  "name": "Kyrgyzstan",
  "code": "KGZ"
}
{
  "name": "Cambodia",
  "code": "KHM"
}
{
  "name": "South Korea",
  "code": "KOR"
}
{
  "name": "Kuwait",
  "code": "KWT"
}
{
  "name": "Laos",
  "code": "LAO"
}
{
  "name": "Lebanon",
  "code": "LBN"
}
{
  "name": "Sri Lanka",
  "code": "LKA"
}
{
  "name": "Macao",
  "code": "MAC"
}
{
  "name": "Maldives",
  "code": "MDV"
}
{
  "name": "Myanmar",
  "code": "MMR"
}
{
  "name": "Mongolia",
  "code": "MNG"
}
{
  "name": "Malaysia",
  "code": "MYS"
}
{
  "name": "Nepal",
  "code": "NPL"
}
{
  "name": "Oman",
  "code": "OMN"
}
{
  "name": "Pakistan",
  "code": "PAK"
}
{
  "name": "Philippines",
  "code": "PHL"
}
{
  "name": "North Korea",
  "code": "PRK"
}
{
  "name": "Palestine",
  "code": "PSE"
}
{
  "name": "Qatar",
  "code": "QAT"
}
{
  "name": "Saudi Arabia",
  "code": "SAU"
}
{
  "name": "Singapore",
  "code": "SGP"
}
{
  "name": "Syria",
  "code": "SYR"
}
{
  "name": "Thailand",
  "code": "THA"
}
{
  "name": "Tajikistan",
  "code": "TJK"
}
{
  "name": "Turkmenistan",
  "code": "TKM"
}
{
  "name": "East Timor",
  "code": "TMP"
}
{
  "name": "Turkey",
  "code": "TUR"
}
{
  "name": "Taiwan",
  "code": "TWN"
}
{
  "name": "Uzbekistan",
  "code": "UZB"
}
{
  "name": "Vietnam",
  "code": "VNM"
}
{
  "name": "Yemen",
  "code": "YEM"
}
```

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


## Access to the JBoss WebConsole & CLI via SSH

```bash
$ az webapp create-remote-connection -n jakartaee-app-on-jboss-1606464084546 \
  -g jakartaee-app-on-jboss-1606464084546-rg

Verifying if app is running....
App is running. Trying to establish tunnel connection...
Opening tunnel on port: 59445
SSH is available { username: root, password: Docker! }
Ctrl + C to close
```


```bash
ssh  root@127.0.0.1  -L 9990:localhost:9990 -p 59445
```

```
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

### Create Admin User for accessing to Web Console

```bash
-bash-4.2# /opt/eap/bin/add-user.sh -u admin -p admin -r ManagementRealm
```

Then you can access to the Web Console from your Local environment. Please open the browser and access to the following URL.

```
http://127.0.0.1:9990/console
```



## Open a log stream

```
az webapp log tail --name ${WEBAPP_NAME} \
 --resource-group ${RESOURCEGROUP_NAME}

```


