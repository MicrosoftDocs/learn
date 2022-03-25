Use Ask Genie to find relevant diagnostics for your problem. Recall the ‘Cheesecake’ App example, we identified that a crash event occurred on the app. To narrow down the potential causes, use Ask Genie to help pinpoint areas of investigation. Here you will learn how to use Ask Genie to find relevant diagnostics for your problem.

## Use Ask Genie to troubleshoot issues

Ask Genie is a feature within App Service Diagnostics that allows you to describe the problem of your app in your own words. Ask Genie processes your verbatim and finds the most relevant set of diagnostics in the system paired with documentation from reliable sources in the web. 

You can access Ask Genie anywhere within App Service Diagnostics. Simply select Ask Genie located in the top command bar. Then, describe the problem you are experiencing. In this scenario, use the search verbatim, “insecure message in browser.” Upon searching for the verbatim, you will notice that diagnostics are being fetched from the system. Also, you will notice some documentation search results from the web related to the issues you reported. Once the diagnostics is ready, you will notice there is a warning level insight. Select “View details” to further investigate. Expand the first warning insight. It will call out that the url cheesecake.com does not have a certificate configured against it, causing a warning on the browser advising the user to take caution. To resolve the issue, a certificate from a trusted certificate issuing authority is required. 

 
:::image type="content" source="../media/module-troubleshoot-web-app-down-scenarios-with-app-service-diagnostics-clean-copy-22-04.png" alt-text="<Screenshot of Ask Genie showing an insight pointing out that the app does not have a certificate configured against it.>":::
