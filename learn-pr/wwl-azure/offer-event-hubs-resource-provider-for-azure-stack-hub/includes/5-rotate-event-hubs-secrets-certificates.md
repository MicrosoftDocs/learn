This unit shows you how to rotate the secrets used by the Event Hubs resource provider.

Secret rotation for value-add resource providers is currently only supported via PowerShell.

Like the Azure Stack Hub infrastructure, value-add resource providers use both internal and external secrets. Secrets can take multiple forms, including passwords and the encryption keys maintained by X509 certificates. As an operator, you're responsible for:

 -  Providing updated external secrets, such as a new TLS certificate used to secure resource provider endpoints.
 -  Managing resource provider secret rotation regularly.

In preparation for the rotation process:

1.  Review [Azure Stack Hub public key infrastructure (PKI) certificate requirements](https://docs.microsoft.com/azure-stack/operator/azure-stack-quota-types?&amp;preserve-view=true) for important prerequisite information before acquiring/renewing your X509 certificate, including details on the required PFX format. Also review the requirements specified in the [Optional PaaS certificates section](https://docs.microsoft.com/azure-stack/operator/azure-stack-pki-certs?&amp;preserve-view=true), for your specific value-add resource provider.
2.  If you haven't already, [Install PowerShell Az module for Azure Stack Hub](https://docs.microsoft.com/azure-stack/operator/powershell-install-az-module?&amp;preserve-view=true) before continuing. Version 2.0.2-preview or later is required for Azure Stack Hub secret rotation. For more information, see [Migrate from AzureRM to Azure PowerShell Az in Azure Stack Hub](https://docs.microsoft.com/azure-stack/operator/migrate-azurerm-az?&amp;preserve-view=true).

### Prepare a new TLS certificate

Next, create or renew your TLS certificate for securing the value-add resource provider endpoints:

1.  Complete the steps in [Generate certificate signing requests (CSRs) for certificate renewal](https://docs.microsoft.com/azure-stack/operator/azure-stack-get-pki-certs?&amp;preserve-view=true) for your resource provider. Here you use the Azure Stack Hub Readiness Checker tool to create the CSR. Be sure to run the correct cmdlet for your resource provider, in the step "Generate certificate requests for other Azure Stack Hub services". For example `New-AzsHubEventHubsCertificateSigningRequest` is used for Event Hubs. When finished, you submit the generated.REQ file to your Certificate Authority (CA) for the new certificate.
2.  Once you've received your certificate file from the CA, complete the steps in [Prepare certificates for deployment or rotation](https://docs.microsoft.com/azure-stack/operator/azure-stack-prepare-pki-certs?&amp;preserve-view=true). You use the Readiness Checker tool again, to process the file returned from the CA.
3.  Finally, complete the steps in [Validate Azure Stack Hub PKI certificates](https://docs.microsoft.com/azure-stack/operator/azure-stack-validate-pki-certs?&amp;preserve-view=true). You use the Readiness Checker tool once more, to perform validation tests on your new certificate.

## Rotate secrets

Finally, determine the resource provider's latest deployment properties and use them to complete the secret rotation process.

Resource providers are deployed into your Azure Stack Hub environment as a versioned product package. Packages are assigned a unique package ID, in the format `<product-id>.<installed-version>`. Where `<product-id>` is a unique string representing the resource provider, and `<installed-version>` represents a specific version. The secrets associated with each package are stored in the Azure Stack Hub Key Vault service.

Open an elevated PowerShell console and complete the following steps to determine the properties required to rotate the resource provider's secrets:

1.  Sign in to your Azure Stack Hub environment using your operator credentials. Be sure to use the PowerShell Az cmdlets (instead of AzureRM), and replace all placeholder values, such as endpoint URLs and directory tenant name.
2.  Run the `Get-AzsProductDeployment` cmdlet to retrieve a list of the latest resource provider deployments. The returned `"value"` collection contains an element for each deployed resource provider. Find the resource provider of interest and make note of the values for these properties:
    
     -  `"name"` \- contains the resource provider product ID in the second segment of the value.
     -  `"properties"."deployment"."version"` \- contains the currently deployed version number.

```PowerShell
PS C:\WINDOWS\system32> Get-AzsProductDeployment -AsJson
VERBOSE: GET https://adminmanagement.myregion.mycompany.com/subscriptions/ze22ca96-z546-zbc6-z566-z35f68799816/providers/Microsoft.Deployment.Admin/locations/global/productDeployments?api-version=2019-01-01 with 0-char payload
VERBOSE: Received 2656-char response, StatusCode = OK
{
    "value":  [
                  {
                      "id":  "/subscriptions/ze22ca96-z546-zbc6-z566-z35f68799816/providers/Microsoft.Deployment.Admin/locations/global/productDeployments/microsoft.eventhub",
                      "name":  "global/microsoft.eventhub",
                      "type":  "Microsoft.Deployment.Admin/locations/productDeployments",
                      "properties":  {
                                        "status":  "DeploymentSucceeded",
                                        "subscriptionId":  "b37ae55a-a6c6-4474-ba97-81519412adf5",
                                        "deployment":  {
                                                            "version":  "1.2003.0.0",
                                                            "actionPlanInstanceResourceId":"/subscriptions/ze22ca96-z546-zbc6-z566-z35f68799816/providers/Microsoft.Deployment.Admin/locations/global/actionplans/abcdfcd3-fef0-z1a3-z85d-z6ceb0f31e36",
                                                            "parameters":  {

                                                                          }
                                                        },
                                        "lastSuccessfulDeployment":  {
                                                                          "version":  "1.2003.0.0",
                                                                          "actionPlanInstanceResourceId":"/subscriptions/ze22ca96-z546-zbc6-z566-z35f68799816/providers/Microsoft.Deployment.Admin/locations/global/actionplans/abcdfcd3-fef0-z1a3-z85d-z6ceb0f31e36",
                                                                          "parameters":  {

                                                                                        }
                                                                      },
                                        "provisioningState":  "Succeeded"
                                    }
                  },
                  {
                  ...
                  }
              ]
}

```

3.  Build the resource provider's package ID, by concatenating the resource provider product ID and version. For example, using the values derived in the previous step, the Event Hubs RP package ID is `microsoft.eventhub.1.2003.0.0`.
4.  Using the package ID derived in the previous step, run `Get-AzsProductSecret -PackageId` to retrieve the list of secret types being used by the resource provider. In the returned `value` collection, find the element containing a value of `"Certificate"` for the `"properties"."secretKind"` property. This element contains properties for the RP's certificate secret. Make note of the name assigned to this certificate secret, which is identified by the last segment of the `"name"` property, just above `"properties"`.

```PowerShell
PS C:\WINDOWS\system32> Get-AzsProductSecret -PackageId 'microsoft.eventhub.1.2003.0.0' -AsJson
VERBOSE: GET
https://adminmanagement.myregion.mycompany.com/subscriptions/ze22ca96-z546-zbc6-z566-z35f68799816/providers/Microsoft.Deployment.Admin/locations/global/productPackages/microsoft.eventhub.1.2003.0.0/secrets?api-version=2019-01-01 with 0-char payload
VERBOSE: Received 617-char response, StatusCode = OK
{
    "value":  [
                    {
                        "id":  "/subscriptions/ze22ca96-z546-zbc6-z566-z35f68799816/providers/Microsoft.Deployment.Admin/locations/global/productPackages/microsoft.eventhub.1.2003.0.0/secrets/aseh-ssl-gateway-pfx",
                        "name":  "global/microsoft.eventhub.1.2003.0.0/aseh-ssl-gateway-pfx",
                        "type":  "Microsoft.Deployment.Admin/locations/productPackages/secrets",
                        "properties":  {
                                        "secretKind":  "Certificate",
                                        "description":  "Event Hubs gateway SSL certificate.",
                                        "expiresAfter":  "P730D",
                                        "secretDescriptor":  {

                                                                },
                                        "secretState":  {
                                                            "status":  "Deployed",
                                                            "rotationStatus":  "None",
                                                            "expirationDate":  "2022-03-31T00:16:05.3068718Z"
                                                        },
                                        "provisioningState":  "Succeeded"
                                    }
                    },
                    ...
                ]
}

```

### Rotate the secrets

1.  Use the `Set-AzsProductSecret` cmdlet to import your new certificate to Key Vault, which will be used by the rotation process. Replace the variable placeholder values accordingly before running the script:

```PowerShell
$productId = '<product-id>'
$packageId = $productId + '.' + '<installed-version>'
$certSecretName = '<cert-secret-name>'
$pfxFilePath = '<cert-pfx-file-path>'
$pfxPassword = ConvertTo-SecureString '<pfx-password>' -AsPlainText -Force
Set-AzsProductSecret -PackageId $packageId -SecretName $certSecretName -PfxFileName $pfxFilePath -PfxPassword $pfxPassword -Force

```

2.  Finally, use the 'Invoke-AzsProductRotateSecretsAction\` cmdlet to rotate the internal and external secrets:

```PowerShell
Invoke-AzsProductRotateSecretsAction -ProductId $productId

```

You can monitor secret rotation progress in either the PowerShell console, or in the administrator portal by selecting the resource provider in the Marketplace service:

:::image type="content" source="../media/rotate-secrets-image-1-918a7205.png" alt-text="Image of secret rotation process.":::
