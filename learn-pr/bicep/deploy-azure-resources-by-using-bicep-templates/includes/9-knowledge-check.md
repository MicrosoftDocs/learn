Consider the following scenario. Then choose the best response for each question that follows, and select **Check your answers**.

The manufacturing department at your toy company needs software to manage their factory. The IT department has built a web-based application for them to use, and they plan to host it on Azure.

The team needs to deploy the application to a test environment before it can be released to production.

The template that the team has developed includes this line:

`param siteName string = 'mysite-${uniqueString(resourceGroup().id)}'`.
