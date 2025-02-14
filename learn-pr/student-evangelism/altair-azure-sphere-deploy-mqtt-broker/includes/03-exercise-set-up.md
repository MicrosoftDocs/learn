In this exercise, you'll learn how to install your own Mosquitto MQTT broker. This unit is an advanced topic and assumes you're comfortable with Linux.

You can run a private Mosquitto MQTT broker on an Azure virtual machine. Running a private MQTT broker will help you securely connect to Azure Sphere from anywhere.

MQTT messages between the web terminal and Altair emulator need to be signed and encrypted with client certificates. The easiest and free way to create TLS certificates is to create a self-signed certificate authority (CA) certificate. You create client keys and certificates by using the self-signed CA certificate.

Installing the Mosquitto MQTT broker on Linux is the easiest option because most package managers have the latest builds included. Use the procedures in this exercise to set up an Azure virtual machine running Ubuntu 20.04 LTS.

> [!NOTE]
> To minimize costs, the MQTT broker can be run on a *General purpose B1 SKU* virtual machine that can be stopped when it's not in use.

The following blog post from K21 Academy is a great guide to installing an Ubuntu server on Azure: [Create and Connect an Ubuntu Virtual Machine in Azure](https://k21academy.com/microsoft-azure/admin/how-to-create-and-connect-an-ubuntu-virtual-machine-in-azure/).

## Create an Ubuntu virtual server

1. Open the Azure portal. From the main menu, select **Create a resource**.
1. Search for **Virtual machine** and select **Create**.
1. Create a resource group, name your virtual machine, and select a location. Name the image **Ubuntu Server 20.04 LTS Gen 1**, and set the size to **Standard_B1ls - 1 vcpu, 0.5 GIB memory**. Select **SSH public key**, and then name your key pair the same as your virtual machine name.
1. Select **Next: Disks >**, and then select **Standard HDD** or **Standard SSD LRS**.
1. Select **Review + create**.
1. Select **Create**.
1. Download the SSH private key and store it in your *~/.shh* folder.

It takes about a minute to deploy the virtual machine.

## Configure the virtual machine

1. Select **Go to resource**.
1. Select **DNS name not configured**. Then set up the DNS name and set the desired **idle timeout** value. We recommend that you increase the idle timeout.
1. Select **Save**.
1. Select your browser's **Back** button to return to the virtual machine's **Overview** pane.
1. Copy the DNS name to Notepad, because you'll need it when configuring the certificates.
1. Select the **Networking** pane to set up inbound port rules by using the **Add inbound port rule** button. Add the following rules:

    | Destination port  | Protocol     | Name   | Priority  | Description     |
    | --- | --- | --- | --- | --- |
    |  80     | TCP    | Port_80     | 310 | Let's Encrypt certificate renewal |
    |  8884   |  TCP   | Port_8884   | 311 | MQTT, encrypted, client certificate required  |
    |  8091   |  TCP   | Port_8091   | 312 | MQTT over WebSockets, encrypted, authenticated   |

## Enable just-in-time access

1. Select the **Configuration** pane.
1. Select **Enable just-in-time**.

## Connect to the virtual machine from your desktop

1. Select the **Connect** pane.
1. Set **Source IP** to **My IP**.
1. Select **Request access**.
1. From your desktop, SSH into the virtual machine:

    ```bash
    ssh -i <private key path> <username>@<host dns name>
    ```

    It might take a minute or two the first time you connect.

## Configure Ubuntu

1. Apply any OS updates:

    ```bash
    sudo apt update && sudo apt -y upgrade
    ```

1. Install the required software:

    ```bash
    sudo apt install -y mosquitto mosquitto-clients python3-pip && \
    sudo pip3 install paho-mqtt
    ```

## Help secure the Mosquitto MQTT broker

The following steps set up certificates to help secure the communications between the Altair emulator and the web terminal. The result will be a self-signed certificate that's valid for two years (730 days).

1. Create a Bash `CommonName` variable set to the DNS name of your Ubuntu server:

    ```bash
    CommonName=<Your Ubuntu Server DNS Name>
    ```

1. Create a temporary working folder:

    ```bash
    mkdir -p ~/mosquitto_certs && cd ~/mosquitto_certs
    ```

1. Create the self-signed CA certificate:

    ```bash
    openssl req -new -x509 -days 730 -nodes -extensions v3_ca -keyout ca.key -out ca.crt
    ```

    When you're creating a self-signed CA certificate, you can use the default value, but the common name (CN) *must* match the DNS name of your server.

1. Create the server certificate:

    ```bash
    openssl genrsa -out server.key 2048 && \
    openssl req -new -out server.csr -key server.key -subj "/CN=$CommonName" && \
    openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 730 && \
    openssl rsa -in server.key -out server.key
    ```

1. Generate the Mosquitto client certificates:

    ```bash
    openssl genrsa -out client.key 2048 && \
    openssl req -new -out client.csr -key client.key -subj "/CN=$CommonName" && \
    openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 730 && \
    openssl rsa -in client.key -out client.key
    ```

1. Grant read access to the keys:

    ```bash
    sudo chmod a+r *.key
    ```

1. Copy certificates to the Mosquitto folder:

    ```bash
    sudo cp ca.crt /etc/mosquitto/ca_certificates &&
    sudo cp server.crt /etc/mosquitto/ca_certificates &&
    sudo cp server.key /etc/mosquitto/ca_certificates
    ```

## Install Let's Encrypt

[Let's Encrypt](https://letsencrypt.org?azure-portal=true) is a nonprofit certificate authority that provides TLS certificates to 260 million websites. We're going to use a free Let's Encrypt certificate to help secure the MQTT messages between the web terminal and the Mosquitto MQTT broker.

The following instructions walk you through installing the Certbot ACME client on the Ubuntu server. Let's Encrypt-issued certificates expire after six months. The Certbot client ensures that the certificates are updated before they expire.

For more information, see the [instructions on the Certbot site](https://certbot.eff.org/lets-encrypt).

1. Copy and paste the following block of commands into the SSH session and then select the **Enter** key:

    ```bash
    sudo snap install core; sudo snap refresh core && \
    sudo snap install --classic certbot && \
    sudo ln -s /snap/bin/certbot /usr/bin/certbot && \
    sudo certbot certonly --standalone
    ```

1. When you're prompted, enter your email address and confirm terms and conditions.
1. When you're prompted for the domain name of your server, enter the domain name that you copied to Notepad.

The installation process takes around five minutes. When it's finished, you can test that the renewal process works by using the following command:

```bash
sudo certbot renew --dry-run
```

You can view the Let's Encrypt certificates by using the following command:

```bash
sudo ls -all /etc/letsencrypt/live/$CommonName
```

## Create the username and password for the web terminal

The web terminal will use the Let's Encrypt certificate to encrypt MQTT traffic over the internet. The web terminal will also authenticate with the MQTT broker by using the username and password.

The following command will create the MQTT broker's password file and will prompt you to enter a password for the *WebTerminal* username:

```bash
sudo mosquitto_passwd -c /etc/mosquitto/passwd WebTerminal
```

Note down the username and password, because you'll need them to configure the static web app for the web terminal.

## Configure the Mosquitto MQTT broker

You need to tell the Mosquitto broker what ports to listen on and where the certificates are.

1. Run the following command to copy the following configuration to the */etc/mosquitto/conf.d/default.conf* file:

    ```bash
    sudo sh -c "cat > /etc/mosquitto/conf.d/default.conf" << 'EOL'
    per_listener_settings true

    listener 1883 localhost
    allow_anonymous true

    listener 8884
    allow_anonymous false
    cafile /etc/mosquitto/ca_certificates/ca.crt
    keyfile /etc/mosquitto/ca_certificates/server.key
    certfile /etc/mosquitto/ca_certificates/server.crt
    require_certificate true
    use_identity_as_username true
    tls_version tlsv1.2

    listener 8091
    password_file /etc/mosquitto/passwd
    allow_anonymous false
    protocol websockets
    certfile /etc/letsencrypt/live/YOUR_DOMAIN_NAME/cert.pem
    cafile /etc/letsencrypt/live/YOUR_DOMAIN_NAME/chain.pem
    keyfile /etc/letsencrypt/live/YOUR_DOMAIN_NAME/privkey.pem
    EOL
    ```

1. Update the *YOUR_DOMAIN_NAME* placeholder with the domain name of your server by using the Linux `sed` command:

    ```bash
    sudo sed -i "s/YOUR_DOMAIN_NAME/$CommonName/g" /etc/mosquitto/conf.d/default.conf
    ```

## Test the Mosquitto broker

A useful troubleshooting tip for the Mosquitto broker is to start in interactive mode to ensure that there are no problems.

1. You need to stop Mosquitto first, and then start in interactive mode. Select **Ctrl+C** to exit Mosquitto interactive mode, and then enter the following command:

    ```bash
    sudo systemctl stop mosquitto && sudo mosquitto -c /etc/mosquitto/conf.d/default.conf
    ```

1. Update the web terminal configuration:

    1. Start Visual Studio Code.
    1. From the Visual Studio Code main menu, select **File** > **Open folder**.
    1. Open the *Cloud-Enabled-Altair-on-Azure-Sphere* folder that you cloned or downloaded.
    1. Open the *Altair_Web_Terminal* folder.
    1. Click **Select Folder** or the **OK** button to open the project.
    1. Go to the Altair web terminal's *api* folder.
    1. Open the *local.settings.json* file.
    1. Update these properties:
        * `"MQTT_BROKER"`: `"THE_DNS_NAME_OF_YOUR_VIRTUAL_MACHINE"`
        * `"MQTT_PASSWORD"`: `"YOUR_WebTerminal_USERNAME_PASSWORD"`

1. Upload the Altair web terminal's local settings:

    1. Still in Visual Studio Code, select the **F1** key.
    1. Type **static local**, and then select **Azure Static Web Apps: Upload Local Settings**.
    1. Select your subscription.
    1. Select **Static Web App**. For the name, enter **AltairWebTerminal**.
    1. Select the environment by entering **Production**.
    1. You're prompted to overwrite existing settings. Select **Yes to all**.
    
3. Start the web terminal and select **Connect**.

4. Observe the Mosquitto broker's interactive output. It should look similar to the following output:

    ```text
    1625795690: mosquitto version 1.6.9 starting
    1625795690: Config loaded from /etc/mosquitto/conf.d/default.conf.
    1625795690: Opening ipv4 listen socket on port 1883.
    1625795690: Opening ipv4 listen socket on port 8884.
    1625795690: Opening ipv6 listen socket on port 8884.
    1625795690: Opening websockets listen socket on port 8091.
    1625795897: New client connected from ::ffff:133.233.133.233 as altair1625795897993 (p2, c1, k30, u'WebTerminal').
    ```

## Update the Altair emulator configuration

Update the Altair emulator to connect to your new Mosquitto MQTT broker:

1. Copy the new CA and client certificates to the Altair emulator's *certs* folder. The easiest way is from the file explorer. Browse to the *certs* folder and open a new terminal or PowerShell window.
1. Run the `scp` command to copy the certificates from your Mosquitto virtual machine to the *certs* folder. The following command assumes that you copied your virtual machine's private key to the *~/.ssh* folder:

    ```bash
    scp -i ~/.ssh/<your_private_key>.pem <username>@<host_dns_name>:~/mosquitto_certs/* .
    ```

1. Open the Altair emulator project in Visual Studio Code. Update the `ALTAIR_MQTT_HOST` definition in the *cmake/altair_config.cmake* file with the DNS name of your Mosquitto broker:

    ```cmake
    add_compile_definitions(ALTAIR_MQTT_HOST="REPLACE_WITH_YOUR_VIRTUAL_MACHINE_DNS_NAME")    
    ```

1. Save the *altair_config.cmake* file. This step will autogenerate the CMake cache.

1. Update the `AllowedConnections` section of *app_manifest.json* to the new domain name of the virtual machine. Remove the entry for `test.mosquitto.org`, because you'll no longer use that endpoint.
1. Redeploy the Altair emulator to Azure Sphere.
1. Check the web terminal. You should see the Altair emulator prompt to enter **MEMORY SIZE**.
1. Check the output from the Mosquitto broker running in interactive mode. It should look similar to the following code:

    ```text
    1625797134: mosquitto version 1.6.9 starting
    1625797134: Config loaded from /etc/mosquitto/conf.d/default.conf.
    1625797134: Opening ipv4 listen socket on port 1883.
    1625797134: Opening ipv4 listen socket on port 8884.
    1625797134: Opening ipv6 listen socket on port 8884.
    1625797134: Opening websockets listen socket on port 8091.
    1625797263: New client connected from ::ffff:133.233.133.233 as altair1625797264017 (p2, c1, k30, u'WebTerminal').
    1625797626: New connection from 133.233.133.233 on port 8884.
    1625797627: New client connected from 133.233.133.233 as altair1234567 (p2, c1, k60, u'your-domain-name.australiaeast.cloudapp.azure.com').

## Start the Mosquitto MQTT broker in daemon mode

1. Stop the interactive instance of the Mosquitto Broker by selecting **Ctrl+C**.
1. Start the Mosquitto broker in daemon mode:

    ```bash
    sudo systemctl enable mosquitto && sudo systemctl start mosquitto
    ```

## Run the Python virtual disk server on the virtual machine

Running the Python virtual disk server on the virtual machine will significantly improve performance, because it eliminates the round trip to the MQTT server from your desktop.

Clone the Altair project to the virtual machine:

```bash
cd ~/ && git clone --depth 1 https://github.com/AzureSphereCloudEnabledAltair8800/AzureSphereAltair8800.git Altair8800Emulator
```

## Autostart the virtual disk server

1. Enter the following command:

    ```bash
    sudo chmod 744 ~/Altair8800Emulator/AltairPY_virtual_disk_server/pyvdisk.sh
    ```

1. Copy the Python virtual disk server into the */opt* directory:

    ```bash
    sudo cp -r ~/Altair8800Emulator/AltairPY_virtual_disk_server /opt/pyvdisk
    ```

1. Install the startup service:

    ```bash
    sudo cp ~/Altair8800Emulator/AltairPY_virtual_disk_server/pyvdisk.service /etc/systemd/system
    ```

1. Reload `systemd` units:

    ```bash
    sudo systemctl daemon-reload
    ```

1. Start the Python virtual disk service:

    ```bash
    sudo systemctl start pyvdisk.service
    ```

1. Check the status of the Python virtual disk service:

    ```bash
    sudo systemctl status pyvdisk.service
    ```

## Troubleshoot

The `mosquitto_pub` and `mosquitto_sub` tools are useful for testing the certificates.

1. On the virtual machine, enter:

    ```bash
    cd ~/mosquitto_certs
    ```

 1. Enter the following command:
 
    ```bash
    mosquitto_pub -h <REPLACE_WITH_YOUR_DOMAIN_NAME> -t "test" -m "hello world" -p 8884 --capath . --cafile ca.crt  --cert client.crt --key client.key
    ```

    If `mosquitto_pub` fails, an error message will appear. The most likely cause is that the CA common name does not match the fully qualified domain name of your virtual machine.

### Test your certificates on the server

Enter the following command block:

```bash
mosquitto_pub -h $(hostname) -t "test" -m "hello world" -p 8884 --capath . --cafile ca.crt  --cert client.crt --key client.key

mosquitto_sub -h $(hostname) -t "test" -p 8884 --capath . --cafile ca.crt  --cert client.crt --key client.key
```
