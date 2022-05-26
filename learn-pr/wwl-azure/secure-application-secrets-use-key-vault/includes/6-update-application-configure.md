You now have everything in place to start using the identities from Key Vault and remove them from your config repo. You need to add the config for your Key Vault to your config repository and update your *pom.xml* file for the `visits`, `vets`, and `customers`services to use the `com.azure.spring:azure-spring-boot-starter-keyvault-secrets` dependency.

1.  From the Git Bash window, in the config repository you cloned locally, use your favorite text editor to open the **application.ym**l file. Remove the lines 83 and 84 that contain the values of the admin user account name and its password for target datasource endpoint.

> [!NOTE]
> The lines 83 and 84 should have the following content (where, the *&lt;your-server-name&gt;* and *&lt;myadmin-password&gt;* represent the name of the Azure Database for MySQL Single Server instance and the password you assigned to the **myadmin** account during its provisioning):<br>username: **myadmin@&lt;your-server-name**&gt;<br>password: **&lt;myadmin-password&gt;**

2.  Save the changes and push the updates you made to the *application.yml*file to your private GitHub repo by running the following commands from the Git Bash prompt:

```Bash
git add .
git commit -m 'removed azure mysql credentials'
git push
```

3.  From the Git Bash window, in the config repository you cloned locally, using a text editor to open *application.yml* and append the following lines:

```YAML
Azure:
keyvault:
enabled: true
uri: https://yourkeyvaultname.vault.azure.net/

```

4.  Commit and push these changes to your remote config repository.

```Bash
git add .
git commit -m 'added key vault'
git push
```

## Update, rebuild, and redeploy the apps

5.  From the Git Bash window, in the **config** repository you cloned locally, use the text editor to open **pom.xml** files of the `customers`, `visits,`and `vets`services. For each file, add the following dependencies within the **&lt;dependencies&gt; &lt;/dependencies&gt;** section. Save the changes.

`<dependency> < groupId>com.azure.spring</groupId> <artifactId>azure-spring-boot-starter-keyvault-secrets</artifactId> </dependency>`

6.  Add a dependency to `com.azure.spring` to the parent *pom.xml* file between the elements.

`<dependencyManagement> <dependencies> //... existing dependencies`<br>`<dependency> <groupId>com.azure.spring</groupId> <artifactId>azure-spring-boot-bom</artifactId> <version>${azure.version}</version> <type>pom</type> <scope>import</scope> </dependency> </dependencies> </dependencyManagement>`

7.  Add a property for the`azure.version` to the parent *pom.xm*l file between the elements.

`<azure.version>3.13.0</azure.version>`

8.  Save the changes to the **pom.xml** file and close it.
9.  Rebuild each of the services. Make sure you are in the root directory for the Spring Petclinic application.

```Bash
cd ~/spring-petclinic-microservices
mvn clean package -DskipTests
```

10. Verify that the build succeeds by reviewing the output of the `mvn clean package -DskipTests` command, which should have the following format:

```Bash
[INFO] Reactor Summary for spring-petclinic-microservices 2.6.3:
[INFO]
[INFO] spring-petclinic-microservices ..................... SUCCESS [  0.505 s]
[INFO] spring-petclinic-admin-server ...................... SUCCESS [  4.302 s]
[INFO] spring-petclinic-customers-service ................. SUCCESS [  5.900 s]
[INFO] spring-petclinic-vets-service ...................... SUCCESS [  3.650 s]
[INFO] spring-petclinic-visits-service .................... SUCCESS [  3.520 s]
[INFO] spring-petclinic-config-server ..................... SUCCESS [  1.122 s]
[INFO] spring-petclinic-discovery-server .................. SUCCESS [  1.416 s]
[INFO] spring-petclinic-api-gateway ....................... SUCCESS [  7.646 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  28.985 s
[INFO] ------------------------------------------------------------------------

```

11. Redeploy the `customers`, `visits`and `vets`services to their respective apps in your Spring Cloud service.

```Bash
az spring-cloud app deploy
    --service $SPRING_CLOUD_SERVICE \
    --resource-group $RESOURCE_GROUP \
    --name customers-service \
    --runtime-version Java_11 \
    --no-wait \
    --artifact-path spring-petclinic-customers-service/target/spring-petclinic-customers-service-2.6.1.jar \
    --env SPRING_PROFILES_ACTIVE=mysql

az spring-cloud app deploy
    --service $SPRING_CLOUD_SERVICE \
    --resource-group $RESOURCE_GROUP \
    --name visits-service \
    --runtime-version Java_11 \
    --no-wait \
    --artifact-path spring-petclinic-visits-service/target/spring-petclinic-visits-service-2.6.1.jar \
    --env SPRING_PROFILES_ACTIVE=mysql

az spring-cloud app deploy
    --service $SPRING_CLOUD_SERVICE \
    --resource-group $RESOURCE_GROUP \
    --name vets-service \
    --runtime-version Java_11 \
    --no-wait \
    --artifact-path spring-petclinic-vets-service/target/spring-petclinic-vets-service-2.6.1.jar \
    --env SPRING_PROFILES_ACTIVE=mysql
```
