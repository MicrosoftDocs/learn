In this unit, you will modify the Customers service and the Visits service to send messages to Azure Service Bus by using an IDE of your choice to edit the code.

## Add the dependencies

In the `pom.xml` file for the Customers service, available at `spring-petclinic-customers-service/pom.xml`, add the below maven dependency.

```xml
<dependencies>
...
    <!-- Azure Service Bus starter for Spring Boot -->
    <dependency>
        <groupId>com.microsoft.azure</groupId>
        <artifactId>azure-servicebus-jms-spring-boot-starter</artifactId>
        <version>2.3.2-SNAPSHOT</version>
    </dependency>
...
</dependencies>
```

Similarly, in the `pom.xml` file for the Visits service, available at `spring-petclinic-visits-service/pom.xml`, add the below maven dependency.

```xml
<dependencies>
...
    <!-- Azure Service Bus starter for Spring Boot -->
    <dependency>
        <groupId>com.microsoft.azure</groupId>
        <artifactId>azure-servicebus-jms-spring-boot-starter</artifactId>
        <version>2.3.2-SNAPSHOT</version>
    </dependency>
...
</dependencies>
```

Let the IDE automatically resolve the maven dependencies, or utilize the maven command to do the same.

## Publish messages

### Add logic to have customers service publish messages to an Azure Service Bus Queue

In the `spring-petclinic-customers-service/src/main/java/org/springframework/samples/petclinic/customers/web/OwnerResource.java` file -

1) Add the below variables -

    ```java
    private static final String DESTINATION_NAME = "createdowner";
    
    @Autowired
    private JmsTemplate jmsTemplate;
    ```

2) Then, modify the `createOwner` method from -

    ```java
    /**
     * Create Owner
     */
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Owner createOwner(@Valid @RequestBody Owner owner) {
        return ownerRepository.save(owner);
    }
    ```

    to

    ```java
    /**
     * Create Owner
     */
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Owner createOwner(@Valid @RequestBody Owner owner) {
        
        Owner savedOwner = ownerRepository.save(owner);
        
        ObjectMapper objMapper = new ObjectMapper();
        try {
            jmsTemplate.convertAndSend(DESTINATION_NAME, objMapper.writeValueAsString(savedOwner));
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
    
        return savedOwner;
    }
    ```

### Add logic to have visits service publish messages to Azure Service Bus Topic

In the `spring-petclinic-visits-service/src/main/java/org/springframework/samples/petclinic/visits/web/VisitResource.java` file -

1. Add the below variables -

    ```java
    @Autowired
    private Topic topic;
    
    @Autowired
    private JmsTemplate jmsTemplate;
    ```

2. Then, modify the `create` method from -

    ```java
    @PostMapping("owners/*/pets/{petId}/visits")
    @ResponseStatus(HttpStatus.CREATED)
    public Visit create(
        @Valid @RequestBody Visit visit,
        @PathVariable("petId") int petId) {
   
        visit.setPetId(petId);
        log.info("Saving visit {}", visit);
        return visitRepository.save(visit);
    }
    ```

    to

    ```java
    @PostMapping("owners/*/pets/{petId}/visits")
    @ResponseStatus(HttpStatus.CREATED)
    Visit create(
        @Valid @RequestBody Visit visit,
        @PathVariable("petId") int petId) {

        visit.setPetId(petId);
        log.info("Saving visit {}", visit);
        
        Visit savedVisit = visitRepository.save(visit);
        
        ObjectMapper objMapper = new ObjectMapper();
        try {
            jmsTemplate.convertAndSend(topic, objMapper.writeValueAsString(savedVisit));
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        
        return savedVisit;
    }
    ```
