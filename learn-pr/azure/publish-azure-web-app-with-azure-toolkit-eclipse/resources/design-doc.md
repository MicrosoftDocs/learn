# Design Document

- **Requestor**: robmcm@microsoft.com 
- **Subject matter expert**: andxu@microsoft.com
- **Product team contact**: yucwan@microsoft.com

## Title

Publish a web app to Azure by using Azure Toolkit for Eclipse

## Role(s)

- Developer

## Level

- Beginner

## Product(s)

- [Azure Web Apps](https://azure.microsoft.com/services/app-service/web/)
- [Azure Toolkit for Eclipse](https://docs.microsoft.com/java/azure/eclipse/azure-toolkit-for-eclipse)

## Prerequisites

- [Eclipse IDE](https://www.eclipse.org/ide/)

## Summary

Create a web app in Eclipse and deploy the app to Azure by using Azure Toolkit for Eclipse.

## Learning objectives

1. Create a web app in Eclipse
1. Deploy the app to Azure by using Azure Toolkit for Eclipse
1. Manage deploy configurations using Azure Toolkit

## Chunk your content into subtasks

Identify the subtasks of *Publish a web app to Azure by using Azure Toolkit for Eclipse*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---|---|---|---|---|
| Create a web app in Eclipse | Create a web app in Eclipse | Exercise | Create a web app in Eclipse | Yes |
| Deploy the app to Azure by using Azure Toolkit for Eclipse | Deploy the app to Azure by using Azure Toolkit for Eclipse | Exercise | Deploy the app to Azure by using Azure Toolkit for Eclipse | Yes |
| Manage deploy configurations using Azure Toolkit | Manage deploy configurations using Azure Toolkit | Exercise | Manage deploy configurations using Azure Toolkit | Yes |

## Outline the units

1. **Introduction**

    You're been hired as a new developer for a company that uses Eclipse for its development environment. Your company has used an on-premises web server in the past, but they would like to move their website to Azure Web Apps to reduce their costs. With that in mind, your development lead has tasked you with researching the steps that are necessary to publish web apps to Azure while preserving their existing development environment as much as possible.

1. **Build a web application and test**

    List the content that will enable the learner to *build a web*:

    - Building a simple hello world web application
    - Testing the deployed application through a browser.

1. **Exercise - Build a web app**

   List the steps which apply the learning content from previous unit:

      1. Create a new Web App Project and deploy
         1. Create a new dynamic web project using a jsp and a html template.
            1. add html code to the template.
            1. Test the application locally.

1. **Deploy a web application and test**

    List the content that will enable the learner to *build a web*:

    - Connect to you Azure instance through Azure toolkit in Eclipse.
    - Deploy the application through the Azure toolkit.
    - Testing the deployed application through a browser.

1. **Exercise - Deploy a web app to Azure**

   List the steps which apply the learning content from previous unit:

    1. Deploy the web app to Azure
       1. Deploy the Web app to azure
       1. Sign into you Azure account through eclipse
       1. Select the subscription
       1. Publish the app as an Azure Web App
       1. Create and configure a new web app in Azure
       1. Deploy your app as an Azure web app
    1. Test your web application in a browser.

1. **Managing app deployments from Eclipse using Azure toolkit**

    List the content that will enable the learner to *Managing the deployment of applications in Azure through the eclipse toolkit*:

    - Manage your azure web application through the Eclipse toolkit
        - Overview of Azure Explorer
        - Controlling your web app:
          - starting, stopping, restarting, and deleting.
        - Deploying your app to different service plans

1. **Exercise - Manage your web apps through the Eclipse Azure toolkit**

    List the steps which apply the learning content from previous unit:

    1. Change your web application in a small way.
       1. Add extra content to the html wrapper.
    1. Redeploy the changed app and verify the changes are present.
    1. Use Azure Explorer to restart the application, and verify.
    1. Use Azure Explorer to stop the application, and verify it is no longer running.
    1. Use Azure Explorer to start the application, verify it is running again.

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    - You've built and deployed a web to Azure using the Azure Toolkit
    - You've managed the deployed web app though the Azure Toolkit without having to use or have any knowledge of how Azure works.

## Notes

Why would a customer use the technology; that is, what type of problem does it solve?

- Meet Java customers where they are at their favorite IDEs: Eclipse (around 40% Java IDE market share).
- Use familiar IDE environment engage with Azure will help them get started with and developing Azure App Service without a steep learning curve.
- Deploy web app to Azure App Service without efforts to learn Azure specific technologies like Azure CLI or adopting Visual Studio and VS Code.

**Useful links**

- Eclipse IDE : https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2019-06/R/eclipse-inst-win64.exe
- Create a web app in eclipse IDE : https://docs.microsoft.com/java/azure/eclipse/azure-toolkit-for-eclipse-create-hello-world-web-app?view=azure-java-stable
- Azure toolkit for eclipse : https://docs.microsoft.com/java/azure/eclipse/azure-toolkit-for-eclipse?view=azure-java-stable
- Deploying java web apps to azure using eclipse: https://azure.microsoft.com/blog/deploy-java-web-apps-to-azure-using-eclipse/
- Install the JDK for Azure and Azure stack: https://docs.microsoft.com/java/azure/jdk/java-jdk-install?view=azure-java-stable
- Java for Azure and Azure Stack: https://www.azul.com/downloads/azure-only/zulu/
