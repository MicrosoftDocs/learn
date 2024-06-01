
Trusted Platform Module (TPM) is a standard for securely storing keys used to authenticate the platform. TPMs can exist as discrete hardware, integrated hardware, firmware-based, or software-based. Device Provisioning Service only supports TPM 2.0.

TPM attestation is based on a nonce challenge, which uses the endorsement and storage root keys to present a signed Shared Access Signature (SAS) token.

The *endorsement key* (EK) is an asymmetric key contained inside the TPM, which was internally generated or injected at manufacturing time and is unique for every TPM. The endorsement key can't be changed or removed. The private portion of the endorsement key is never released outside of the TPM, while the public portion of the endorsement key is used to recognize a genuine TPM.

The *storage root key* (SRK) is stored in the TPM and is used to protect TPM keys created by applications so that these keys can't be used without the TPM. The storage root key is generated when you take ownership of the TPM; when you clear the TPM so a new user can take ownership, a new storage root key is generated.

It's like moving into a new house: taking ownership is changing the locks on the doors and removing the furniture left by the previous owners (SRK), but you can't change the address of the house (EK).

Once a device has been set up and ready to use, it has both an EK and an SRK available for use.

:::image type="content" source="../media/m03-l01-device-provisioning-service-trusted-platform-module-ownership-2e2f42a8.png" alt-text="Diagram that shows an overview of Trusted Platform Module attestation using endorsement keys.":::

One note on taking ownership of the TPM: taking ownership of a TPM depends on many things, including TPM manufacturer, the set of TPM tools being used, and the device OS. Follow the instructions relevant to your system to take ownership.

The Device Provisioning Service uses the public part of the EK (*EK\_pub*) to identify and enroll devices. The device vendor can read the EK\_pub during manufacture or final testing and upload the EK\_pub to the provisioning service so that the device will be recognized when it connects to provision. The Device Provisioning Service doesn't check the SRK or owner, so "clearing" the TPM erases customer data, but the EK (and other vendor data) is preserved and the device is still recognized by the Device Provisioning Service.

> [!NOTE]
> This information is only relevant for devices using TPM 2.0 with HMAC key support and their endorsement keys and assumes you are using a discrete, firmware, or integrated TPM. Software emulated TPMs are well suited for prototyping or testing, but they do not provide the same level of security as discrete, firmware, or integrated TPMs do. We do not recommend using software TPMs in production.

## Detailed attestation process

1. When a device with a TPM first connects to the provisioning service, the service checks the provided EK\_pub against the EK\_pub stored in the enrollment list.
   * If the EK\_pubs don't match, the device isn't allowed to provision.
   * If the EK\_pubs do match, the service then requires the device to prove ownership of the private portion of the EK via a nonce challenge, which is a secure challenge used to prove identity.
1. The Device Provisioning Service generates a nonce and then encrypts it with the SRK and then the EK\_pub, both of which are provided by the device during the initial registration call. The TPM always keeps the private portion of the EK secure. This prevents counterfeiting and ensures SAS tokens are securely provisioned to authorized devices.

Let's walk through the attestation process in detail.

### Device requests an IoT Hub assignment

First, the device connects to the Device Provisioning Service and requests to provision by providing the service with its registration ID, an ID scope, and the EK\_pub and SRK\_pub from the TPM. The service passes the encrypted nonce back to the device and asks the device to decrypt the nonce and use that to sign a SAS token to connect again and finish provisioning.

:::image type="content" source="../media/step-one-request-provisioning-78fb84b8.png" alt-text="Diagram that shows TPM attestation step 1, the device makes a provisioning request.":::

### Nonce challenge

The device takes the nonce and uses the private portions of the EK and SRK to decrypt the nonce into the TPM; the order of nonce encryption delegates trust from the EK, which is immutable, to the SRK, which can change if a new owner takes ownership of the TPM.

:::image type="content" source="../media/step-two-nonce-challenge-a87bd4ee.png" alt-text="Diagram that shows TPM attestation step 2, device completes the nonce challenge.":::

### Validate the nonce and receive credentials

The device can then sign a SAS token using the decrypted nonce and reestablish a connection to the Device Provisioning Service using the signed SAS token. With the nonce challenge completed, the service allows the device to provision.

:::image type="content" source="../media/m03-l01-device-provisioning-service-trusted-platform-module-attestation-step-three-validation-922a60fc.png" alt-text="Diagram that shows TPM attestation step 3, the nonce is validated and the device receives IoT hub connection information.":::

Now the device connects to IoT Hub, and you rest secure in the knowledge that your devices' keys are securely stored.
