In this unit, you'll learn how to extend a Spring microservices application and run it on Azure Spring cloud.

## Introduction to Azure Spring Cloud

## Clone and deploy the Spring Petclinic Microservices sample

Spring is the perfect framework to host and manage our applications. All we have to do is wire certain Spring components without managing the underlying server runtime.

Since we are working with the Spring Petclinic application as a starting point, it is recommended that you follow the [instructions](https://github.com/Azure-Samples/spring-petclinic-microservices/blob/azure/README.md) to clone and deploy the microservices on to Azure Spring Cloud.

## Create an Azure Service Bus Premium tier namespace

For this course, we will have various microservices send messages to and receive messages from Azure Service Bus - Premium tier namespace.

To know how to create an Azure Service Bus Premium tier namespace, follow the steps mentioned in [this guide](https://docs.microsoft.com/azure/service-bus-messaging/service-bus-create-namespace-portal).

## Create a SendGrid account and obtain the API

As part of this course, we will build workflows to send emails to customers of the Spring Petclinic application. To achieve this, we must utilize a mail sending service, SendGrid, to programmatically send these emails.

To learn more about how to create a SendGrid account and use it to send emails from a Java program, review the steps mentioned in [this guide](https://docs.microsoft.com/azure/store-sendgrid-java-how-to-send-email).

## Create the Communications microservice

Once we have our microservices set up, we proceed to create the communications microservice.

### Set the appropriate environment variables

In the `.scripts/setup-env-variables-azure-template.sh` file, add the below lines

```bash
# ==== Service and App Instances ====
export COMMUNICATIONS_SERVICE=communications-service

# ==== JARS ====
export COMMUNICATIONS_SERVICE_JAR=spring-petclinic-visits-service/target/spring-petclinic-communications-service-2.2.1.jar

# ==== SERVICE BUS INFO ====
export SERVICE_BUS_CONNECTION_STRING=connection-string-with-manage-permissions # insert the service bus connection string from the Azure portal
export SERVICE_BUS_IDLE_TIMEOUT=20000 # customize this
export SERVICE_BUS_TOPIC_CLIENT_ID=test-application #customize this


# ===== SENDGRID API ====
export SENDGRID_API_KEY=sendgrid-api-key # insert your sendgrid api key here

# ===== EMAIL OVERRIDES TO SEND SAMPLE EMAILS ====
export EMAIL_ACTIVE=false # pick true or false
export DEFAULT_RECIPIENT=john.doe@example.com # replace with your testing email account

```

Once the edits are done, proceed to run the below command so that the environments variables are set.

```bash
source .scripts/setup-env-variables-azure.sh
```

### Configure the communications service in your Azure Spring cloud instance

Execute the below command to create the communications service

```bash
az spring-cloud app create --name ${COMMUNICATIONS_SERVICE} --instance-count 1 --is-public true \
        --memory 2 \
        --jvm-options='-Xms2048m -Xmx2048m'	\
        --enable-persistent-storage true
```

Then, execute the below command to disable public URIs for the communications service

```bash
az spring-cloud app update --name ${COMMUNICATIONS_SERVICE} --is-public false
```
