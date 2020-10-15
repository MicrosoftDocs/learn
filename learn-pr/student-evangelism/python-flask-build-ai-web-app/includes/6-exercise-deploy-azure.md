Azure App Service is a set of services provided by Microsoft Azure to enable developers to easily build and deploy web apps. Included in the App Service family is the Web Apps feature, which you can use to quickly and easily deploy websites built with tools and languages you're already familiar with.

Web Apps makes deploying websites easy, and not just websites built by using the Microsoft stack. You can deploy Python apps that use MySQL as easily as ASP.NET apps that use SQL Server. You can select from a wide variety of web app templates or build templates of your own. You can configure web apps to autoscale as traffic increases, to ensure that your customers aren't left waiting during periods of peak demand. You can publish apps to staging locations and test them in the cloud before taking them live, and then swap staging and production with the click of a button. You can even create WebJobs programs or scripts that run continuously or on a schedule to handle billing and other time-critical tasks. 

In short, Web Apps takes the pain out of publishing and maintaining web apps. Web Apps is as suitable for a personal photo-sharing site as it is for enterprise-grade sites that serve millions of customers.

In this unit, you deploy Contoso Travel to Azure as an Azure web app so it can be accessed by anyone, from anywhere, through a browser. And you learn about App Service application settings, which allow API keys and other "secrets" used by an application to be stored securely in the cloud.

