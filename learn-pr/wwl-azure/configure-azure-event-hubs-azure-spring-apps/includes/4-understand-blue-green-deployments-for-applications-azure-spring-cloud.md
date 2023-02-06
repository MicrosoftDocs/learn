In this unit, you'll update the **customers** microservice to receive events from the **telemetry** event hub.

1.  From Visual Studio Code, open the **pom.xml** file of the **spring-petclinic-customers-service** microservice. Add another dependency element within the `<!-- Spring Cloud -->` section of the `` ` `` element, and save the change. Edit to add the dependency seen below.
    
    ```xml
    <dependency>
        <groupId>org.springframework.kafka</groupId>
        <artifactId>spring-kafka</artifactId>
    </dependency>
    ```

2.  From the ***/src/main/java/org/springframework/samples/petclinic/customers*** directory, create a new directory called **services**. In the **services** directory, add a **EventHubListener.java** class that includes the code listed below.
    
    ```
    package org.springframework.samples.petclinic.customers.services;
    
    import org.slf4j.Logger;
    import org.slf4j.LoggerFactory;
    import org.springframework.kafka.annotation.KafkaListener;
    import org.springframework.stereotype.Service;
    
    @Service
    public class EventHubListener {
    
        private static final Logger log = LoggerFactory.getLogger(EventHubListener.class);
    
        @KafkaListener(topics = "telemetry", groupId = "$Default")
        public void receive(String in) {
            log.info("Received message from kafka queue: {}",in);
            System.out.println(in);
        }
    }
    ```
    
    The **EventHubListener.java** class uses the ***KafkaListener*** annotation to initialize listening to an event hub. For our purposes, the ***$Default*** group of the **telemetry** event hub. All messages received are written into the log as info messages.

3.  From the Git Bash window, navigate to the spring petclinic root folder and rebuild the application.
    
    ```azurecli
    cd ~/projects/spring-petclinic-microservices/
    mvn clean package -DskipTests
    ```

4.  Redeploy your customers microservice to Azure Spring Apps by running the lines below.
    
    ```azurecli
    az spring app deploy \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name customers-service \
        --no-wait \
        --artifact-path spring-petclinic-customers-service/target/spring-petclinic-customers-service-$VERSION.jar \
        --env SPRING_PROFILES_ACTIVE=mysql
    ```
