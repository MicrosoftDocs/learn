In this exercise, you'll create the client certificates for the test.mosquitto.org MQTT broker.

## Install openssl

For Linux users, you may need to install **openssl**. You can install OpenSSL using your Linux distributions package manager. For example, on Ubuntu `sudo apt-get install openssl`.

For Windows users either download `openssl` from [openssl.org](https://wiki.openssl.org/index.php/Binaries?azure-portal=true), or use [Windows Subsystem for Linux (WSL))](/windows/wsl/install-win10). Depending on the WSL Linux distribution, you installed you may need to install **openssl**. You can install OpenSSL using your Linux distribution's package manager. For example, on Ubuntu `sudo apt-get install openssl`.

## Delete the existing placeholder certificates

The **AltairHL_emulator\certs** folder contains three placeholder certificates. The placeholder certificates are required for the **build_all** validation process. Delete the placeholder certificates as you will be creating new certificates for the Altair emulator.

1. From your computer file manager, navigate to the **AltairHL_emulator\certs** folder and delete the three placeholder certificates.

    - ca.crt
    - client.key
    - client.crt

## Download the Mosquitto Certificate Authority certificate

1. Download the Mosquitto Certificate Authority certificate [mosquitto.org.crt (PEM format)](https://test.mosquitto.org?azure-portal=true).
1. Rename the **mosquitto.org.crt** file to **ca.crt**.
1. Copy the **ca.crt** file to the **AltairHL_emulator\certs** folder.

## Generate the client certificates with OpenSSL

1. Generate a Certificate Signing Request (CSR) using the OpenSSL utility. Generate a private key:

    ```bash
    openssl genrsa -out client.key
    ```

2. Generate the CSR.

    * At a minimum, the CSR must include the Country, Organization, and Common Name fields.

    * The **Common Name** must match the [FQDN](https://en.wikipedia.org/wiki/Fully_qualified_domain_name?azure-portal=true) of the MQTT broker. When prompted to enter the Common Name, set it to **test.mosquitto.org**.

    ```bash
    openssl req -out client.csr -key client.key -new
    ```

3. Open the client.csr with your favorite text editor and copy and paste the CSR into the [test.mosquitto.org generate a TLS client certificate form](https://test.mosquitto.org/ssl/?azure-portal=true). After you submit the form, the certificate will be generated for you to download. The certificates are valid for 90 days only.

4. Copy both the `client.key` and the `client.crt` into the AltairHL_emulator\certs.

When you've completed the certificate step, you should have **three** certificate files in the **AltairHL_emulator\certs** folder.

The files will be named:

- ca.crt
- client.key
- client.crt

