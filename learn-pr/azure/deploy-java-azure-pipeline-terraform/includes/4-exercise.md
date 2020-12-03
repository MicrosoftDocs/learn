In this unit, you'll configure Terraform to provision your Database and Spring Boot application. Then you'll use Maven to deploy your application.

# Spring PetClinic Sample Application

## Build the application and run locally

In this module, we'll be checking out an existing project that contains all the code for our Terraform provisioning.
Lets first get it running locally.

```bash
mkdir source-code
cd source-code
git clone https://github.com/MicrosoftDocs/mslearn-java-petclinic-simplified
cd mslearn-java-petclinic-simplified
```

Build the PetClinic application:

```bash
mvn clean package -DskipTests
```

Run your Spring Boot application locally with an embedded database:

```bash
mvn spring-boot:run
```

Use a browser to access http://localhost:8080/

## Deploying to Azure

We'll use Terraform to create an Azure resource group with a MySQL database and an Azure App Service web application.

1. Customize your application, and resource group name: edit `terraform/variables.tf`.

1. To initialize the Terraform deployment, run 'terraform init'. This command downloads the Azure modules required to create an Azure resource group.

    ```bash
    cd terraform
    terraform init
    ```

1. After initialization, view the execution plan and run 'terraform plan'

    ```bash
    terraform plan
    ```

1. Once you're ready to apply the execution plan to your cloud infrastructure, run 'terraform apply'

    ```bash
    terraform apply
    ```

## Deploy via Maven

Configure your deployment with Maven:

```bash
./mvnw com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
```

To deploy the application, you'll need to configure and edit the `azure-webapp-maven-plugin` plugin, to configure the resource group and the application name (which should be the same as the ones configured in Terraform).

Then, deploy the application:

```bash
./mvnw com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:deploy
```

Browse to the URL returned by the deploy action and verify you database and application is working:
<
!--todo add screen shot-->

## Next steps

Before you move onto the next unit, delete your terraform resources and run 'terraform destroy'

```bash
terraform destroy
```

In the next unit, we'll explain GitHub Actions and how they integrate with Terraform.
