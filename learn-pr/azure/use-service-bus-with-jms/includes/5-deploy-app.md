In this unit, you'll learn to package and deploy everything to Azure Spring cloud and see your application in action.

## Build/Package the application

Since we've made changes to multiple services (Communications Service, Customers service, Visit service), we must rebuild the application.

In the `spring-petclinic-microservices` folder, we run the below command

```bash
mvn clean package -DskipTests -Denv=cloud
```

We then proceed to redeploy the Customers service and the Visits service along with deploying the Communications service for the first time.

> [!NOTE]
> Since this course builds on top of the [Spring petclinic microservices](https://github.com/Azure-Samples/spring-petclinic-microservices), the other services are expected to be running already.
>
> Hence we only build and deploy the services that we actually changed.
>

```bash
  az spring-cloud app deploy --name ${CUSTOMERS_SERVICE} \
        --jar-path ${CUSTOMERS_SERVICE_JAR} \
        --jvm-options='-Xms2048m -Xmx2048m -Dspring.profiles.active=mysql,communications  -javaagent:/persistent/applicationinsights-agent-3.0.0-PREVIEW.5.jar' \
        --env MYSQL_SERVER_FULL_NAME=${MYSQL_SERVER_FULL_NAME} \
              MYSQL_DATABASE_NAME=${MYSQL_DATABASE_NAME} \
              MYSQL_SERVER_ADMIN_LOGIN_NAME=${MYSQL_SERVER_ADMIN_LOGIN_NAME} \
              MYSQL_SERVER_ADMIN_PASSWORD=${MYSQL_SERVER_ADMIN_PASSWORD}	\
              SERVICE_BUS_CONNECTION_STRING=${SERVICE_BUS_CONNECTION_STRING}	\
              SERVICE_BUS_IDLE_TIMEOUT=${SERVICE_BUS_IDLE_TIMEOUT}	\
              APPLICATIONINSIGHTS_CONNECTION_STRING=${APPLICATIONINSIGHTS_CONNECTION_STRING} \
              APPLICATIONINSIGHTS_ROLE_NAME=${CUSTOMERS_SERVICE}
    
    az spring-cloud app deploy --name ${VISITS_SERVICE} \
        --jar-path ${VISITS_SERVICE_JAR} \
        --jvm-options='-Xms2048m -Xmx2048m -Dspring.profiles.active=mysql,communications  -javaagent:/persistent/applicationinsights-agent-3.0.0-PREVIEW.5.jar' \
        --env MYSQL_SERVER_FULL_NAME=${MYSQL_SERVER_FULL_NAME} \
              MYSQL_DATABASE_NAME=${MYSQL_DATABASE_NAME} \
              MYSQL_SERVER_ADMIN_LOGIN_NAME=${MYSQL_SERVER_ADMIN_LOGIN_NAME} \
              MYSQL_SERVER_ADMIN_PASSWORD=${MYSQL_SERVER_ADMIN_PASSWORD}	\
              SERVICE_BUS_CONNECTION_STRING=${SERVICE_BUS_CONNECTION_STRING}	\
              SERVICE_BUS_IDLE_TIMEOUT=${SERVICE_BUS_IDLE_TIMEOUT}	\
              SERVICE_BUS_TOPIC_CLIENT_ID=${SERVICE_BUS_TOPIC_CLIENT_ID}	\
              APPLICATIONINSIGHTS_CONNECTION_STRING=${APPLICATIONINSIGHTS_CONNECTION_STRING} \
              APPLICATIONINSIGHTS_ROLE_NAME=${VISITS_SERVICE}

    az spring-cloud app deploy --name ${COMMUNICATIONS_SERVICE} \
        --jar-path ${COMMUNICATIONS_SERVICE_JAR} \
        --jvm-options='-Xms2048m -Xmx2048m -Dspring.profiles.active=mysql,communications,email  -javaagent:/persistent/applicationinsights-agent-3.0.0-PREVIEW.5.jar' \
        --env MYSQL_SERVER_FULL_NAME=${MYSQL_SERVER_FULL_NAME} \
              MYSQL_DATABASE_NAME=${MYSQL_DATABASE_NAME} \
              MYSQL_SERVER_ADMIN_LOGIN_NAME=${MYSQL_SERVER_ADMIN_LOGIN_NAME} \
              MYSQL_SERVER_ADMIN_PASSWORD=${MYSQL_SERVER_ADMIN_PASSWORD}	\
              SERVICE_BUS_CONNECTION_STRING=${SERVICE_BUS_CONNECTION_STRING}	\
              SERVICE_BUS_IDLE_TIMEOUT=${SERVICE_BUS_IDLE_TIMEOUT}	\
              SERVICE_BUS_TOPIC_CLIENT_ID=${SERVICE_BUS_TOPIC_CLIENT_ID}	\
              SENDGRID_API_KEY=${SENDGRID_API_KEY}	\
              EMAIL_ACTIVE=${EMAIL_ACTIVE}	\
              DEFAULT_RECIPIENT=${DEFAULT_RECIPIENT}	\
              APPLICATIONINSIGHTS_CONNECTION_STRING=${APPLICATIONINSIGHTS_CONNECTION_STRING} \
              APPLICATIONINSIGHTS_ROLE_NAME=${COMMUNICATIONS_SERVICE}
```

Once the deployment is complete, run the below command to identify how to access the application.

```bash
az spring-cloud app show --name ${API_GATEWAY} | grep url
```

Navigate to the URL provided by the previous command to open the Petclinic microservice application.

## See the application in action

### Create a new pet owner

Click the **Owners** option from the top ribbon menu, and select **Register**.

Once there add the relevant information and hit **Submit** to create the user.

If the email functionality is activated, the email should reach your sample email account.

### Log a new visit

Click the **Owners** option from the top ribbon menu, and select **All**.

Then, proceed to select one of the owners from the list, and see the list of **pets** for that owner. For any of the pets listed here, proceed to **Add visit**.

Select the date and the description and then click **Add New Visit**.

If the email functionality is activated, the email should reach your sample email account.
