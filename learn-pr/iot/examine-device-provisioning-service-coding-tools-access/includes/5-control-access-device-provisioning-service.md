The Azure IoT Hub Device Provisioning Service uses *authentication* and *permissions* to grant access to each endpoint. Permissions limit the access to a service instance based on functionality.

## Authentication

The Device API supports key-based and X.509 certificated-based device authentication.

The Service API supports key-based authentication for backend apps.

When using key-based authentication, the Device Provisioning Service uses security tokens to authenticate services to avoid sending keys on the wire. Additionally, security tokens are limited in time validity and scope. Device Provisioning Service SDKs automatically generate tokens without requiring any special configuration.

In some cases you may need to use the HTTP Device Provisioning Service REST APIs directly, without using the SDKs. The following sections describe how to authenticate directly against the REST APIs.

## Device API authentication

The Device API is used by devices to attest to the Device Provisioning Service and receive an Azure IoT Hub connection.

> [!NOTE]
> In order to receive an authenticated connection, devices must first be registered in the Device Provisioning Service through an enrollment. Use the Service API to programmatically register a device through an enrollment.

A device must authenticate to the Device API as part of the provisioning process. The method a device uses to authenticate is defined when you set up an enrollment group or individual enrollment. Whatever the authentication method, the device must issue an HTTPS PUT to the following URL to provision itself.

`https://global.azure-devices-provisioning.net/[ID_Scope]/registrations/[registration_id]/register?api-version=2021-06-01`

If using key-based authentication, a security token is passed in the HTTP Authorization request header in the following format:

`SharedAccessSignature sig={signature}&se={expiry}&skn={policyName}&sr={URL-encoded-resourceURI}`

### Security token structure for key-based authentication

The security token is passed in the HTTP Authorization request header in the following format:

`SharedAccessSignature sig={signature}&se={expiry}&skn={policyName}&sr={URL-encoded-resourceURI}`

The expected values are:

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
    An HMAC-SHA256 signature string of the form: \{URL-encoded-resourceURI\} + "\\n" + expiry. The key is decoded from base64 and used as key to perform the HMAC-SHA256 computation.
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
    Lower case URL-encoding of {ID_Scope}/registrations/{registration_id}.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \{policyName\}
  :::column-end:::
  :::column:::
    For the Device API, this policy is always "registration".
  :::column-end:::
:::row-end:::

The following Python snippet shows a function called `generate_sas_token` that computes the token from the inputs `uri`, `key`, `policy_name`, `expiry` for an individual enrollment using a symmetric key authentication type.

```python
from base64 import b64encode, b64decode, encode 
from hashlib import sha256 
from time import time 
from urllib.parse import quote_plus, urlencode 
from hmac import HMAC 

 def generate_sas_token(uri, key, policy_name, expiry=3600): 
    ttl = time() + expiry 
    sign_key = "%s\n%d" % ((quote_plus(uri)), int(ttl)) 
    signature = b64encode(HMAC(b64decode(key), sign_key.encode('utf-8'), sha256).digest()) 

    rawtoken = { 
        'sr' :  uri, 
        'sig': signature, 
        'se' : str(int(ttl)), 
        'skn' : policy_name 
    } 

    return 'SharedAccessSignature ' + urlencode(rawtoken) 

print(generate_sas_token("myIdScope/registrations/mydeviceregistrationid", "00mysymmetrickey", "registration"))

```

The result should resemble the following output:

```bash
SharedAccessSignature sr=myIdScope%2Fregistrations%2Fmydeviceregistrationid&sig=SDpdbUNk%2F1DSjEpeb29BLVe6gRDZI7T41Y4BPsHHoUg%3D&se=1630175722&skn=registration
```

The following example shows how the shared access signature is then used to authenticate with the Device API.

```python
curl -L -i -X PUT -H 'Content-Type: application/json' -H 'Content-Encoding:  utf-8' -H 'Authorization: [token]' -d '{"registrationId": "[registration_id]"}' https://global.azure-devices-provisioning.net/[ID_Scope]/registrations/[registration_id]/register?api-version=2021-06-01
```

