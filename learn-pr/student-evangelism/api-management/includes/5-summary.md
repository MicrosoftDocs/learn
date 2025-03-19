In this module, we've covered how you can use Azure OpenAI together with Azure API Management. By combining these services, you're able to manage and secure access to your AI models.

First, we discussed the problem of load balancing and how Azure API Management can help you manage traffic and ensure the load is distributed evenly across your backends. We also looked into circuit breakers and how they can help steer traffic away from unhealthy backends.

Next, we discussed token-based rate limiting and how you can use it to control access to your APIs. An important learning was to avoid over-consumption and so called "noisy neighbors" by setting limits on token consumption.

Finally, we discussed how you can monitor and analyze token usage patterns using the Azure OpenAI Emit Token Metric Policy. By providing comprehensive metrics, you can optimize resource allocation, improve decision-making, and enhance performance monitoring.

## Next steps

Here's our recommended next steps:

- [APIM + Azure OpenAI sample](https://github.com/Azure-Samples/genai-gateway-apim)
- [Managed identity in APIM](/azure/api-management/api-management-howto-use-managed-service-identity)
- [Token metric policy](/azure/api-management/azure-openai-emit-token-metric-policy)
-[Token limit policy](/azure/api-management/azure-openai-token-limit-policy)
- [APIM Backend](/azure/api-management/backends?tabs=bicep)
- [Azure API Management documentation](/azure/api-management/)
- [Azure OpenAI documentation](/azure/ai-services/openai/overview)
- [Azure API Management pricing](https://azure.microsoft.com/pricing/details/api-management/)

