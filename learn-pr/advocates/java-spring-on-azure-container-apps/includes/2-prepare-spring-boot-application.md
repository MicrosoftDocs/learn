In this unit, you'll learn how to prepare a Spring Boot application for deployment on Azure Container Apps. We'll use the popular Spring PetClinic sample application, which demonstrates the use of Spring Framework and database access.

The Spring PetClinic is a simple web application that manages a list of veterinarians, their patients, and the visits those patients have had. This provides a practical way to understand key Spring Boot concepts while preparing it for deployment to Azure.

## Clone the PetClinic repository

To get started with PetClinic, you'll need to clone the Java on Azure Container Apps repository from GitHub. Use the following command in your terminal:

```bash
git clone https://github.com/Azure-Samples/azure-container-apps-java-samples.git
```

## Run the Application Locally

Before deploying, it’s important to ensure that the application runs successfully on your local machine.

1. Navigate to the project PetClinic directory:

```bash
cd azure-container-apps-java-samples/spring-petclinic/spring-petclinic/
```

2. Init and update the PetClinc to the latest version:
```bash
git submodule update --init --recursive
```

3. Build the project using Maven:

```bash
./mvnw clean install
```

4. Run the application:

```bash
./mvnw spring-boot:run
```

5.Once the application is up, you can access it locally via [http://localhost:8080](http://localhost:8080). You should see the Spring PetClinic interface.

![Diagram of petclinic.](../media/petclinic.png)

## Database configuration
By default, Petclinic utilizes an in-memory H2 database, which is automatically populated with data during startup. The H2 console is accessible at [http://localhost:8080/h2-console](http://localhost:8080/h2-console), allowing you to inspect the database content via the URL `jdbc:h2:mem:<uuid>`. The specific UUID is displayed in the console when the application starts.
