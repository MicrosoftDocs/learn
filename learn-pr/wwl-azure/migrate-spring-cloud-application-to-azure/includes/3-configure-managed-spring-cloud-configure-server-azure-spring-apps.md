Azure Spring Apps Config Server is a centralized configuration service for distributed systems. It uses a pluggable repository layer that currently supports local storage, Git, and Subversion. In this exercise, you set up the Config Server to get data from a Git repository. :::image type="content" source="../media/spring-microservices-azure-samples-c1f6cfad.png" alt-text="Screenshot of the exercise source files.":::
In this module, you'll set up a config server for your Spring Apps apps. You'll need to link the config server to a git repo.

Azure Spring Apps Config Server is centralized configuration service for distributed systems. It uses a pluggable repository layer that currently supports local storage, Git, and Subversion. Set up the Config Server to deploy Spring apps to Azure Spring Apps.

The configuration used by the Spring microservices resides in the [PetClinic GitHub repo.](https://github.com/spring-petclinic/spring-petclinic-microservices-config) In this exercise, you'll create your own private git repo then update the configuration settings.

Using a web browser, navigate to [GitHub](https://github.com/) and sign in to your GitHub account. If you don't have a GitHub account, create one by navigating to [the Join GitHub page](https://github.com/join) and following the instructions provided on [the Signing up for a new GitHub account page](https://docs.github.com/en/get-started/signing-up-for-github/signing-up-for-a-new-github-account).

1.  From your GitHub account, navigate to the **Repositories** page and create a new private repository named **spring-petclinic-microservice***s*.
    
    > [!NOTE]
    > Make sure to configure the git repository as private.
    
    > [!NOTE]
    > Record the value of the URL of the newly created GitHub repository. You'll use the URL later in this lab. The value should be *https://github.com/your-github-username/spring-petclinic-microservices-private.git*, where the *your-github-username* placeholder represents your GitHub user name.

2.  From the Git Bash prompt, make sure you're no longer in the s**pring-petclinic-microservices** folder and clone the **spring-petclinic-microservices-config** repo.
    
    ```Bash
    cd ~/projects
    git clone https://github.com/<your-github-username>/spring-petclinic-microservices-config.git
    ```

3.  From the Git Bash prompt, move to the newly created **spring-petclinic-microservices-config** folder and run the commands below. The commands copy all the config server configuration yaml files from [spring-petclinic-microservices-config](https://github.com/spring-petclinic/spring-petclinic-microservices-config) to the local folder on your lab computer.
    
    The commands should resemble:
    
    ```Bash
    cd spring-petclinic-microservices-config
    curl -o admin-server.yml https://raw.githubusercontent.com/spring-petclinic/spring-petclinic-microservices-config/main/admin-server.yml
    curl -o api-gateway.yml https://raw.githubusercontent.com/spring-petclinic/spring-petclinic-microservices-config/main/api-gateway.yml
    curl -o application.yml https://raw.githubusercontent.com/spring-petclinic/spring-petclinic-microservices-config/main/application.yml
    curl -o customer-service.yml https://raw.githubusercontent.com/spring-petclinic/spring-petclinic-microservices-config/main/customer-service.yml
    curl -o discovery-server.yml https://raw.githubusercontent.com/spring-petclinic/spring-petclinic-microservices-config/main/discovery-server.yml
    curl -o tracing-server.yml https://raw.githubusercontent.com/spring-petclinic/spring-petclinic-microservices-config/main/tracing-server.yml
    curl -o vets-service.yml https://raw.githubusercontent.com/spring-petclinic/spring-petclinic-microservices-config/main/vets-service.yml
    curl -o visit-service.yml https://raw.githubusercontent.com/spring-petclinic/spring-petclinic-microservices-config/main/visit-service.yml
    ```

4.  From the Git Bash window, run the following commands to clone the [Spring Petclinic](https://github.com/spring-petclinic/spring-petclinic-microservices) application to your workstation:
    
    ```Bash
    git add .
    git commit -m 'added base config'
    git push
    ```

5.  In your web browser, refresh the page of the newly created spring-petclinic-microservices-config repository and double check that all the configuration files are there.

Once you completed the initial update of your git repository hosting the server configuration, you need to set up the config server for your Spring Apps instance. As part of the setup process, you need to create a Personal Access Token (PAT) in your GitHub repo and make it available to the config server.

For reference, see the following information:

 -  [Guidance on config server setup](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/spring-cloud/quickstart-setup-config-server.md)
 -  [Guidance for a private repo with basic authentication](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/spring-cloud/how-to-config-server.md)

To create a Personal Access Token, do the following tasks:<br>

1.  To create a Personal Access Token, switch to the web browser window displaying your private GitHub repository, select the avatar icon in the upper right corner, and then select **Settings**.
2.  At the bottom of the vertical navigation menu, select **Developer settings**, select **Personal access tokens**, and then select **Generate new token**.
3.  Confirm access, enter your GitHub account password and select **Confirm password**.
4.  On the **New personal access token** page, in the **Note** text box, enter a descriptive name, such as *spring-petclinic-config-server-token*.
5.  Ensure that value in the **Expiration** drop-down list is set to **30 days**.
6.  In the **Select scopes** section, select **repo** and then select **Generate token**.
7.  Record the generated token. You'll need it in the next step.
8.  From the Git Bash prompt and run the following commands to set the environment variables hosting your GitHub repository and set up the config server to point to your GitHub repository.
    
    > [!NOTE]
    > Replace the *git\_repository*, *git\_username*, and *git\_password* placeholders with the URL for the GitHub repository, name of your GitHub user account, and the Personal Access Token value.
    
    ```Bash
    GIT_REPO=[git repository]
    GIT_USERNAME=[git username]
    GIT_PASSWORD=[git password]
    
    az spring-apps config-server git set \
        --name $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --label main \
        --password $GIT_PASSWORD \
        --username $GIT_USERNAME
    ```
