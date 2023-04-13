You now have everything in place to start using the identities from Key Vault and remove them from your config repo. You need to add the config for your Key Vault to your config repository and update your *pom.xml* file for the `visits`, `vets`, and `customers`services to use the `com.azure.spring:azure-spring-boot-starter-keyvault-secrets` dependency.

1.  From the Git Bash window, in the config repository you cloned locally, use your text editor to open the **application.yml** file. Remove the lines 83 and 84 that contain the values of the admin user account name and its password for target datasource endpoint.
    
    > [!NOTE]
    > The lines 83 and 84 should have the following content (where, the *`<your-server-name>`* and *`<myadmin-password>`* represent the name of the Azure Database for MySQL Single Server instance and the password you assigned to the **myadmin** account during its provisioning).

2.  In the same file, append the following lines to it (where the *&lt;key-vault-name&gt;* placeholder represents the name of the Azure Key Vault you provisioned earlier in this exercise):
    
    ```Bash
    cloud:
        azure:
            keyvault:
                secret:
                    property-source-enabled: true
                    property-sources:
                      - name: key-vault-property-souece-1
                        endpoint: https://<key-vault-name>.vault.azure.net/
                        credential.managed-identity-enabled: true
    ```

3.  Commit and push these changes to your remote config repository.
    
    ```Bash
    cd ~/projects/spring-petclinic-microservices-config
    git add .
    git commit -m 'added key vault'
    git push
    ```

## Update, rebuild, and redeploy the apps

1.  From the Git Bash window, in the **config** repository you cloned locally, use the text editor to open **pom.xml** files of the `customers`, `visits,`and `vets`services. For each file, add the following dependencies within the`<dependencies> </dependencies>` section. Save the changes.
    
    ```
    <dependency>
        <groupId>com.azure.spring</groupId>
        <artifactId>spring-cloud-azure-starter-keyvault-secrets</artifactId>
    </dependency>
    ```

2.  Add a dependency to `com.azure.spring` to the parent **pom.xml** file between the **elements**. Enter the elements within the *&lt;dependencyManagement&gt;&lt;dependencies&gt;&lt;/dependencies&gt;&lt;/dependencyManagement&gt;* section.
    
    ```
    <dependencyManagement>
        <dependencies>
            //... existing dependencies
    
            <dependency>
                <groupId>com.azure.spring</groupId>
                <artifactId>spring-cloud-azure-dependencies</artifactId>
                <version>${version.spring.cloud.azure}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
    
        </dependencies>
    </dependencyManagement>
    ```

2.  In the same file, add a property for `version.spring.cloud.azure`. Enter the elements within the *&lt;properties&gt;&lt;/properties&gt;* section.
    
    ```
    <version.spring.cloud.azure>4.4.1</version.spring.cloud.azure>
    ```

3.  Save the changes to the **pom.xml** file and close it.
4.  Rebuild each of the services. Make sure you are in the root directory for the Spring Petclinic application.
    
    ```Bash
    cd ~/projects/spring-petclinic-microservices/
    mvn clean package -DskipTests
    ```

6.  Verify that the build succeeds by reviewing the output of the `mvn clean package -DskipTests` command, which should have the following format:
    
    ```Bash
    [INFO] Reactor Summary for spring-petclinic-microservices 2.6.3:
    [INFO]
    [INFO] spring-petclinic-microservices ..................... SUCCESS [0.505 s]
    [INFO] spring-petclinic-admin-server ...................... SUCCESS [4.302 s]
    [INFO] spring-petclinic-customers-service ................. SUCCESS [5.900 s]
    [INFO] spring-petclinic-vets-service ...................... SUCCESS [3.650 s]
    [INFO] spring-petclinic-visits-service .................... SUCCESS [3.520 s]
    [INFO] spring-petclinic-config-server ..................... SUCCESS [1.122 s]
    [INFO] spring-petclinic-discovery-server .................. SUCCESS [1.416 s]
    [INFO] spring-petclinic-api-gateway ....................... SUCCESS [7.646 s]
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  28.985 s
    [INFO] ------------------------------------------------------------------------
    
    ```

7.  Redeploy the `customers`, `visits`and `vets`services to their respective apps in your Spring Apps service.
    
    ```Bash
    az spring app deploy \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name customers-service \
        --no-wait \
        --artifact-path spring-petclinic-customers-service/target/spring-petclinic-customers-service-$VERSION.jar \
        --env SPRING_PROFILES_ACTIVE=mysql
    
    az spring app deploy \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name visits-service \
        --no-wait \
        --artifact-path spring-petclinic-customers-service/target/spring-petclinic-customers-service-$VERSION.jar \
        --env SPRING_PROFILES_ACTIVE=mysql
    
    az spring app deploy \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name vets-service \
        --no-wait \
        --artifact-path spring-petclinic-customers-service/target/spring-petclinic-customers-service-$VERSION.jar \
        --env SPRING_PROFILES_ACTIVE=mysql
    ```
8.  Retest your application through its public endpoint. Ensure that the application is functional, while the connection string secrets are retrieved from Azure Key Vault.
9.  In the Azure portal, navigate to the page of the Azure Key Vault instance you provisioned. On the **Overview** page, select the **Monitoring** tab and review the graph representing requests for access to the vault's secrets.
