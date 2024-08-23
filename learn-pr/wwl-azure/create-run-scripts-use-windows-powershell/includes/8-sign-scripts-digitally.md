When you use Windows PowerShell scripts in your production environment, there should be an approval process to verify that those scripts have been tested. The approval process will vary depending on the size of the organization and the level of bureaucracy, but there should be some approval process.

One way to formalize the approval process for scripts used in a production environment is to digitally sign the scripts and use the **AllSigned** script execution policy. When you implement this policy, any modified scripts must be updated with a new digital signature. This prevents administrators or other staff from making random script changes. For example, if your organization has a set of approved scripts for managing Active Directory Domain Services (AD DS) users, this configuration will prevent helpdesk staff from modifying the scripts either on purpose or by accident.

To add a digital signature to a script, you must have a code-signing certificate that's trusted by all the computers that will be running the script. You can obtain a trusted code-signing certificate from a public certification authority. You can also obtain a code-signing certificate from an internal certification authority that's trusted by the computers.

You add a digital signature by using the **Set-AuthenticodeSignature** cmdlet, as the following code depicts:

```powershell
$cert =  Get-ChildItem -Path "Cert:\CurrentUser\My" -CodeSigningCert
Set-AuthenticodeSignature -FilePath "C:\Scripts\MyScript.ps1" -Certificate $cert
```

