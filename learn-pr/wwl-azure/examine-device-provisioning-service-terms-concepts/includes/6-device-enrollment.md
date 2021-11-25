A device enrollment creates a record of a single device or a group of devices that may at some point register with the Azure IoT Hub. The enrollment record contains the initial desired configuration for the device(s) as part of that enrollment, including the desired IoT hub.

## Enrollment types

There are two ways you can enroll your devices with the provisioning service:

 -  Individual Enrollments: An Individual enrollment is an entry for a single device that may register. Individual enrollments may use either X.509 certificates or SAS tokens (from a physical or virtual TPM) as attestation mechanisms. We recommend using individual enrollments for devices that require unique initial configurations, or for devices that can only use SAS tokens via TPM or virtual TPM as the attestation mechanism. Individual enrollments may have the desired IoT hub device ID specified.
 -  Group Enrollments: An enrollment group is a group of devices that share a specific attestation mechanism. Enrollment groups support both X.509 and symmetric keys. All devices in the X.509 enrollment group present X.509 certificates that have been signed by the same root or intermediate Certificate Authority (CA). Each device in the symmetric key enrollment group present SAS tokens derived from the group symmetric key. The enrollment group name and certificate name must be alphanumeric, lowercase, and may contain hyphens.
