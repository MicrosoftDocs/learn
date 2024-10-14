Azure DevOps secure files allow you to securely store sensitive files, such as code signing certificates, SSH keys, or third party provisioning profiles within your Azure DevOps organization. These files are encrypted at rest with a 2048-bit RSA key and, as an Azure DevOps protected resource, can only be accessed by authorized users and pipelines. The key is stored in Azure Key Vault maintained internally by Azure DevOps.

They're tightly integrated with Azure DevOps and provide a convenient way to consume sensitive files directly within CI/CD workflows. Access to secure files is managed within Azure DevOps, supporting fine-grained control over who can upload, download, and use them in pipelines and releases.

## Implementation

Implementing secure files involves uploading the sensitive files to Azure DevOps and then referencing them in your pipelines or releases.

Use the following sequence of steps to upload a file to secure files:

1.  In the Azure DevOps web portal, navigate to your Azure DevOps project.
2.  Navigate to the Pipelines or Releases tab, depending on where you intend to use the secure files.
3.  Select Library from the left-side navigational menu.
4.  Select Secure files followed by + Secure file to upload a secure file.
5.  Select the file you want to upload and provide a descriptive name.

Use the following sequence of steps to grant pipeline permissions to the newly created secure file.

1.  Select the newly created secure file.
2.  On the page displaying the properties of the secure file, select Pipeline permissions from the toolbar.
3.  In the Configure secure file pane, select the Add pipeline (+) button.
4.  In the list of the pipelines in the current project, select the pipeline or pipelines that should have access to the secure file.

To reference the secure file in a YAML pipeline, you can use the DownloadSecureFile@1 task, as in the following example, which illustrates how to download a secure file storing a certificate and installs it on a Linux system:

```YAML
- task: DownloadSecureFile@1
name: caCertificate
displayName: 'Download CA certificate'
inputs:
secureFile: 'myCACertificate.pem'
- script: |
echo Installing $(caCertificate.secureFilePath)
sudo chown root:root $(caCertificate.secureFilePath)
sudo chmod a+r $(caCertificate.secureFilePath)
sudo ln -s -t /etc/ssl/certs/ $(caCertificate.secureFilePath)

```
