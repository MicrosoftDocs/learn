You can deploy Azure Stack Hub using Microsoft Entra ID or Active Directory Federation Services (AD FS) as the identity provider. Make the choice before you deploy Azure Stack Hub. In a connected scenario, you can choose Microsoft Entra ID or AD FS. For a disconnected scenario, only AD FS is supported.

Prior to deployment you will likely want to resolve DNS names for endpoints outside Azure Stack Hub (for example: [www.bing.com](https://www.bing.com/)). Provide DNS servers that Azure Stack Hub can use to forward DNS requests for which Azure Stack Hub isn't authoritative.

In the context of Azure Stack Hub, a public IP address is an IP address that's accessible from outside of Azure Stack Hub. Whether that external network is public internet routable or is on an intranet and uses private address space doesn't matter for the purposes of this unit, the steps are the same.

This module aligns with the exam AZ-600: Configuring and Operating a Hybrid Cloud with Microsoft Azure Stack Hub.

## Learning objectives

After completing this module, you'll be able to:

 -  Recommend a name resolution strategy for Azure Stack Hub.
 -  Recommend a public and internal IP strategy for Azure Stack Hub.
 -  Recommend a data center firewall integration strategy for Azure Stack Hub.
 -  Recommend an identity provider for Azure Stack Hub.
 -  Validate identity provider integration for Azure Stack Hub.
 -  Configure the Time Server (NTP) for Azure Stack Hub.

## Skills measured

 -  Prepare for Azure Stack Hub deployment.

## Prerequisites

 -  Working experience with enterprise networking.
 -  Conceptual knowledge of firewall integration and hybrid connectivity.
