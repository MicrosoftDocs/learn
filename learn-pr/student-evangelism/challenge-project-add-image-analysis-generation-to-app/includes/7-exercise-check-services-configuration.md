
As mentioned in previous exercises, if Azure AI services are not configured with authentication parameters (key and endpoint) before running the app, the app backend will not work properly. In this exercise you will:

- add a check to ensure that the app is properly configured before running it.
- add a warning message to the UI to inform the user that the app is not configured properly.

## Specification

In the js modules you created to handle Azure AI services calls ('azure-image-generation' and 'azure-image-analysis'), add a function 'isConfigured' checking that the appropriate environment variables are set for the AI service.
Then, import the two functions in your 'App.js' and call them before rendering the GUI. If either one of the two functions return false - meaning that one of the two Azure AI services is not correctly configured - display a warning message in the GUI, informing the user that the app is not configured properly. Otherwise render the GUI as usual.

## Check your work

To validate your work, remove the environment variables you set in the previous exercises for the Azure AI services from your environment and run your React app locally (using 'npm start' command). You should see a warning message like the one below:
![Warning message](../media/warning_message.png)
