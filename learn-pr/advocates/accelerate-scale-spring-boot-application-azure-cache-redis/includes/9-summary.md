
Congratulations! In this module, you used Azure Cache for Redis to speed up and scale a Spring Boot application. You learned how to use Spring Data Redis and Spring Session to store and retrieve data with Redis, and how to deploy the scalable application to Azure App Service.

## Remove Azure resources

To avoid unwanted charges, remove the Azure resources you created for this module by deleting the resource group that contains them. To delete the resource group, run the following command and respond `y` to the confirmation prompt.

```azurecli
az group delete --name $AZ_RESOURCE_GROUP
```

## More resources

For more advanced topics about Redis and Spring Boot, see the following articles:

- [Redis home page](https://redis.io/)
- [Spring Data Redis](https://spring.io/projects/spring-data-redis)
- [Spring Session](https://spring.io/projects/spring-session)

For more information about the Azure services this module uses, see:

- [Azure Cache for Redis](https://azure.microsoft.com/services/cache)
- [Azure App Service](https://azure.microsoft.com/services/app-service)
