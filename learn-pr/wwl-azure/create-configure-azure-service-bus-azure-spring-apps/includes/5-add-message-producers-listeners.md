In this unit, you'll send and receive messages to the **visits** service.

Below is the activity flow.

 -  The **message-emulator** sends a `PetClinicMessageRequest`to the **visits-requests** queue.
 -  The **visits** service listens to the queue every time a `VisitRequest` arrives and creates a new `visit` for the pet ID inside the message.
 -  The **visits** service sends back a `VisitResponse`as a confirmation to the **visits-confirmations** queue, which is the queue the **message-emulator** is listening to.

1.  In the **spring-petclinic-visits-service**, create a new *src/main/java/org/springframework/samples/petclinic/visits/entities* folder and a`VisitRequest.java`class with the code displayed below.
    
    ```
    package org.springframework.samples.petclinic.visits.entities;
    
    import java.io.Serializable;
    import java.util.Date;
    
    public class VisitRequest implements Serializable {
        private static final long serialVersionUID = -249974321255677286L;
    
        private Integer requestId;
        private Integer petId;
        private String message;
    
        public VisitRequest() {
        }
    
        public Integer getRequestId() {
            return requestId;
        }
    
        public void setRequestId(Integer id) {
            this.requestId = id;
        }
    
        public Integer getPetId() {
            return petId;
        }
    
        public void setPetId(Integer petId) {
            this.petId = petId;
        }
    
        public String getMessage() {
            return message;
        }
    
        public void setMessage(String message) {
            this.message = message;
        }
    }
    ```

2.  In the *src/main/java/org/springframework/samples/petclinic/visits/entities* directory, add a `VisitResponse.java` class using the code below.
    
    ```
    
    public class VisitResponse {
        Integer requestId;
        Boolean confirmed;
        String reason;
    
        public VisitResponse() {
        }
    
        public VisitResponse(Integer requestId, Boolean confirmed, String reason) {
            this.requestId = requestId;
            this.confirmed = confirmed;
            this.reason = reason;
        }
    
        public Boolean getConfirmed() {
            return confirmed;
        }
    
        public void setConfirmed(Boolean confirmed) {
            this.confirmed = confirmed;
        }
    
        public String getReason() {
            return reason;
        }
    
        public void setReason(String reason) {
            this.reason = reason;
        }
    
        public Integer getRequestId() {
            return requestId;
        }
    
        public void setRequestId(Integer requestId) {
            this.requestId = requestId;
        }
    }
    ```

3.  In the **spring-petclinic-visits-service**, create a new *src/main/java/org/springframework/samples/petclinic/visits/config* directory and add a `MessagingConfig.java` class using the code listed below.
    
    ```
    
    import java.util.HashMap;
    import java.util.Map;
    
    import org.springframework.beans.factory.annotation.Value;
    import org.springframework.context.annotation.Bean;
    import org.springframework.context.annotation.Configuration;
    import org.springframework.jms.support.converter.MappingJackson2MessageConverter;
    import org.springframework.jms.support.converter.MessageConverter;
    import org.springframework.samples.petclinic.visits.entities.VisitRequest;
    import org.springframework.samples.petclinic.visits.entities.VisitResponse;
    
    @Configuration
    public class MessagingConfig {
    
        @Bean("QueueConfig")
        public QueueConfig queueConfig() {
            return new QueueConfig();
        }
    
        @Bean
        public MessageConverter jackson2Converter() {
            MappingJackson2MessageConverter converter = new MappingJackson2MessageConverter();
    
            Map<String, Class<?>> typeMappings = new HashMap<String, Class<?>>();
            typeMappings.put("visitRequest", VisitRequest.class);
            typeMappings.put("visitResponse", VisitResponse.class);
            converter.setTypeIdMappings(typeMappings);
            converter.setTypeIdPropertyName("messageType");
            return converter;
        }
    }
    ```

4.  In the **spring-petclinic-visits-service**, create a new *src/main/java/org/springframework/samples/petclinic/visits/service* directory and add a `VisitsReceiver.java_ class` using the code seen below.
    
    ```
    
    import java.util.Date;
    
    import org.springframework.beans.factory.annotation.Value;
    import org.springframework.context.annotation.Bean;
    import org.springframework.jms.annotation.JmsListener;
    import org.springframework.jms.core.JmsTemplate;
    import org.springframework.samples.petclinic.visits.entities.VisitRequest;
    import org.springframework.samples.petclinic.visits.entities.VisitResponse;
    import org.springframework.samples.petclinic.visits.model.Visit;
    import org.springframework.samples.petclinic.visits.model.VisitRepository;
    import org.springframework.stereotype.Component;
    
    import lombok.RequiredArgsConstructor;
    import lombok.extern.slf4j.Slf4j;
    
    @Component
    @Slf4j
    @RequiredArgsConstructor
    public class VisitsReceiver {
        private final VisitRepository visitsRepository;
    
        private final JmsTemplate jmsTemplate;
    
        @JmsListener(destination = "visits-requests")
        void receiveVisitRequests(VisitRequest visitRequest) {
            log.info("Received message: {}", visitRequest.getMessage());
            try {
                Visit visit = new Visit(null, new Date(), visitRequest.getMessage(),
                    visitRequest.getPetId());
                visitsRepository.save(visit);
                jmsTemplate.convertAndSend("visits-confirmations", new VisitResponse(visitRequest.getRequestId(), true, "Your visit request has been accepted"));
            } catch (Exception ex) {
                log.error("Error saving visit: {}", ex.getMessage());
                jmsTemplate.convertAndSend("visits-confirmations", new VisitResponse(visitRequest.getRequestId(), false, ex.getMessage()));
            }
        }
    
    }
    ```
    
    The **VisitsReceiver** is listening to the **visits-requests** queue. When a message appears in the queue, the message dequeued and saved as a new **Visit** in the database.
    
    The procedure below sends a confirmation message to the **visits-confirmations** queue.

5.  Rebuild your application.
    
    ```azurecli
    mvn clean package -DskipTests
    ```

6.  Redeploy the **visits** microservice.
    
    ```azurecli
    az spring-cloud app deploy
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name visits-service \
        --no-wait \
        --artifact-path spring-petclinic-visits-service/target/spring-petclinic-visits-service-2.6.1.jar \
        --env SPRING_PROFILES_ACTIVE=mysql
    ```

7.  You can now peek the queue. You should see messages being received by the **visits** microservice. Use the **message-emulator** microservice to view details on **visits** being created.
