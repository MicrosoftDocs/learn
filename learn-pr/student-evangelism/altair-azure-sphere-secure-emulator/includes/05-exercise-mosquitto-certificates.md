In this unit, you will learn how to generate the MQTT client certificates for the test.mosquitto.org MQTT Broker.

## Mosquitto Certificates

This MQTT sample is going to connect to the [mosquitto.org](https://mosquitto.org) public test MQTT broker. You need to download and copy the ```mosquitto.org``` CA certificate and generated client certificates into the Azure Sphere application **AltairHL_emulator\certs** folder.

### Install openssl

For Linux users, you may need to install **openssl** if it is not installed by default. You can install OpenSSL using your Linux distributions package manager. For example, on Ubuntu ```sudo apt-get install openssl```.

For Windows users either download ```openssl``` from [openssl.org](https://wiki.openssl.org/index.php/Binaries), or use [WSL](https://docs.microsoft.com/windows/wsl/install-win10) (Windows Subsystem for Linux). Depending on the WSL Linux distribution you installed you may need to install **openssl**. You can install OpenSSL using your Linux distribution's package manager. For example, on Ubuntu ```sudo apt-get install openssl```.

### Download the Mosquitto Certificate Authority certificate

1. Download the Mosquitto Certificate Authority certificate [mosquitto.org.crt (PEM format)](https://test.mosquitto.org/).
1. Rename the **mosquitto.org.crt** file to **ca.crt**.
1. Copy the **ca.crt** file to the **AltairHL_emulator\certs** folder.

### Generate the client certificates with OpenSSL

1. Generate a Certificate Signing Request (CSR) using the OpenSSL utility. Generate a private key:

    ```bash
    openssl genrsa -out client.key
    ```

2. Generate the CSR.

    * At a minimum, the CSR must include the Country, Organisation and Common Name fields.

    * The **Common Name** must match the [FQDN](https://en.wikipedia.org/wiki/Fully_qualified_domain_name) of the MQTT broker. When prompted to enter the Common Name ensure you set it to **test.mosquitto.org**.

    ```bash
    openssl req -out client.csr -key client.key -new
    ```

3. Open the client.csr with your favorite text editor and copy and paste the CSR into the [test.mosquitto.org generate a TLS client certificate form](https://test.mosquitto.org/ssl/). After you submit the form, the certificate will be generated for you to download. The certificates are valid for 90 days only.

4. Copy both the ```client.key``` and the ```client.crt``` into the AltairHL_emulator\certs.

When you have completed the certificate step you should have **three** certificate files in the **AltairHL_emulator\certs** folder.

They will be named:

1. ca.crt
2. client.key
3. client.crt
