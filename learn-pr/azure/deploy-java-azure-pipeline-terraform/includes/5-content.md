<!-- 
github actions
https://docs.microsoft.com/en-us/azure/spring-cloud/spring-cloud-howto-github-actions?pivots=programming-language-java

https://docs.microsoft.com/en-us/azure/spring-cloud/spring-cloud-howto-cicd?pivots=programming-language-java

https://medium.com/faun/azure-deployments-made-easy-with-terraform-and-github-actions-d459ae5ab7c7

https://github.com/hashicorp/setup-terraform
-->
In this unit, you'll learn about GitHub actions and how to provision your Terraform resources using CI/CD

# GitHub actions

## Setting up secrets

In GitHub, we can specify them once we go to Settings -> Secrets.

## Service principal

<!--
az ad sp create-for-rbac --name "yourServicePrincipalName" --role contributor --scopes /subscriptions/your-subscription-id --sdk-auth
-->
