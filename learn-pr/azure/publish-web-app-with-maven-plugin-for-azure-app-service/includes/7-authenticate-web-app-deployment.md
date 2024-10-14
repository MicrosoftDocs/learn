To complete the exercises in this module, you've been logged into the sandbox environment. Because this environment is interactive, all of your deployments have been authenticated using the credentials that you used when you initialized the sandbox. However, your deployments won't use this interactive environment if you're automating your build process. In an automation scenario, you'll need to configure your project to use one of the supported authentication methods.

In this unit, you'll learn how your company can configure Maven to use Azure authentication.

## Authenticating your web app

Azure gives you the flexibility to decide how you want to authenticate your app. The option you choose depends on your company's build environment. The three options to authenticate your application code with Maven are listed here, in order of complexity (from least to most):

- Authenticate using the Azure CLI or use the Cloud Shell on the Azure portal.

- Create an Azure service principal, create a JSON file with your service principal credentials, and modify your project's `pom.xml` file.

- Create an Azure service principal, add your service principal credentials to a Maven `settings.xml` file, and modify your project's `pom.xml` file to use the Maven settings.

Microsoft recommends the third option, as it provides the most reliable, flexible, and consistent approach to authentication. In a real-world setting, your company's existing Java web apps might be running on local servers that don't have the Azure CLI tools installed. With that in mind, you'd probably implement the recommendation to add authentication using a service principal and a Maven `settings.xml` file. However, for this exercise, the sandbox doesn't have sufficient privileges to create service principals.

### Authentication with the Azure CLI

The easiest way to authenticate Maven is to sign in with the Azure CLI. The Maven Plugin for Azure App Service can then deploy the app using your credentials, with no extra configuration required.

If you're using the Azure Cloud Shell, as you've been when completing the exercises with the Microsoft Learn Sandbox in this module, then you're logged in to Azure by default; you don't need to run any more commands. However, if you're using the Azure CLI from a separate computer, then you'll need to sign in by using the `az login` command.

### Authentication with a service principal

The second method for authenticating your web app involves creating an Azure service principal and saving your service principal credentials to a file that you'll reference from your project settings.

To create an Azure service principal with the Azure CLI, use the following steps.

1. Run the following command from the Azure CLI to create an Azure service principal:

    ```azurecli
    az ad sp create-for-rbac --name https://mywebapp-1234567890.azurewebsites.net/ --role Contributor --scopes /subscriptions/ssssssss-ssss-ssss-ssss-ssssssssssss
    ```

    Where `https://mywebapp-1234567890.azurewebsites.net/` is the URL of your web app.

    This command returns a response with a JSON object that resembles the following example:

    ```json
    Creating 'Contributor' role assignment under scope '/subscriptions/ssssssss-ssss-ssss-ssss-ssssssssssss'
    The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli

    {
      "appId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
      "displayName": "mywebapp-1234567890.azurewebsites.net/",
      "name": "https://mywebapp-1234567890.azurewebsites.net/",
      "password": "...",
      "tenant": "tttttttt-tttt-tttt-tttt-tttttttttttt"
    }
    ```

1. Modify your web app's `pom.xml` file to use the information in the JSON output.

    1. Open your `pom.xml` file with the code editor:

        ```bash
        cd ~/MyWebApp
        code pom.xml
        ```

    1. Locate the `<configuration>` section for the `azure-webapp-maven-plugin`.

    1. Add the following XML after the line containing the `<region>` element and use the information in the JSON output:

        ```xml
        <auth>
            <type>service_principal</type>
            <client>value-of-appId</client>
            <tenant>value-of-tenant</tenant>
            <key>value-of-password</key>
            <environment>azure</environment>
        </auth>
        ```

        Your `azure-webapp-maven-plugin` section should now resemble the following example:

        ```xml
        <plugin>
            <groupId>com.microsoft.azure</groupId>
            <artifactId>azure-webapp-maven-plugin</artifactId>
            <version>2.13.0</version>
            <configuration>
                <schemaVersion>v2</schemaVersion>
                <resourceGroup>MyWebApp-1714654093047-rg</resourceGroup>
                <appName>MyWebApp-1714654093047</appName>
                <pricingTier>S1</pricingTier>
                <region>centralus</region>
                <auth>
                    <type>service_principal</type>
                    <client>aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa</client>
                    <tenant>tttttttt-tttt-tttt-tttt-tttttttttttt</tenant>
                    <key>abcdefghijklmnopqrstuvwxyz1234567890</key>
                    <environment>azure</environment>
                </auth>
                <runtime>
                    <os>Linux</os>
                    <javaVersion>Java 17</javaVersion>
                    <webContainer>Tomcat 10.0</webContainer>
                </runtime>
                <deployment>
                    <resources>
                        <resource>
                            <directory>${project.basedir}/target</directory>
                            <includes>
                                <include>*.war</include>
                            </includes>
                        </resource>
                    </resources>
                </deployment>
            </configuration>
        </plugin>

        ```

    1. Save your changes by typing <kbd>Ctrl</kbd>+<kbd>S</kbd>.

    1. Quit the code editor by typing <kbd>Ctrl</kbd>+<kbd>Q</kbd>.