If using a symmetric key-based enrollment group, you need to first generate a device symmetric key using the enrollment group key. Use the enrollment group primary or secondary key to compute an HMAC-SHA256 of the registration ID for the device. The result is then converted into Base64 format to obtain the derived device key. To avoid including the group master key in your device code, the process of deriving the device key should be done off the device.

### Certificate-based authentication

If you've set up an individual enrollment or enrollment group for X.509 certificated-based authentication, the device needs to use its issued X.509 certificate to attest to the Device API. Refer to the following articles on how to set up the enrollment and generate the device certificate.

* Quickstart - [Provision simulated X.509 device to Azure IoT Hub](/azure/iot-dps/quick-create-simulated-device-x509?tabs=windows&pivots=programming-language-csharp)

* Quickstart - [Enroll X.509 devices to Azure Device Provisioning Service](/azure/iot-dps/quick-enroll-device-x509?pivots=programming-language-csharp)

Once the enrollment is set up and the device certificate issued, the following example demonstrates how to authenticate to the Device API with the device's X.509 certificate.

```bash
curl -L -i -X PUT -cert ./[device_cert].pem -key ./[device_cert_private_key].pem -H 'Content-Type: application/json' -H 'Content-Encoding:  utf-8' -d '{"registrationId": "[registration_id]"}' https://global.azure-devices-provisioning.net/[ID_Scope]/registrations/[registration_id]/register?api-version=2021-06-01
```

## Service API authentication

The Service API is used to retrieve registration state and remove device registrations. The Service API is also used by backend apps to programmatically manage both individual groups and enrollment groups. The Service API supports key-based authentication for backend apps.

You must have appropriate permissions to access any of the Service API endpoints. For example, a backend app must include a token containing security credentials along with every message it sends to the service.

Azure IoT Hub Device Provisioning Service grants access to endpoints by verifying a token against the shared access policies. Security credentials, such as symmetric keys, are never sent over the wire.

### Access control and permissions

You can grant permissions using **Shared access policies**. Shared access policies can grant any combination of permissions. You can define policies in the portal **Azure IoT Hub Device Provisioning Service (DPS)** blade, or programmatically by using the Device Provisioning Service REST APIs. A newly created provisioning service has a default policy of **provisioningserviceowner**, with all permissions enabled.

HTTP is the only supported protocol, and it implements authentication by including a valid token in the Authorization request header.

For example:

```bash
SharedAccessSignature sr = 
   mydps.azure-devices-provisioning.net&sig=kPszxZZZZZZZZZZZZZZZZZAhLT%2bV7o%3d&se=1487709501&skn=provisioningserviceowner`\
```

### Security tokens

The Device Provisioning Service uses security tokens to authenticate services to avoid sending keys on the wire. Additionally, security tokens are limited in time validity and scope. Device Provisioning Service SDKs automatically generate tokens when connecting to a service without requiring any special configuration. Some scenarios do require you to generate and use security tokens directly. Such scenarios include the direct use of the HTTP surface.

### Security token structure

You use security tokens to grant time-bounded access for services to specific functionality in Device Provisioning Service. To get authorization to connect to the provisioning service, services must send security tokens signed with either a shared access or symmetric key.

A token signed with a shared access key grants access to all the functionality associated with the shared access policy permissions. The security token has the following format:

`SharedAccessSignature sig={signature}&se={expiry}&skn={policyName}&sr={URL-encoded-resourceURI}`

Here are the expected values:

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
    An HMAC-SHA256 signature string of the form: \{URL-encoded-resourceURI\} + "\\n" + expiry. The key is decoded from base64 and used as key to perform the HMAC-SHA256 computation.
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
    Lower case URL-encoding of the lower case resource URI. URI prefix (by segment) of the endpoints that can be accessed with this token, starting with host name of the Device Provisioning Service (no protocol). For example, mydps.azure-devices-provisioning.net.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \{policyName\}
  :::column-end:::
  :::column:::
    The name of the shared access policy to which this token refers.
  :::column-end:::
:::row-end:::


> [!NOTE]
> The URI prefix is computed by segment and not by character. For example `/a/b` is a prefix for `/a/b/c` but not for `/a/bc`.

The following Node.js snippet shows a function called **generateSasToken** that computes the token from the inputs `resourceUri, signingKey, policyName, expiresInMins`. The next sections detail how to initialize the different inputs for the different token use cases.

```javascript
var generateSasToken = function(resourceUri, signingKey, policyName, expiresInMins) {
    resourceUri = encodeURIComponent(resourceUri);

    // Set expiration in seconds
    var expires = (Date.now() / 1000) + expiresInMins * 60;
    expires = Math.ceil(expires);
    var toSign = resourceUri + '\n' + expires;

    // Use crypto
    var hmac = crypto.createHmac('sha256', new Buffer(signingKey, 'base64'));
    hmac.update(toSign);
    var base64UriEncoded = encodeURIComponent(hmac.digest('base64'));

    // Construct authorization string
    var token = "SharedAccessSignature sr=" + resourceUri + "&sig="
    + base64UriEncoded + "&se=" + expires + "&skn="+ policyName;
    return token;
};

