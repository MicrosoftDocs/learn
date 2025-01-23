In this unit, you learn how to prepare a Spring Boot application for deployment on Azure Container Apps. We use the popular Spring PetClinic sample application, which demonstrates the use of Spring Framework and database access.

The Spring PetClinic is a simple web application that manages a list of veterinarians, their patients, and the visits those patients had. This application provides a practical way to understand key Spring Boot concepts while preparing a Spring Boot application for deployment to Azure.

## Prerequisites

- An Azure account. If you don't have one, [create an account for free](https://azure.microsoft.com/free/). You need the `Contributor` or `Owner` permission on the Azure subscription to proceed. Refer to [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal) for details.
- [Git](https://git-scm.com/downloads)
- [The Azure CLI](/cli/azure/install-azure-cli)

## Clone the PetClinic repository

To get started with PetClinic, clone the [Azure Container Apps Java Samples](https://github.com/Azure-Samples/azure-container-apps-java-samples) repository from GitHub by using the following command:

# [Bash](#tab/bash)

```bash
git clone https://github.com/Azure-Samples/azure-container-apps-java-samples.git
```

# [PowerShell](#tab/powershell)

```powershell
git clone https://github.com/Azure-Samples/azure-container-apps-java-samples.git
```

---

## Run the application locally

Before deploying, ensure that the PetClinic application runs successfully on your local machine, by using the following steps:

1. Navigate to the project directory by using the following command:

    # [Bash](#tab/bash)

    ```bash
    cd azure-container-apps-java-samples/spring-petclinic/spring-petclinic/
    ```

    # [PowerShell](#tab/powershell)

    ```powershell
    cd azure-container-apps-java-samples/spring-petclinic/spring-petclinic/
    ```

    ---

1. Initialize and update the `pet-clinic` git submodule to the latest version by using the following command:

    # [Bash](#tab/bash)

    ```bash
    git submodule update --init --recursive
    ```

    # [PowerShell](#tab/powershell)

    ```powershell
    git submodule update --init --recursive
    ```

    ---

1. Build the project by using the following Maven command:

    # [Bash](#tab/bash)

    ```bash
    ./mvnw clean install
    ```

    # [PowerShell](#tab/powershell)

    ```powershell
    ./mvnw clean install
    ```

    ---

1. Run the application by using the following command:

    # [Bash](#tab/bash)

    ```bash
    ./mvnw spring-boot:run
    ```

    # [PowerShell](#tab/powershell)

    ```powershell
    ./mvnw spring-boot:run
    ```

    ---

1. Once the application is running, you can access it locally via [http://localhost:8080](http://localhost:8080). You should see the Spring PetClinic interface.

    :::image type="content" source="../media/pet-clinic.png" alt-text="Screenshot of the home page of the PetClinic application." lightbox="../media/pet-clinic.png":::

## Database configuration

By default, the PetClinic application uses an in-memory H2 database that is automatically populated with data during startup. The H2 console is accessible at [http://localhost:8080/h2-console](http://localhost:8080/h2-console), allowing you to inspect the database content via the URL `jdbc:h2:mem:<uuid>`. The specific UUID is displayed in the console when the application starts.
