You create and publish a module to a private registry. You try to use it in the following Bicep file:

```bicep
module myModule 'br:toycompany.azurecr.io/mymodule' = {
  name: 'myModule'
}
```

You sign in to Azure by using the Azure CLI.