1. Use Maven to build and deploy your web app to Azure App Service:

    ```bash
    mvn azure-webapp:deploy
    ```

    Maven displays a series of build messages, and the final message should indicate successful deployment to Azure:

    ```console
    [INFO] Scanning for projects...
    [INFO] 
    [INFO] -------------------< com.microsoft.example:MyWebApp >-------------------
    [INFO] Building MyWebApp Maven Webapp 1.0-SNAPSHOT
    [INFO] --------------------------------[ war ]---------------------------------
    [INFO] 
    [INFO] --- azure-webapp-maven-plugin:2.13.0:deploy (default-cli) @ MyWebApp ---
    [INFO] Auth type: SERVICE_PRINCIPAL
    [INFO] Username: 74d82376-184f-400e-a08e-27cd522d7559
    [INFO] There is only one subscription '...' in your account, will use it automatically.
    [INFO] Subscription: ...
    [INFO] Failed to get version of your artifact, skip artifact compatibility test
    [INFO] Trying to deploy external resources to MyWebApp-1714654093047...
    [INFO] Successfully deployed the resources to MyWebApp-1714654093047
    [INFO] Trying to deploy artifact to MyWebApp-1714654093047...
    [INFO] Deploying (/home/cephas/MyWebApp/target/MyWebApp.war)[war]  ...
    [INFO] Application url: https://mywebapp-1714654093047.azurewebsites.net                            
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  47.052 s
    [INFO] Finished at: 2024-05-02T13:10:54Z
    [INFO] ------------------------------------------------------------------------
    ```

    The `Auth type: SERVICE_PRINCIPAL` line in the response indicates that the service principal was used to publish your web app to Azure.

### Authentication with a Maven `settings.xml` file

The third method for authenticating your web app involves creating an Azure service principal, creating a Maven `settings.xml` file that contains your service principal credentials, and modifying your project's `pom.xml` file to use the Maven settings.

The steps to create an Azure service principal with the Azure CLI are the same as in the preceding section of this unit.

1. Run the following command from the Azure CLI to create an Azure service principal:

    ```azurecli
    az ad sp create-for-rbac --name https://mywebapp-1234567890.azurewebsites.net/ --role Contributor --scopes /subscriptions/ssssssss-ssss-ssss-ssss-ssssssssssss
    ```

    Where `https://mywebapp-1234567890.azurewebsites.net/` is the URL of your web app.

    This command returns a response with a JSON object that resembles the following example:

    ```json
    Creating 'Contributor' role assignment under scope '/subscriptions/ssssssss-ssss-ssss-ssss-ssssssssssss'
    The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli

    {
      "appId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
      "displayName": "mywebapp-1234567890.azurewebsites.net/",
      "name": "https://mywebapp-1234567890.azurewebsites.net/",
      "password": "...",
      "tenant": "tttttttt-tttt-tttt-tttt-tttttttttttt"
    }
    ```

