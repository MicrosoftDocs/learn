You configure API Management to accept client certificates by using inbound policies.

Suppose your weather company has decided to secure its API through certificate authentication for certain clients. They already use certificate authentication within other systems. This setup will allow clients to use their existing certificates to authenticate themselves against the API Management gateway.

In this unit, you'll:

- Create a self-signed certificate
- Configure the gateway to request client certificates
- Get the thumbprint for the certificate
- Edit the inbound policy to allow only clients with the specified certificate in their request
- Call the API Management gateway and pass the certificate by using `curl`

## Create self-signed certificate

First, use the Cloud Shell to create a self-signed certificate, which you will use for the authentication between the client and the API Management gateway.

1. To create the private key and the certificate, run these commands in the Cloud Shell:

    ```bash
    pwd='Pa$$w0rd'
    pfxFilePath='selfsigncert.pfx'
    openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout privateKey.key -out selfsigncert.crt -subj /CN=localhost
    ```

    To make this example easy to follow, the commands previously provided include the password used to secure the private key. Whenever you generate a private key for your own use, make sure you properly generate a secure password and control access to it appropriately.

1. Now convert the certificate to PEM format, which the `curl` tool can use. Run these commands.

    ```bash
    openssl pkcs12 -export -out $pfxFilePath -inkey privateKey.key -in selfsigncert.crt -password pass:$pwd
    openssl pkcs12 -in selfsigncert.pfx -out selfsigncert.pem -nodes
    ```

    When you are prompted for a password, enter **Pa$$w0rd**, and then press <kbd>Enter</kbd>.

## Configure the gateway to request client certificates

Because you are using the Consumption tier for API Management, you must configure the gateway to accept client certificates. Follow these steps.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu, or from the **Home** page, select **All resources**, and then select your API Management gateway.

1. Under **Deployment and infrastructure**, select **Custom domains**.

1. For the **Request client certificates** option, select **Yes**, and then select **Save**.

    ![Configure the gateway to request certificates](../media/5-config-request-certificates.png)

## Get the thumbprint for the certificate

In the next section, you will configure API Management to accept a request only if it has a certificate with a certain thumbprint. Let's get that thumbprint from the certificate:

1. In the Cloud Shell, run the following command.

    ```bash
    Fingerprint="$(openssl x509 -in selfsigncert.pem -noout -fingerprint)"
    Fingerprint="${Fingerprint//:}"
    echo ${Fingerprint#*=}
    ```

1. Copy the complete output from the final command to a text file. The output should be a hexadecimal string without any accompanying text and no colons.

## Edit inbound policy to only allow requests with a valid certificate

Now, create the authentication policy within the API Management gateway.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu, or from the **Home** page, select **All Resources**, and then select your API gateway.

1. Select **APIs**, then select **Weather Data**, and then select the **Inbound processing** policies button.

    ![Inbound processing policy button](../media/5-inbound-policy.png)

1. Replace the `<inbound>` node of the policy file with the following XML, substituting the thumbprint you copied earlier for `desired-thumbprint`:

    ```XML
    <inbound>
        <choose>
            <when condition="@(context.Request.Certificate == null || context.Request.Certificate.Thumbprint != "desired-thumbprint")" >
                <return-response>
                    <set-status code="403" reason="Invalid client certificate" />
                </return-response>
            </when>
        </choose>
        <base />
    </inbound>
    ```

1. Select **Save**.

## Call the gateway and pass the client certificate

Finally, you can test the new authentication policy. You can test without the certificate and with it.

1. To test the API without the certificate, run the following command within the Cloud Shell.

    ```PowerShell
    curl -X GET https://[api-gateway-name].azure-api.net/api/Weather/53/-1 \
      -H 'Ocp-Apim-Subscription-Key: [Subscription Key]'
    ```

    This command should return a 403 Client certificate error, and no data will be returned.

1. In the Azure Cloud Shell, to test the API with the certificate, copy and paste the following cURL command, using the subscription key from the first exercise.

    ```PowerShell
    curl -X GET https://[gateway-name].azure-api.net/api/Weather/53/-1 \
      -H 'Ocp-Apim-Subscription-Key: [subscription-key]' \
      --cert-type pem \
      --cert selfsigncert.pem
    ```

    This command should result in a successful response similar to the following.

    ```json
    {"mainOutlook":{"temperature":32,"humidity":34},"wind":{"speed":11,"direction":239.0},"date":"2019-05-16T00:00:00+00:00","latitude":53.0,"longitude":-1.0}
    ```