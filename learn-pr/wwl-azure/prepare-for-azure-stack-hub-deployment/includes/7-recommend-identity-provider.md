You can deploy Azure Stack Hub using Azure Active Directory (Azure AD) or Active Directory Federation Services (AD FS) as the identity provider. Make the choice before you deploy Azure Stack Hub. In a connected scenario, you can choose Azure AD or AD FS. For a disconnected scenario, only AD FS is supported. This unit shows how to integrate Azure Stack Hub AD FS with your datacenter AD FS.

Keep in mind, you can't switch the identity provider without redeploying the entire Azure Stack Hub solution.

## Active Directory Federation Services and Graph

Deploy with AD FS allows identities in an existing Active Directory forest to authenticate with resources in Azure Stack Hub. This existing Active Directory forest requires a deployment of AD FS to allow the creation of an AD FS federation trust.

Authentication is one part of identity. To manage role-based access control (RBAC) in Azure Stack Hub, the Graph component must be configured. When access to a resource is delegated, the Graph component looks up the user account in the existing Active Directory forest using the LDAP protocol.

:::image type="content" source="../media/recommend-identity-provider-1-c171dc91.png" alt-text="Diagram showing normalized relational tables.":::


The existing AD FS is the account security token service (STS) that sends claims to the Azure Stack Hub AD FS (the resource STS). In Azure Stack Hub, automation creates the claims provider trust with the metadata endpoint for the existing AD FS.

At the existing AD FS, a relying party trust must be configured. This step isn't done by the automation, and must be configured by the operator. The Azure Stack Hub VIP endpoint for AD FS can be created by using the pattern `https://adfs.<Region>.<ExternalFQDN>/`.

The relying party trust configuration also requires you to configure the claim transformation rules that are provided by Microsoft.

For the Graph configuration, a service account must be provided with read permission in the existing Active Directory. This account is required as input for the automation to enable role-based access control (RBAC) scenarios.

For the last step, a new owner is configured for the default provider subscription. This account has full access to all resources when signed in to the Azure Stack Hub administrator portal.

| **Component** | **Requirement**                                   |
| ------------- | ------------------------------------------------- |
| Graph         | Microsoft Active Directory 2012/2012 R2/2016 2019 |
| AD FS         | Windows Server 2012/2012 R2/2016 2019             |

## Setting up Graph integration

Graph only supports integration with a single Active Directory forest. If multiple forests exist, only the forest specified in the configuration will be used to fetch users and groups.

The following information is required as inputs for the automation parameters:

| **Parameter**            | **Deployment Worksheet Parameter** | **Description**                                                             | **Example**              |
| ------------------------ | ---------------------------------- | --------------------------------------------------------------------------- | ------------------------ |
| CustomADGlobalCatalog    | AD FS Forest FQDN                  | FQDN of the target Active Directory forest that you want to integrate with. | Contoso.com              |
| CustomADAdminCredentials |                                    | A user with LDAP Read permission                                            | YOURDOMAIN\\graphservice |

## Configure Active Directory Sites

For Active Directory deployments having multiple sites, configure the closest Active Directory Site to your Azure Stack Hub deployment. The configuration avoids having the Azure Stack Hub Graph service resolve queries using a Global Catalog Server from a remote site.

Add the Azure Stack Hub Public VIP network subnet to the Active Directory Site closest to Azure Stack Hub. For example, let's say your Active Directory has two sites: Seattle and Redmond. If Azure Stack Hub is deployed at the Seattle site, you would add the Azure Stack Hub Public VIP network subnet to the Active Directory site for Seattle.

### Create user account in the existing Active Directory (optional)

Optionally, you can create an account for the Graph service in the existing Active Directory. Do this step if you don't already have an account that you want to use.

1.  In the existing Active Directory, create the following user account (recommendation):

 -  **Username**: *graphservice*
 -  **Password**: Use a strong password and configure the password to never expire.

### Trigger automation to configure graph

For this procedure, use a computer in your datacenter network that can communicate with the privileged endpoint in Azure Stack Hub.

1.  Open an elevated Windows PowerShell session (run as administrator), and connect to the IP address of the privileged endpoint. Use the credentials for **CloudAdmin** to authenticate.
    
    ```
    $creds = Get-Credential
    $pep = New-PSSession -ComputerName <IP Address of ERCS> -ConfigurationName PrivilegedEndpoint -Credential $creds
    
    ```

2.  Now that you have a session with the privileged endpoint, run the following command:
    
    ```
    $i = @(
            [pscustomobject]@{
                      CustomADGlobalCatalog="fabrikam.com"
                      CustomADAdminCredential= get-credential
                      SkipRootDomainValidation = $false
                      ValidateParameters = $true
                    })
    
    Invoke-Command -Session $pep -ScriptBlock {Register-DirectoryService -customCatalog $using:i}
    
    ```
    
    When prompted, specify the credential for the user account that you want to use for the Graph service (such as graphservice). The input for the Register-DirectoryService cmdlet must be the forest name / root domain in the forest rather than any other domain in the forest.

3.  The **Register-DirectoryService** cmdlet has optional parameters that you can use in certain scenarios where the existing Active Directory validation fails. When this cmdlet is executed, it validates that the provided domain is the root domain, a global catalog server can be reached, and that the provided account is granted read access.
    
    | **Parameter**            | **Description**                                                                    |
    | ------------------------ | ---------------------------------------------------------------------------------- |
    | SkipRootDomainValidation | Specifies that a child domain must be used instead of the recommended root domain. |
    | ValidateParameters       | Bypasses all validation checks.                                                    |

### Graph protocols and ports

Graph service in Azure Stack Hub uses the following protocols and ports to communicate with a writeable Global Catalog Server (GC) and Key Distribution Center (KDC) that can process login requests in the target Active Directory forest.

Graph service in Azure Stack Hub uses the following protocols and ports to communicate with the target Active Directory:

| **Type**    | **Port** | **Protocol**          |
| ----------- | -------- | --------------------- |
| LDAP        | 389      | TCP & UDP |
| LDAP SSL    | 636      | TCP                   |
| LDAP GC     | 3268     | TCP                   |
| LDAP GC SSL | 3269     | TCP                   |
