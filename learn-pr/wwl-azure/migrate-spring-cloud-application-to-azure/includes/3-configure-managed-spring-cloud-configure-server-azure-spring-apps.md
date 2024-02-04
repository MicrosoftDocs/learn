Azure Spring Apps Config Server is a centralized configuration service for distributed systems. It uses a pluggable repository layer that currently supports local storage, Git, and Subversion. In this exercise, you set up the Config Server for retrieving data from the lab starter branch of the [spring-petclinic-microservices-config repo](https://github.com/Azure-Samples/spring-petclinic-microservices-config/tree/labstarter).

:::image type="content" source="../media/spring-microservices-azure-samples-c1f6cfad.png" alt-text="Screenshot of the exercise source files in the repo.":::
In this module, you'll set up a config server for your Spring Apps apps. You'll need to link the config server to a git repo.

Azure Spring Apps Config Server is centralized configuration service for distributed systems. It uses a pluggable repository layer that currently supports local storage, Git, and Subversion. Set up the Config Server to deploy Spring apps to Azure Spring Apps.

The configuration used by the Spring microservices resides in the [lab starter branch of the GitHub repo](https://github.com/Azure-Samples/spring-petclinic-microservices/tree/labstarter)[.](https://github.com/spring-petclinic/spring-petclinic-microservices-config) In this exercise, you'll create your own private git repo then update the configuration settings.

To create a Personal Access Token, do the following tasks:<br>

1.  To create a Personal Access Token, switch to the web browser window displaying your private GitHub repository, select the avatar icon in the upper right corner, and then select **Settings**.
2.  At the bottom of the vertical navigation menu, select **Developer settings**, select **Personal access tokens**, and then select **Generate new token**.
3.  Confirm access, enter your GitHub account password and select **Confirm password**.
4.  On the **New personal access token** page, in the **Note** text box, enter a descriptive name, such as *spring-petclinic-config-server-token*.
5.  Ensure that value in the **Expiration** drop-down list is set to **30 days**.
6.  In the **Select scopes** section, select **repo** and then select **Generate token**.
7.  Record the generated token. You'll need it in the next step.
8.  From the Git Bash prompt, change the current directory to the projects folder. Next, clone the newly created GitHub repository by typing `git clone`, pasting the clone URL you copied into Clipboard in the previous step, and entering the PAT string followed by the `@` symbol in front of `github.com`.
    
    ```azurecli
    cd ~/projects
    # Clone config repo.
    git clone https://<token>@github.com/<your-github-username>/spring-petclinic-microservices-config.git
    
    # Clone source code repo
    git clone https://<token>@github.com/<your-github-username>/spring-petclinic-microservices.git
    ```
    
    > [!NOTE]
    > Make sure to replace the `<token>` and `<your-github-username>` placeholders in the URL listed with the value of the GitHub PAT and your GitHub user name when running the `git clone` command.
9.  From the Git Bash prompt, change the current directory to the newly created spring-petclinic-microservices-config folder. Run commands to copy the config server configuration files from the lab starter branch of the [spring-petclinic-microservices-config repo](https://github.com/Azure-Samples/spring-petclinic-microservices-config/tree/labstarter) to your lab computer.
    
    The commands should resemble:
    
    ```azurecli
    cd spring-petclinic-microservices-config
    curl -o admin-server.yml https://raw.githubusercontent.com/Azure-Samples/spring-petclinic-microservices-config/labstarter/admin-server.yml
    curl -o api-gateway.yml https://raw.githubusercontent.com/Azure-Samples/spring-petclinic-microservices-config/labstarter/api-gateway.yml
    curl -o application.yml https://raw.githubusercontent.com/Azure-Samples/spring-petclinic-microservices-config/labstarter/application.yml
    curl -o customers-service.yml https://raw.githubusercontent.com/Azure-Samples/spring-petclinic-microservices-config/labstarter/customers-service.yml
    curl -o discovery-server.yml https://raw.githubusercontent.com/Azure-Samples/spring-petclinic-microservices-config/labstarter/discovery-server.yml
    curl -o tracing-server.yml https://raw.githubusercontent.com/Azure-Samples/spring-petclinic-microservices-config/labstarter/tracing-server.yml
    curl -o vets-service.yml https://raw.githubusercontent.com/Azure-Samples/spring-petclinic-microservices-config/labstarter/vets-service.yml
    curl -o visits-service.yml https://raw.githubusercontent.com/Azure-Samples/spring-petclinic-microservices-config/labstarter/visits-service.yml
    ```
10. From the Git Bash window, run the following commands to clone the [Spring Petclinic](https://github.com/spring-petclinic/spring-petclinic-microservices) application to your workstation:
    
    ```Bash
    git add .
    git commit -m 'added base config'
    git push
    ```

11. In your web browser, refresh the page of the newly created spring-petclinic-microservices-config repository and double check that all the configuration files are there.

Once you completed the initial update of your git repository hosting the server configuration, you need to set up the config server for your Spring Apps instance. As part of the setup process, you need to create a Personal Access Token (PAT) in your GitHub repo and make it available to the config server.

### Set up the config server for Azure Spring Apps

Once you completed the initial update of your git repository hosting the server configuration, you need to set up the config server for your Azure Spring Apps instance.

1.  From the Git Bash prompt, set the environment variables hosting your GitHub repository and GitHub credentials. Replace the `<git-repository>`, `<git-username>`, and `<git-PAT>` placeholders with your GitHub repository, name of your GitHub account, and the newly generated PAT value).

    > [!NOTE]
    > The URL of the GitHub repository should be in the format https://github.com/&lt;your-github-username&gt;/spring-petclinic-microservices-config.git, where the &lt;your-github-username&gt; placeholder represents your GitHub user name.

```azurecli
GIT_REPO=<git-repository>
GIT_USERNAME=<git-username>
GIT_PASSWORD=<git-PAT>
```

2.  To set up the config server such that it points to your GitHub repository, from the Git Bash prompt, run the following command.
    
    ```azurecli
    az spring config-server git set \
    --name $SPRING_APPS_SERVICE \
    --resource-group $RESOURCE_GROUP \
    --uri $GIT_REPO \
    --label main \
    --password $GIT_PASSWORD \
    --username $GIT_USERNAME
    ```
    
    > [!NOTE]
    > Note: In case you're using a branch other than main in your config repo, you can change the branch name with the label parameter.
    
    > [!NOTE]
    > Note: Wait for the operation to complete, about 2 minutes.
