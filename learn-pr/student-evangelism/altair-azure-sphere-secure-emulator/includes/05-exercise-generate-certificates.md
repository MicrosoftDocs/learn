In this exercise, you'll create the client certificates for the test.mosquitto.org MQTT broker.

## Install OpenSSL

Follow the instructions that apply to your operating system:

* **For Linux**, you might need to install OpenSSL, which you can do by using your Linux distributions package manager. For example, on Ubuntu, run: `sudo apt-get install openssl`.

* **For Windows**, do either of the following: 
   * Download OpenSSL from [openssl.org](https://wiki.openssl.org/index.php/Binaries?azure-portal=true).
   * Use [Windows Subsystem for Linux (WSL)](/windows/wsl/install-win10). Depending on the WSL Linux distribution you install, you might need to install OpenSSL, which you can do by using your Linux distributions package manager. For example, on Ubuntu, run: `sudo apt-get install openssl`.

## Delete the existing placeholder certificates

The *AltairHL_emulator\certs* folder contains three placeholder certificates. The placeholder certificates are required for the *build_all* validation process. Delete the placeholder certificates, because you'll be creating new certificates for the Altair emulator.

1. From your computer file manager, go to the *AltairHL_emulator\certs* folder.

2. Delete the following three placeholder certificates:

    - *ca.crt*
    - *client.key*
    - *client.crt*

## Download the Mosquitto Certificate Authority certificate

1. Download the Mosquitto Certificate Authority certificate [mosquitto.org.crt (PEM format)](https://test.mosquitto.org?azure-portal=true).
1. Rename the *mosquitto.org.crt* file to *ca.crt*.
1. Copy the *ca.crt* file to the *AltairHL_emulator\certs* folder.

## Generate the client certificates by using OpenSSL

1. Generate a private key:

    ```bash
    openssl genrsa -out client.key
    ```

1. Generate a certificate signing request (CSR).

    At a minimum, the CSR must contain values in the **Country**, **Organization**, and **Common Name** fields.

    The common name must match the [fully qualified domain name (FQDN)](https://en.wikipedia.org/wiki/Fully_qualified_domain_name?azure-portal=true) of the MQTT broker. When you're prompted to enter the common name, enter **test.mosquitto.org**.

    ```bash
    openssl req -out client.csr -key client.key -new
    ```

1. Open the *client.csr* file in your text editor, copy the CSR to the text box at [test.mosquitto.org](https://test.mosquitto.org/ssl/?azure-portal=true), and then select **Submit**. 

   The certificate is generated for you to download. It's valid for 90 days only.

1. Copy the *client.key* and *client.crt* files to the *AltairHL_emulator\certs* folder.

    The *AltairHL_emulator\certs* folder should now contain three certificate files:

    - *ca.crt*
    - *client.key*
    - *client.crt*

