Symmetric key attestation is a simple approach to authenticating a device with a Device Provisioning Service instance. This attestation method represents a "Hello world" experience for developers who are new to device provisioning, or don't have strict security requirements. Device attestation using a TPM or an X.509 certificate is more secure, and should be used for more stringent security requirements.

Symmetric key enrollments also provide a great way for legacy devices, with limited security functionality, to bootstrap to the cloud via Azure IoT.

## Symmetric key creation

By default, the Device Provisioning Service creates new symmetric keys with a default length of 32 bytes when new enrollments are saved with the **Auto-generate keys** option enabled. You can also provide your own symmetric keys for enrollments by disabling this option.

## Detailed attestation process

Symmetric key attestation with the Device Provisioning Service is performed using the same security tokens supported by IoT hubs to identify devices. These security tokens are Shared Access Signature (SAS) tokens.

SAS tokens have a hashed signature that is created using the symmetric key. The Device Provisioning Service recreates the signature to verify whether a security token presented during attestation is authentic or not.

SAS tokens have the following form:

`SharedAccessSignature sig={signature}&se={expiry}&skn={policyName}&sr={URL-encoded-resourceURI}`

Here are the components of each token:

:::row:::
  :::column:::
    **Value**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \{signature\}
  :::column-end:::
  :::column:::
    An HMAC-SHA256 signature string. For individual enrollments, this signature is produced by using the symmetric key (primary or secondary) to perform the hash. For enrollment groups, a key derived from the enrollment group key is used to perform the hash. The hash is performed on a message of the form: URL-encoded-resourceURI + "\\n" + expiry. *Important:* The key must be decoded from base64 before being used to perform the HMAC-SHA256 computation. Also, the signature result must be URL-encoded.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \{resourceURI\}
  :::column-end:::
  :::column:::
    URI of the registration endpoint that can be accessed with this token, starting with scope ID for the Device Provisioning Service instance. For example, \{Scope ID\}/registrations/\{Registration ID\}
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \{expiry\}
  :::column-end:::
  :::column:::
    UTF8 strings for number of seconds since the epoch 00:00:00 UTC on 1 January 1970.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \{URL-encoded-resourceURI\}
  :::column-end:::
  :::column:::
    Lower case URL-encoding of the lower case resource URI
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \{policyName\}
  :::column-end:::
  :::column:::
    The name of the shared access policy to which this token refers. The policy name used when provisioning with symmetric key attestation is **registration**.
  :::column-end:::
:::row-end:::
