As you evaluate AKS on Azure Stack HCI, you remain aware of the operational challenges that Contoso has been struggling with in recent years. To address these challenges, you want to ensure that Contoso IT staff will be able to swiftly troubleshoot and resolve the most common issues that they might encounter when configuring and managing Kubernetes clusters. To help reach that goal, you decide to document the AKS on Azure Stack HCI troubleshooting steps you used during your evaluation.

## Troubleshoot issues with AKS on Azure Stack HCI 

The approach to troubleshooting AKS on Azure Stack HCI depends largely on the components that exhibit abnormal behavior. Assuming that the issue you encounter is limited to an individual component, you can start your troubleshooting process by using the following guidance.

### Troubleshoot Windows and Linux worker nodes

Both Windows and Linux worker nodes are accessible though the SSH protocol, with asymmetric key-based authentication. To identify their IP addresses, after you connect to the cluster, run the following command:

```kubectl
kubectl get nodes -o wide
```

When establishing an SSH connection, specify the location of the private key of the asymmetric key pair generated during cluster provisioning. By default, the private key is stored in the **C:\\ClusterStorage\\AKS\\AksHCI\\.ssh\\akshci_rsa** file of the Azure Stack HCI cluster nodes.

> [!NOTE]
> To reset the SSH keys and change their locations, run the **Set-AksHciConfig** PowerShell cmdlet.

## Troubleshoot authentication and authorization issues affecting AKS on Azure Stack HCI 

If you encounter issues with AD DS authentication (including gMSA), verify that time synchronization is configured across Azure Stack HCI cluster nodes and their virtual machines. You can use AD DS domain controllers or an external time service as the synchronization source. 

To join Windows Server nodes of a Kubernetes cluster on Azure Stack HCI to an AD DS domain, you will need Full Control permission in the AD DS container that hosts the Azure Stack HCI cluster nodes. 

---
## Check your knowledge

## Multiple Choice
As part of evaluating AKS on Azure Stack HCI for Contoso, you are documenting the steps to connect to the newly deployed Windows Server nodes of a Kubernetes cluster. What authentication method should you use during such connections? 
(x) Asymmetric key pair {{Correct. When establishing an SSH connection to a Windows node of a Kubernetes cluster, you need to provide the location of the private key of the asymmetric key pair generated during cluster provisioning.}}
( ) Active Directory {{Incorrect. Windows Servers that are deployed as part of a Kubernetes cluster node pool are not automatically joined to Active Directory.}}
( ) Azure Active Directory {{Incorrect. Windows Server does not support Azure Active Directory authentication.}}