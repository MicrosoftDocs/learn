You now have the compute and data services available for deployment of the components of your applications, including:

 -  spring-petclinic-admin-server
 -  spring-petclinic-customers-service
 -  spring-petclinic-vets-service
 -  spring-petclinic-visits-service
 -  spring-petclinic-api-gateway

In this task, you'll deploy these components as microservices to the Azure Spring Apps service. You'll not be deploying the spring-petclinic-config-server and spring-petclinic-discovery-server to Azure Spring Apps, which will be provided to you by the platform.

> [!NOTE]
> The spring-petclinic-api-gateway and spring-petclinic-admin-server will have a public endpoint assigned to them.

> [!NOTE]
> When you deploy the customers-service, vets-service and visits-service you should do so with the mysql profile activated.

1.  Begin by building all the microservice of the spring petclinic application, by running `mvn clean package` in the root directory of the application.
    
    ```
    cd ~/spring-petclinic-microservices/
    mvn clean package -DskipTests
    ```

2.  Verify that the build succeeds by reviewing the output of the `mvn clean package -DskipTests` command, which should have the following format:
    
    ```
    [INFO] Reactor Summary for spring-petclinic-microservices 2.6.3:
    [INFO]
    [INFO] spring-petclinic-microservices ..................... SUCCESS [ 0.224 s]
    [INFO] spring-petclinic-admin-server ...................... SUCCESS [ 5.665 s]
    [INFO] spring-petclinic-customers-service ................. SUCCESS [ 4.231 s]
    [INFO] spring-petclinic-vets-service ...................... SUCCESS [ 3.152 s]
    [INFO] spring-petclinic-visits-service .................... SUCCESS [ 2.902 s]
    [INFO] spring-petclinic-config-server ..................... SUCCESS [ 1.030 s]
    [INFO] spring-petclinic-discovery-server .................. SUCCESS [ 1.429 s]
    [INFO] spring-petclinic-api-gateway ....................... SUCCESS [ 8.277 s]
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time: 27.310 s
    [INFO] ------------------------------------------------------------------------
    ```

3.  For each application, you'll now create an app on Azure Spring Apps service. you'll start with the api-gateway. To deploy it, from the Git Bash prompt, run the following command:
    
    ```Bash
    az spring-cloud app create \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name api-gateway \
        --assign-endpoint true
    ```
    
    > [!NOTE]
    > Wait for the provisioning to complete, about 5 minutes.

4.  Next deploy the jar file to this newly created app by running the following command from the Git Bash prompt:
    
    ```Bash
    az spring-cloud app deploy \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name api-gateway \
        --no-wait \
        --artifact-path spring-petclinic-api-gateway/target/spring-petclinic-api-gateway-2.6.3.jar
    ```

5.  In the same way create an app for the admin-server microservice:
    
    ```Bash
    az spring-cloud app create \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name app-admin \
        --assign-endpoint
    ```
    
    > [!NOTE]
    > Wait for the opeation to complete, about 5 minutes.

6.  Next deploy the jar file to this newly created app:
    
    ```Bash
    az spring-cloud app deploy \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name app-admin \
        --no-wait \
        --artifact-path spring-petclinic-admin-server/target/spring-petclinic-admin-server-2.6.3.jar
    ```

7.  Next, you'll create an app for the customers-service microservice:
    
    ```Bash
    az spring-cloud app create \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name customers-service
    ```
    
    > [!NOTE]
    > Wait for the opeation to complete, about 5 minutes.

8.  You'll not assign an endpoint but you'll set the mysql profile (customers service):
    
    ```Bash
    az spring-cloud app deploy \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name customers-service \
        --no-wait \
        --artifact-path spring-petclinic-customers-service/target/spring-petclinic-customers-service-2.6.3.jar \
        --env SPRING_PROFILES_ACTIVE=mysql
    ```

9.  Next, you'll create an app for the visits-service microservice:
    
    ```Bash
    az spring-cloud app create \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name visits-service
    ```
    
    > [!NOTE]
    > Wait for the opeation to complete, about 5 minutes.

10. For the visit-service will also skip the endpoint assignment but include the mysql profile:
    
    ```Bash
    az spring-cloud app deploy \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name visits-service \
        --no-wait \
        --artifact-path spring-petclinic-visits-service/target/spring-petclinic-visits-service-2.6.3.jar \
        --env SPRING_PROFILES_ACTIVE=mysql
    ```

11. To conclude, you'll create an app for the vets-service microservice:
    
    ```Bash
    az spring-cloud app create \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name vets-service
    ```
    
    > [!NOTE]
    > Wait for the operation to complete, about 5 minutes.

12. In this case, you'll also skip the endpoint assignment but include the mysql profile:
    
    ```Bash
    az spring-cloud app deploy \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name vets-service \
        --no-wait \
        --artifact-path spring-petclinic-vets-service/target/spring-petclinic-vets-service-2.6.3.jar \
        --env SPRING_PROFILES_ACTIVE=mysql
    ```
