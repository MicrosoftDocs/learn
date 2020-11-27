In this unit, you'll configure Terraform to provision your Database and Spring Boot application. Then you'll use Maven to deploy your application.

# Spring PetClinic Sample Application

```bash
mkdir source-code
cd source-code
git clone https://github.com/jdubois/spring-petclinic
cd spring-petclinic
git checkout deploy-to-azure
mvn clean package -DskipTests
mvn spring-boot:run
http://localhost:8080/
```

## Deploying to Azure

We use Terraform to create an Azure resource group with a MySQL database and an Azure App Service web application.

You'll customize your application name, and your resource group name: edit the `terraform/variables.tf`.

1. To initialize the Terraform deployment, run 'terraform init'. This command downloads the Azure modules required to create an Azure resource group.

    ```bash
    cd terraform
    terraform init
    ```

1. After initialization, you can view the  execution plan by running 'terraform plan'

    ```bash
    terraform plan
    ```

1. Once you're ready to apply the execution plan to your cloud infrastructure, you run 'terraform apply'

    ```bash
    terraform apply
    ```

## Reverse a Terraform execution plan

1. To reverse, or undo, the execution plan, you run 'terraform destroy'

    ```bash
    terraform destroy
    ```

## Deploy via Maven

Configure your deployment by running:

```bash
./mvnw azure-webapp:config
```

To deploy the application, you'll need to configure and edit the `azure-webapp-maven-plugin` plugin, to configure the resource group and the application name (which should be the same as
the ones configured in Terraform).

Then, deploy the application by running:

```bash
./mvnw azure-webapp:deploy
```
