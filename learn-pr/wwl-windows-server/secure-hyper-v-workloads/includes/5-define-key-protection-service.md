If you as the Contoso Windows Server administrator implement a guarded fabric on the Contoso infrastructure, the KPS is one of two services that comprise the HGS. The KPS provides a guarded host with the keys that power on shielded VMs, and for live migrating VMs to other guarded hosts.

## Overview of KPS

In a guarded fabric, a guarded host doesn't have the secure keys that are required to unlock and power on a shielded VM. Before the guarded host can power on the shielded VM, it must obtain the necessary keys from the KPS.

To obtain the keys, the guarded host must provide the following to the KPS:

- Health certificate. The guarded host must obtain a clean certificate of health from the HGS Attestation service.
- Encrypted secret. The secret or Key Protector (KP) is encrypted using other secure keys that only the KPS knows. The KPS uses the encrypted secret to obtain the keys that are needed unlock and power on a shielded VM.

When a guarded host starts a shielded VM, the HGS sends the guarded host's health certificate and encrypted secret to the KPS. The certificate and secret are sent to the *Key Protection Server URL* (KPS URL) using HTTP or secure HTTP 1.1 as transport.

To decide whether the keys for a shielded VM should be released to the guarded host, the KPS examines the guarded host's health certificate to determine its validity. The certificate must not be expired, and the KPS must trust the HGS Attestation service that issued the certificate.

If the health certificate is valid, the KPS attempts to decrypt the secret. If the KPS decrypts the secret successfully, the KPS sends the host the keys to power on and unlock the shielded VM.

The VM keys sent by the KPS are encrypted. They are stored on the guarded host using virtualization-based security (VBS).

## Configure KPS

When you install the HGS server role, the KPS is installed automatically. You must configure the guarded host's KPS URL and *Attestation Server URL*. The *Attestation Server URL* is the URL that the host uses to connect to the HGS Attestation service. The *Key Protection server URL* is the URL that the guarded host uses to retrieve the keys that are needed to decrypt shielded VMs.

You can use one of the following methods to configure the Attestation Server and KPS Server URLs.

### Windows PowerShell

1. On the HGS server, in an elevated Windows PowerShell session, retrieve the FDQN of your HGS using the cmdlet `Get-HgsServer`.

1. On the host, in an elevated Windows PowerShell session, configure the Key Protection and Attestation Server URLs by running the following cmdlet. Update the cmdlet with the FDQN you retrieved previously.

    ```powershell
    Set-HgsClientConfiguration -AttestationServerUrl 'http://<FQDN>/Attestation'
    ```

### Virtual Machine Manager

You can also configure the Attestation Server and Key Protection URLs for a host in VMM:

1. Obtain the Attestation Server and Key Protection URLs (FQDN) from the HGS server, in an elevated Windows PowerShell session, by using the cmdlet `Get-HgsServer`.

1. In the VMM console, select **Settings**, and then select **Host Guardian Service Settings**.

1. In the **Host Guardian Service Settings** window, enter the **Attestation Server URL** and **Key Protection URL** you obtained previously in their respective fields.

    :::image type="content" source="../media/m24-vmm-kps.png" alt-text="Screenshot of the HGS settings menu in VMM for adding the KPS URL for a host.":::

1. Select **Finish** to save the configuration.
