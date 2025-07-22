You connect Threat Intelligence Indicators to the Microsoft Sentinel workspace using the Threat Intelligence Content hub solution and the included data connectors.

You're a Security Operations Analyst working at a company that implemented Microsoft Sentinel. Your company has subscriptions to threat intelligence platform services that provide known malicious indicators for use in your detection rules. Threat indicators can include IP addresses, domains, URLs, and file hashes, etc.

You need to configure Microsoft Sentinel to import the indicators of compromise (IoCs) from these services automatically. The first service uses Microsoft Defender Threat Intelligence (MDTI).

The second service uses a TAXII server to allow indicators to be pulled. You configure the TAXII data connector to pull indicators from the service.  

The third service, the upload API doesn't use a Microsoft Sentinel data connector, but allows you to directly input "Structured Threat Information Expression" or STIX data.

Now that the threat intelligence indicator data is flowing into Microsoft Sentinel, the SecOps teams can use the indicators as part of their detection queries.

By the end of this module, you're able to connect Threat Intelligence Indicators to the Microsoft Sentinel workspace using the provided data connectors.

After completing this module, you'll be able to:


- View threat indicators in Microsoft Sentinel

## Prerequisites- Configure the Defender Threat Intelligence connector in Microsoft Sentinel
- Configure the TAXII connector in Microsoft SentinelPlatforms connector
- Configure the Threat Intelligence Upload API in Microsoft Sentinel

General experience with Microsoft Defender and Microsoft Azure services
