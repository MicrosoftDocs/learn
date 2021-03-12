Your company wanted to learn how they could use their existing expertise in Maven to automate deployment of their Java web apps to Azure App Service. To test how easy it would be for your company to use the Maven Plugin for Azure App Service, you used the following steps:

1. You created a sample web app with a Maven archetype, and you tested it locally using Tomcat.

1. Once you verified that your application was working successfully, you added the Maven Plugin for Azure App Service to your project and configured it interactively.

1. After you configured the Maven Plugin for Azure App Service, you deployed your web app to Azure App Service and tested it in the cloud.

1. You updated your web app, redeployed it to Azure App Service, and tested it in the cloud.

1. You learned about the various methods that you can use to authenticate your deployments for automation.

The whole process would be difficult to achieve without the Maven Plugin for Azure App Service. You would have had to manually create an App Service plan, and manually configure Maven to transfer your application over FTP to Azure App Service.

Now that you've learned how to use the Maven Plugin for Azure App Service, you're confident that you can recommend migrating your Java application code to Azure. You know your team can continue using Maven to manage projects and deploy them to Azure.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Learn more

The following links discuss additional information related to Java development on Azure:

- [Azure for Java cloud developers](https://docs.microsoft.com/azure/java)
- [Install the JDK for Azure and Azure Stack](https://docs.microsoft.com/azure/java/jdk/java-jdk-install)
- [Tomcat project page](https://tomcat.apache.org/maven-plugin-2.2)
- [Create an Azure service principal with Azure CLI](https://docs.microsoft.com/cli/azure/create-an-azure-service-principal-azure-cli?view=azure-cli-latest)
- [Automation with service principals](https://docs.microsoft.com/azure/analysis-services/analysis-services-service-principal)
- [az ad sp create-for-rbac](https://docs.microsoft.com/cli/azure/ad/sp#az-ad-sp-create-for-rbac)

These additional links provide a wealth of information about getting started with Apache Maven:

- [Maven Getting Started Guide](https://maven.apache.org/guides/getting-started/)
- [Introduction to the Build Lifecycle](https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html)
- [Maven Plugin for Azure App Service](https://github.com/Microsoft/azure-maven-plugins/blob/develop/azure-webapp-maven-plugin/README.md)
- [Maven Central Repository listing for the Azure App Service Plugin](https://search.maven.org/artifact/com.microsoft.azure/azure-webapp-maven-plugin)
- [Maven POM Reference](https://maven.apache.org/pom.html)
