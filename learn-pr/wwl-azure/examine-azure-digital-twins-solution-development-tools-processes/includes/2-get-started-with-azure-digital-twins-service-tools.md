The Azure Digital Twins service comes equipped with both control plane APIs and data plane APIs for managing your instance and its elements.

 -  The control plane APIs are Azure Resource Manager APIs used to manage your Azure Digital Twins instance as a whole, so they cover operations like creating or deleting your entire instance. You will also use these APIs to create and delete endpoints.
 -  The data plane APIs are Azure Digital Twins APIs that are used for data management operations like managing models, twins, graph queries, and event routes.

You can use the APIs by calling the REST APIs directly (using a tool such as Postman), or you can implement the APIs programmatically either by using the SDKs or through the Azure CLI extension for Azure Digital Twins. You can also implement control plane APIs by opening your Azure Digital Twins resource in the Azure portal.

The Azure Digital Twins SDKs are currently available in the following software languages: .NET (C\#), Java, JavaScript, and Python. You can also generate custom SDKs for other languages.

In addition, the build-from-scratch approach, Microsoft has developed both sample code and sample apps that can be used as a more advanced starting point. And in the case of the sample apps, they could also be used help prototype a solution.

The following table lists some broad solution areas and list some tools that developers might use when completing tasks in these areas.

:::row:::
  :::column:::
    **Azure Digital Twins Solution Stage/Area**
  :::column-end:::
  :::column:::
    **Azure portal**
  :::column-end:::
  :::column:::
    **Azure CLI**
  :::column-end:::
  :::column:::
    SDKs
(VSCode)
  :::column-end:::
  :::column:::
    **DTDL Validator**
  :::column-end:::
  :::column:::
    **Azure Digital Twins-explorer**
  :::column-end:::
  :::column:::
    CSV
(Excel)
  :::column-end:::
  :::column:::
    **Azure Functions**
  :::column-end:::
  :::column:::
    **Postman**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Create/Configure Azure Digital Twins instance
  :::column-end:::
  :::column:::
    X
  :::column-end:::
  :::column:::
    X
  :::column-end:::
  :::column:::
    X
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    X
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Create DTDL Models
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    X
  :::column-end:::
  :::column:::
    X
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Build Graph Environment
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    X
  :::column-end:::
  :::column:::
    X
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    X
  :::column-end:::
  :::column:::
    X
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    X
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Query/Manage Graph Environment
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    X
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    X
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    X
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Manage Data Ingress (upstream)
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    X
  :::column-end:::
  :::column:::
    X
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Manage Data Egress (downstream)
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    X
  :::column-end:::
  :::column:::
    X
  :::column-end:::
:::row-end:::
