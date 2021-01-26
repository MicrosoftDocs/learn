In this unit, you will develop the Communications service to receive and process messages from Azure Service Bus by using an IDE of your choice to edit the code.

## Configuration

### Add Communications Service as a module to your microservices application

> [!NOTE]
> You may consider utilizing the Spring Tools IDE Plug-in to create a separate module called **"Communications Service"**, which will automate the below step.
>
> If you do use the IDE tooling to do it, we recommend you double check that these edits have been made to avoid any misconfiguration.
>

In the `azure/pom.xml` file, add the below line under modules -

```xml
<modules>
...
    <module>spring-petclinic-communications-service</module>
...
</modules>
```