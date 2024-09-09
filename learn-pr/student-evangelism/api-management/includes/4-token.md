Imagine you get a sudden spike in traffic towards your API, maybe there's a sale or some other reason. To avoid over consumption and possible service disruption, you need to figure out how to manage that.

## Azure OpenAI Token Limit policy

As mentioned in the beginning of this unit, sudden spike is something, you need to handle. The good news is that Azure API Management has something called Token Limit Policy.

This policy allows customers to set limits on token consumption, expressed in tokens-per-minute (TPM) and ensures fair and efficient utilization of OpenAI resources.

### Key features

The key features of this policy are:

- **Precise Control**: Customers can assign token-based limits on various counter keys, such as Subscription key or IP Address, tailoring the enforcement to specific use cases.
- **Real-Time Monitoring**: The policy relies on token usage metrics returned from the OpenAI endpoint, allowing for accurate monitoring and enforcement of limits in real-time.
- **Pre-Calculation of Tokens**: It enables precalculation of prompt tokens on the Azure API Management side, minimizing unnecessary requests to the OpenAI backend if the limit is already exceeded.
- **Enhanced Customization**: Customers can apply headers and variables such as tokens-consumed and remaining-tokens within policies for better control and customization.

Ss you can see, there's quite a few features that help you manage costs and thanks to the real-time monitoring you can make sure that you're not exceeding the limits.

### How to use it

To use this policy, you need to add it to the inbound processing pipeline of the API operation. Here's how you can do it:

```xml
<azure-openai-token-limit counter-key="key value"
        tokens-per-minute="number"
        estimate-prompt-tokens="true | false"    
        retry-after-header-name="custom header name, replaces default 'Retry-After'" 
        retry-after-variable-name="policy expression variable name"
        remaining-tokens-header-name="header name"  
        remaining-tokens-variable-name="policy expression variable name"
        tokens-consumed-header-name="header name"
        tokens-consumed-variable-name="policy expression variable name" />
```

There's quite a few attributes you can set, but the most important ones are:

- **counter-key**: The key to use for counting tokens. This value can be a subscription key or an IP address.
- **tokens-per-minute**: The number of tokens allowed per minute.
- **estimate-prompt-tokens**: Whether to estimate prompt tokens or not.

## Azure OpenAI Emit Token Metric Policy

This policy addresses the need for *detailed monitoring* and *analysis of token usage* in applications using Azure OpenAI models. 

By providing comprehensive metrics, it helps organizations:

- **Optimize Resource Allocation**: Understand and manage token consumption effectively.
- **Improve Decision-Making**: Gain insights into usage patterns to make informed decisions about scaling and resource management.
- **Enhance Performance Monitoring**: Track and analyze token usage to identify and address potential issues proactively

### How to use Emit Token Metric Policy

To use this policy, you need to add it to the inbound processing pipeline of the API operation. Here's how you encode it in XML:

```xml
<azure-openai-emit-token-metric
        namespace="metric namespace" >      
        <dimension name="dimension name" value="dimension value" />
        ...additional dimensions...
</azure-openai-emit-token-metric>
```

Here's an example using several dimensions:

```xml
<policies>
  <inbound>
      <azure-openai-emit-token-metric
            namespace="AzureOpenAI">   
            <dimension name="User ID" />
            <dimension name="Client IP" value="@(context.Request.IpAddress)" />
            <dimension name="API ID" />
        </azure-openai-emit-token-metric> 
  </inbound>
  <outbound>
  </outbound>
</policies>
```

In the preceding example:

- the policy is configured to emit token metrics to the AzureOpenAI namespace with dimensions for User ID, Client IP, and API ID. 
- The value of the Client IP dimension is set to the IP address of the client making the request.

Imagine now that you can show these metrics in a dashboard and you can monitor the usage of your API in real time. For example, you can see how many tokens are being used by a specific user or how many tokens are being used by a specific API. This powerful feature that can help you optimize your resources and make informed decisions about scaling and resource management.
