As the Windows Server administrator, you need to investigate and ensure you understand the steps involved to create and deploy a shielded VM.

## Implement shielded VMs

The following are the high-level steps needed for implementing shielded VMs. The steps include some steps related to VMM.

### Task 1: Install and configure the HGS

1. Check the HGS prerequisites and prepare your environment for HGS deployment:

    1. Ensure that your hardware and OS meet the HGS prerequisite requirements, noting that:
        - HGS can be run on physical or virtual machines, but physical machines are recommended.
        - If you want to run HGS as a 3-node physical cluster, you must have 3 physical servers.
        - Attestation requirements:
            - Host Key attestation requires Windows Server 2019 Standard or Datacenter edition operating for v2 attestation.
            - TPM-based attestation requires Windows Server 2019 or Windows Server 2016, Standard or Datacenter edition.

    1. Install the appropriate HGS server roles and configure your fabric (host) domain to allow DNS forwarding between the fabric domain and the HGS domain.

    > [!NOTE]
    > When you deploy HGS, you will be asked to provide signing and encryption certificates that are used to protect the sensitive information needed to start up a shielded VM. It is recommended to use a trusted certificate authority to obtain these two certificates; however, it is possible to use self-signed certificates. These two certificates always remain on the HGS host.

1. Configure the first HGS node:

    - Select whether to install HGS in its own dedicated AD DS forest or in an existing bastion forest.

1. Configure additional HGS nodes according to your environment:

    1. Every HGS node will require access to the same signing and encryption certificates. Manage them by choosing one of the following two options:

        - Export your certificates to a PFX file with a password and allow HGS to manage the certificates for you.
        - Install the certificates into the local machine's certificate store on each HGS node and provide the thumbprint to HGS.

        Either option is valid but will require slightly different steps during the addition of a node.

    1. Add additional nodes by using one of the following two possible scenarios:

        - Add HGS nodes to a new, dedicated HGS forest.

           - To add HGS nodes to a new dedicated HGS forest with Personal Information Exchange (PFX) certificates:

                1. Promote the HGS node to a domain controller.
                1. Initialize the HGS server.

           - To add HGS nodes to a new dedicated HGS forest with certificate thumbprints:

                1. Promote the HGS node to a domain controller.
                1. Initialize the HGS server.
                1. Install the private keys for the certificates.

        - Add HGS nodes to an existing bastion forest.

            - To add HGS nodes to an existing bastion forest with PFX certificates:

                1. Join the node to the existing domain.
                1. Grant the machine rights to retrieve a Managed Service Account (MSA) password and run `Install-ADServiceAccount`.
                1. Initialize the HGS server.

            - To add HGS nodes to an existing bastion forest with certificate thumbprints:

                1. Join the node to the existing domain.
                1. Grant the machine rights to retrieve an MSA password and run `Install-ADServiceAccount`.
                1. Initialize the HGS server.
                1. Install the private keys for the certificates.

    > [!NOTE]
    > HGS uses a group managed service account (gMSA) as the account identity to retrieve and use its certificates over multiple nodes.

    > [!IMPORTANT]
    > In production environments, HGS should be set up in a high availability cluster to ensure that shielded VMs can be powered on even if an HGS node goes down.

1. Configure the fabric's DNS to allow guarded hosts to resolve the HGS cluster.

1. Verify the prerequisites for attestation on the hosts:

    1. Review the host prerequisites for the attestation mode you've chosen: TPM, Key, or Admin mode.
    1. Add the hosts to the HGS.

1. Create a host key (Key mode) or collect host information (TPM mode):

    - To prepare Hyper-V hosts to become guarded hosts using Host Key attestation (Key mode), create a host key pair (or use an existing certificate), and then add the public half of the key to HGS.

    - To prepare Hyper-V hosts to become guarded hosts using TPM-mode attestation (Key mode), capture the hosts' TPM identifier (endorsement key), TPM baseline, and CI policy.

1. Add host keys (Key mode) or TPM information (TPM mode) to the HGS configuration.

1. Confirm that the HGS attests to the hosts as guarded hosts.

1. (Optional) Configure the VMM compute fabric for deploying and managing Hyper-V guarded hosts and shielded VMs.

### Task 2: Prepare an OS .vhdx file

1. Prepare an OS disk (.vhdx file) by using one of the following options:
    - Use **Hyper-V**, **Windows PowerShell** or the Microsoft Desktop Image Service Manager (DISM) utility.
    - Manually set up a VM with a blank .vhdx file and install the OS onto that disk.

1. Install the latest updates on the OS disk by running **Windows Update**.

### Task 3: Create shielded VM template disk in VMM

1. Prepare and protect the .vhdx file by using the **Shielded Template Disk Creation Wizard**.

    - To use a template disk with shielded VMs, you must prepare the disk and encrypt it with **BitLocker** by using the **Shielded Template Disk Creation Wizard**.

1. Copy the template disk to the **VMM Library**.

    - If you use VMM, after you create a template disk, copy it to a VMM library share so that hosts can download and use the disk when provisioning new shielded VMs.

### Task 4: Create the shielding data file

1. Prepare to create the shielding data (PDK) file:

    1. Obtain a certificate for Remote Desktop Connection.
    1. Create an answer file.
    1. Get the volume signature catalog file.
    1. Set the trusted fabrics.

1. Create the shielding data file.

1. Add guardians that are authorized to use the shielding data file.

### Task 5: Deploy a shielded VM

1. Deploy a shielded VM by using **Windows Azure Pack** or **VMM**:

    1. Upload the shielding data file according to the requirements for your chosen deployment method, such as Windows Azure Pack or VMM.
    1. Provision a new shielded VM.

### Task 6: Start a shielded VM

The process to start a shielded VM is as follows:

1. A user requests to start the shielded VM.
1. The HGS Attestation service validates guarded host's credentials and sends an attestation certificate to the guarded host.
1. The guarded host submits its attestation certificate and KP to the KPS and requests a key to unlock the shielded VM.
1. The KPS determines an attestation certificate's validity, decrypts the KP, retrieves the key for unlocking the shielded VM and sends the key to the guarded host.
1. The guarded host uses the key to unlock and start the shielded VM.

    > [!NOTE]
    > **Remote Server Administration Tools > Shielded VM Tools** includes the **Shielded Template Disk Creation Wizard**, which is accessible from the **Tools** menu in Server Manager.