1. Create a user version of the `settings.xml` file for Maven to use.

    1. Create a new XML file for your Maven settings with the code editor:

        ```bash
        code ~/.m2/settings.xml
        ```
    
    1. Paste the following XML into the file:

        ```xml
        <settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
          <servers>
            <server>
               <id>azure-auth</id>
               <configuration>
                   <client>aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa</client>
                   <tenant>tttttttt-tttt-tttt-tttt-tttttttttttt</tenant>
                   <key>pppppppp-pppp-pppp-pppp-pppppppppppp</key>
               </configuration>
            </server>
          </servers>
        </settings>
        ```

        Where:

        | Parameter | Description |
        |---|---|
        | `client` | Specifies the service principal's `appId` value |
        | `key` | Specifies the service principal's `password` value |
        | `tenant` | Specifies the service principal's `tenant` value |

    1. Save your changes by typing <kbd>Ctrl</kbd>+<kbd>S</kbd>.

    1. Quit the code editor by typing <kbd>Ctrl</kbd>+<kbd>Q</kbd>.

1. Modify your web app's `pom.xml` file to reference the authentication file.

    1. Open your `pom.xml` file with the code editor:

        ```bash
        cd ~/MyWebApp
        code pom.xml
        ```

    1. Locate the `<configuration>` section for the `azure-webapp-maven-plugin`.

    1. Add the following XML after the line containing the `<region>` element:

        ```xml
        <auth>
          <type>service_principal</type>
          <serverId>azure-auth</serverId>
        </auth>
        ```

        Your `azure-webapp-maven-plugin` section should now resemble the following example:

        ```xml
        <plugin> 
          <groupId>com.microsoft.azure</groupId>  
          <artifactId>azure-webapp-maven-plugin</artifactId>  
          <version>2.13.0</version>  
          <configuration> 
            <schemaVersion>V2</schemaVersion>  
            <resourceGroup>maven-publish</resourceGroup>  
            <appName>MyWebApp-1234567890</appName>  
            <pricingTier>S1</pricingTier>  
            <region>centralus</region>
            <auth>
              <type>service_principal</type>
              <serverId>azure-auth</serverId>
            </auth>
            <runtime>
                <os>Linux</os>
                <javaVersion>Java 17</javaVersion>
                <webContainer>Tomcat 10.0</webContainer>
            </runtime>
            <deployment> 
              <resources> 
                <resource> 
                  <directory>${project.basedir}/target</directory>  
                  <includes> 
                    <include>*.war</include> 
                  </includes> 
                </resource> 
              </resources> 
            </deployment> 
          </configuration> 
        </plugin> 
        ```

    1. Save your changes by typing <kbd>Ctrl</kbd>+<kbd>S</kbd>.

    1. Quit the code editor by typing <kbd>Ctrl</kbd>+<kbd>Q</kbd>.

1. Use Maven to build and deploy your web app to Azure App Service:

    ```bash
    mvn azure-webapp:deploy
    ```

    Maven displays a series of build messages, and the final message should indicate successful deployment to Azure:

    ```console
    [INFO] -------------------< com.microsoft.example:MyWebApp >-------------------
    [INFO] Building MyWebApp Maven Webapp 1.0-SNAPSHOT
    [INFO] --------------------------------[ war ]---------------------------------
    [INFO] 
    [INFO] --- azure-webapp-maven-plugin:2.13.0:deploy (default-cli) @ MyWebApp ---
    [INFO] Auth type: SERVICE_PRINCIPAL
    [INFO] Username: aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa
    [INFO] There is only one subscription '...' in your account, will use it automatically.
    [INFO] Subscription: ...
    [INFO] Failed to get version of your artifact, skip artifact compatibility test
    [INFO] Trying to deploy external resources to MyWebApp-1714654093047...
    [INFO] Successfully deployed the resources to MyWebApp-1714654093047
    [INFO] Trying to deploy artifact to MyWebApp-1714654093047...
    [INFO] Deploying (/home/cephas/MyWebApp/target/MyWebApp.war)[war]  ...
    [INFO] Application url: https://mywebapp-1714654093047.azurewebsites.net                            
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  53.611 s
    [INFO] Finished at: 2024-05-02T13:53:31Z
    [INFO] ------------------------------------------------------------------------
    ```

    The `Auth type: SERVICE_PRINCIPAL` line in the response indicates that your service principal credentials were used to publish your web app to Azure.
