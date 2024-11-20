To manage Azure Stack Hub public endpoint public key infrastructure (PKI) certificates for both Microsoft Entra ID and AD FS Azure Stack Hub deployments, you need to understand the requirements for area and namespace. Certificates with the appropriate DNS names for each Azure Stack Hub public infrastructure endpoint are required. For deployment, the \[region\] and \[externalfqdn\] values must match the region and external domain names that you chose for your Azure Stack Hub system.

In this module, you'll see how to use the Azure Stack Hub Readiness Checker tool to validate the generated public key infrastructure (PKI) certificates are suitable for pre-deployment. Also, you'll see how to perform a secret rotation to help maintain secure communication with Azure Stack Hub infrastructure resources and services.

This module aligns with the exam AZ-600: Configuring and Operating a Hybrid Cloud with Microsoft Azure Stack Hub.

## Learning objectives

After completing this module, you'll be able to:

 -  Recommend certificate strategy for Azure Stack Hub.
 -  Validate certificates for Azure Stack Hub.
 -  Run secret rotation PowerShell cmdlet for external certificates for Azure Stack Hub.

## Skills measured

 -  Manage infrastructure certificates for Azure Stack.

## Prerequisites

 -  Working experience creating, assigning, and securing corporate identities.
 -  Conceptual knowledge of identity assignment solutions, role-based access control, and identity protection methods.