```

As a comparison, the equivalent Python code to generate a security token is:

```python
from base64 import b64encode, b64decode
from hashlib import sha256
from time import time
from urllib.parse import quote_plus, urlencode
from hmac import HMAC

def generate_sas_token(uri, key, policy_name, expiry=3600):
    ttl = time() + expiry
    sign_key = "%s\n%d" % ((quote_plus(uri)), int(ttl))
    print sign_key
    signature = b64encode(HMAC(b64decode(key), sign_key, sha256).digest())

    rawtoken = {
        'sr' :  uri,
        'sig': signature,
        'se' : str(int(ttl)),
        'skn' : policy_name
    }

    return 'SharedAccessSignature ' + urlencode(rawtoken)

```

### Use security tokens from service components

Service components can only generate security tokens using shared access policies granting the appropriate permissions as explained previously.

Here are the functions exposed on the endpoints:

:::row:::
  :::column:::
    **Endpoint**
  :::column-end:::
  :::column:::
    **Functionality**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \{your-service\}.azure-devices-provisioning.net/enrollments
  :::column-end:::
  :::column:::
    Provides device enrollment operations with the Device Provisioning Service.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \{your-service\}.azure-devices-provisioning.net/enrollmentGroups
  :::column-end:::
  :::column:::
    Provides operations for managing device enrollment groups.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \{your-service\}.azure-devices-provisioning.net/registrations/\{id\}
  :::column-end:::
  :::column:::
    Provides operations for retrieving and managing the status of device registrations.
  :::column-end:::
:::row-end:::

As an example, a service generated using a pre-created shared access policy named **enrollmentread** would create a token with the following parameters:

* resource URI: `{mydps}.azure-devices-provisioning.net`,
* signing key: one of the keys of the `enrollmentread` policy,
* policy name: `enrollmentread`,
* an expiration time

```javascript
var endpoint ="mydps.azure-devices-provisioning.net";
var policyName = 'enrollmentread';
var policyKey = '...';

var token = generateSasToken(endpoint, policyKey, policyName, 60);

```

The result, which would grant access to read all enrollment records, would be:

```azurecli
SharedAccessSignature sr=mydps.azure-devices-
provisioning.net&sig=JdyscqTpXdEJs49elIUCcohw2DlFDR3zfH5KqGJo4r4%3D&se=1456973447&skn=enrollmentread

```

## Device Provisioning Service permissions

The following table lists the permissions you can use to control access to your Device Provisioning Service.

:::row:::
  :::column:::
    **Permission**
  :::column-end:::
  :::column:::
    **Notes**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ServiceConfig
  :::column-end:::
  :::column:::
    Grants access to change the service configurations. This permission is used by backend cloud services.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    EnrollmentRead
  :::column-end:::
  :::column:::
    Grants read access to the device enrollments and enrollment groups. This permission is used by backend cloud services.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    EnrollmentWrite
  :::column-end:::
  :::column:::
    Grants write access to the device enrollments and enrollment groups. This permission is used by backend cloud services.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    RegistrationStatusRead
  :::column-end:::
  :::column:::
    Grants read access to the device registration status. This permission is used by backend cloud services.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    RegistrationStatusWrite
  :::column-end:::
  :::column:::
    Grants delete access to the device registration status. This permission is used by backend cloud services.
  :::column-end:::
:::row-end:::