Resources that are used in this exercise are located in a [Git repository for code samples](https://github.com/MicrosoftDocs/mslearn-build-ai-web-app-with-python-and-flask?azure-portal=true).


### Reactivate your virtual environment

> Only complete the steps in this section if you closed the Command Prompt window or terminal where you were running your Python virtual environment. Otherwise, continue to the next section, "Create an Azure App Service instance."

If you closed your Command Prompt window or terminal, you need to configure a new window or terminal to use your existing Python virtual environment. The environment variables also need to be recreated.

1. Open a new Command Prompt window or terminal. Change (`cd`) to your project directory. For details, see the section "Create the project directory" in the [Exercise - Set up a development environment](../1-exercise-set-up-environment?azure-portal=true) unit. <!-- #create-the-project-directory -->

1. Reactivate your Python virtual environment. For details, see the section "Activate your virtual environment" in the [Exercise - Set up a development environment](../1-exercise-set-up-environment?azure-portal=true) unit. <!-- #activate-your-virtual-environment -->
 
1. Reset the **FLASK_ENV** environment variable. For details, see the section "Set the Flask environment variable" in the [Exercise - Build a page for uploading photos](../3-exercise-upload-photos?azure-portal=true) unit. <!-- #set-the-flask-environment-variable -->

1. Reset the **VISION_KEY** and **VISION_ENDPOINT** environment variables. For details, see the section "Set Computer Vision environment variables" in the [Exercise - Use Cognitive Services to extract text from photos](../4-exercise-extract-text?azure-portal=true) unit. <!-- #set-computer-vision-environment-variables -->

1. Reset the **TRANSLATE_KEY** environment variable. For details, see the section "Set the Translation environment variable" in the [Exercise - Use Cognitive Services to translate text](../5-exercise-translate-text?azure-portal=true) unit. <!-- #set-the-translation-environment-variable -->


## Create an Azure App Service instance

In this exercise, you use the Azure CLI to deploy your website to Azure.

1. In your project directory, create a text file named **requirements.txt** and add the following statements:

    ```console
    requests
    Flask
    azure-cognitiveservices-vision-computervision
    ```

    The **requirements.txt** file contains a list of Python packages that must be installed along with the app when the app is deployed to Azure.

1. Return to your Command Prompt window or terminal, and make sure the current directory is still set to **mslearn-build-ai-web-app-with-python-and-flask/src/starter** in your project directory.

1. Run the following command to deploy the website to Azure. Replace `APP_NAME` with the name that you want to assign to the site. The name must be *unique with Azure*, so you probably won't be able to use a common name such as "contoso" or "contosotravel" unless you append some random characters to the end.

    ```console
    az webapp up -n APP_NAME --resource-group contoso-travel-rg --location northcentralus
    ```

    > If you receive an error when you run this command, see the "Troubleshoot the az webapp command" section for troubleshooting tips.

    The `az webapp up` command creates an Azure App Service instance to host your website, configures the App Service instance with the packages specified in the **requirements.txt** file, zips the files in the current directory and its subdirectories, and uploads the site to App Service—all with one simple command. Sites that run on Node.js and Python are deployed to App Service for Linux, while sites built on ASP.NET and ASP.NET Core run in App Service for Windows.

    Notice that you deployed the App Service instance in the same region (North Central US) as the Computer Vision API. This deployment method makes calls to the API faster by colocating the website and the API that it uses in the same Azure region.

The command can take a few minutes to complete. Review the output to confirm your website was successfully deployed.


### Troubleshoot the az webapp command

If you get an error such as "Could not autodetect the runtime stack of your app," check your configuration and command execution steps.

- Check the location of the **requirements.txt** file. This file must be located in the root folder of your project directory. If your project directory is C:\Users\User1\ContosoTravel, then the path to the requirements.txt file is C:\Users\User1\ContosoTravel\requirements.text.

- Make sure you're in the correct directory when you run the command. In your Command Prompt window or terminal, you should be in the directory where the code files for your project are stored. If your project directory is C:\Users\User1\ContosoTravel, then the code files are stored in the C:\Users\User1\ContosoTravel\mslearn-build-ai-web-app-with-python-and-flask\src\starter folder. Your directory location should be this **starter** folder.

For more suggestions, see the troubleshooting information that's posted at https://go.microsoft.com/fwlink/?linkid=2109470 after you run the command.


## Add application settings

When you ran the website locally, it used the `os.environ` command to load API keys for the Computer Vision API and the Translator Text API and the URL of the Computer Vision API from local environment variables. For the website to run in Azure, these same settings need to be added to the application settings in Azure App Service. In the steps that follow, you use the Azure CLI to create these application settings in Azure and initialize them with the same values used when you loaded them into local environment variables.

1. Return to your Command Prompt window or terminal. Run the following Azure CLI command to create an application setting named "VISION_KEY." Replace `APP_NAME` with the name assigned to your App Service instance and `<computer_vision_api_key>` with your Computer Vision API key.

    ```console
    az webapp config appsettings set -g contoso-travel-rg -n APP_NAME --settings VISION_KEY=<computer_vision_api_key>
    ```

1. Now use the following command to create an application setting named "VISION_ENDPOINT." Replace `<computer_vision_endpoint>` with your Computer Vision API endpoint.

    ```console
    az webapp config appsettings set -g contoso-travel-rg -n APP_NAME --settings VISION_ENDPOINT=<computer_vision_endpoint>
    ```

1. Finish by using the following command to load your Translator Text API key into application settings. Replace `<translator_text_api_key>` with your key.

    ```console
    az webapp config appsettings set -g contoso-travel-rg -n APP_NAME --settings TRANSLATE_KEY=<translator_text_api_key>
    ```

You can sign in to the Azure portal, open the Azure App Service instance created by the `az webapp up` command, and view the application settings that these commands created. The following screenshot shows what you see after you run the command in the Azure portal:

![Screenshot that shows how to view application settings in the Azure portal.](../media/app-settings.png#lightbox)

_View application settings in the Azure portal_


## Run the site in Azure

Now it's time to see the results of your work.

1. Point your browser to `http://APP_NAME.azurewebsites.net`, and replace `APP_NAME` with the name of your App Service instance. Confirm that the site appears in your browser and that it looks exactly as it did when running locally.

    ![Screenshot that shows the Contoso Travel web site running in Azure.](../media/azure-site.png)

    _Contoso Travel running in Azure_

1. Choose a language and upload a few photos that contain signs with text that you want to translate. Does the site behave the same in Azure as it does when running locally?

If you later make changes to your site and want to update the App Service instance in Azure, run the `az webapp up` command again. Rather than create a new App Service instance, it will zip-deploy the files in the current directory to the existing App Service instance. If you prefer to put the source-code files under source control and deploy them directly from Visual Studio Code, follow the instructions in [Deploy to Azure App Service on Linux](https://code.visualstudio.com/docs/python/tutorial-deploy-app-service-on-linux?azure-portal=true).
