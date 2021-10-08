In this exercise, you'll learn how to install your own Mosquitto MQTT broker. This unit is an advanced topic and assumes you're comfortable with Linux.

## Where to install

You can run a private Mosquitto MQTT broker in an Azure Virtual Machine. Running a private MQTT broker will allow you to securely connect to your Azure Sphere from anywhere.

MQTT messages between the Web Terminal and Altair emulator need to be signed and encrypted with client certificates. The easiest and free way to create TLS certificates is to create a self-signed CA (Certificate Authority) certificate. You create client keys and certificates using the self-signed CA certificate.

## What to install

1. The Mosquitto MQTT broker.
1. Certificate tools.
1. Let's Encrypt support.

## Installing on Linux

Installing the Mosquitto MQTT broker on Linux is the easiest option as most package managers have the latest builds included.

## Installing a Mosquitto MQTT broker

Follow these steps to set up an Azure Virtual Machine running Ubuntu 20.04 LTS.

To minimize costs, the MQTT broker can be run on a **General purpose B1 SKU** virtual machine and the virtual machine can be stopped when not in use.

The following article is a great guide to installing an [Ubuntu Server on Azure](https://k21academy.com/microsoft-azure/az-104/az-104-create-and-connect-an-ubuntu-virtual-machine-in-azure?azure-portal=true).

## Create an Ubuntu Virtual Server

1. Open the Azure Portal. From the main **burger menu**, select **create a resource**.
1. Search for **Virtual machine**, and select create.
1. Create a resource group, name your virtual machine, select location, the image **Ubuntu Server 20.04 LTS Gen 1**, and set the size to **Standard_B1ls - 1 vcpu, 0.5 GIB memory**, select **SSH public key**, name your **key pair** the same as your Virtual machine name.
1. Select **Next: Disks >** and select **Standard HDD** or **Standard SSD LRS**.
1. Select **Review + create**.
1. Select **Create**.
1. Download the SSH private key and store in your ~/.shh folder.
1. It takes about a minute to deploy the Virtual Machine.

## Configure the Virtual Machine

1. Select **Go to resource**.
1. Select DNS name **Not configured** and set up the DNS name and set the desired **idle timeout**.
1. Recommend increasing the idle timeout.
1. Select **Save**.
1. Select your browser **back** button to return to the Virtual Machine **Overview** blade.
1. Copy the DNS name to notepad as you will need it when configuring the certificates.
1. Select the **Networking** blade to set up inbound port rules using the **Add inbound port rule** button. Add the following rules:

    | Destination Port  | Protocol     | Name   | Priority  | Description     |
    | --- | --- | --- | --- | --- |
    |  80     | TCP    | Port_80     | 310 | Let's Encrypt certificate renewal |
    |  8884   |  TCP   | Port_8884   | 311 | MQTT, encrypted, client certificate required  |
    |  8091   |  TCP   | Port_8091   | 312 | MQTT over WebSockets, encrypted, authenticated   |

## Enable Just-in-time access

1. Select the **Configuration** blade.
1. Select **Enable just-in-time**.

## Connect to the Virtual Machine from your desktop

1. Select the **Connect** blade.
1. Set the **Source IP** to **My IP**
1. Select **Request access**
1. From your desktop **SSH** into the Virtual Machine.

    ```bash
    ssh -i <private key path> <username>@<host dns name>
    ```

    It might take a minute or two the first time you connect.

## Configure Ubuntu

1. Apply any OS updates.

    ```bash
    sudo apt update && sudo apt -y upgrade
    ```

1. Install the required software

    ```bash
    sudo apt install -y mosquitto mosquitto-clients python3-pip && \
    sudo pip3 install paho-mqtt
    ```

## Secure the Mosquitto MQTT broker

The following steps are required to set up certificates to secure the communications between the Altair emulator and the Web Terminal.  The following will generate a self-signed certificate that is valid for two years (730 days).

1. Create a bash CommonName variable set to the DNS name of your Ubuntu Server.

    ```bash
    CommonName=<Your Ubuntu Server DNS Name>
    ```

1. Create a temporary working folder

    ```bash
    mkdir -p ~/mosquitto_certs && cd ~/mosquitto_certs
    ```

1. Create the self-signed CA Certificate

    When creating a self-signed CA certificate you can use the default value, **BUT**, the CN (Common Name) **MUST** match the DNS name of your server.

    ```bash
    openssl req -new -x509 -days 730 -nodes -extensions v3_ca -keyout ca.key -out ca.crt
    ```

1. Create the Server Certificate

    ```bash
    openssl genrsa -out server.key 2048 && \
    openssl req -new -out server.csr -key server.key -subj "/CN=$CommonName" && \
    openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 730 && \
    openssl rsa -in server.key -out server.key
    ```

1. Generate the Mosquitto client certificates

    ```bash
    openssl genrsa -out client.key 2048 && \
    openssl req -new -out client.csr -key client.key -subj "/CN=$CommonName" && \
    openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 730 && \
    openssl rsa -in client.key -out client.key
    ```

1. Grant read access to the keys

    ```bash
    sudo chmod a+r *.key
    ```

1. Copy certificates to the Mosquitto folder

    ```bash
    sudo cp ca.crt /etc/mosquitto/ca_certificates &&
    sudo cp server.crt /etc/mosquitto/ca_certificates &&
    sudo cp server.key /etc/mosquitto/ca_certificates
    ```

## Install Lets Encrypt

[Let's Encrypt](https://letsencrypt.org?azure-portal=true) is a nonprofit Certificate Authority providing TLS certificates to 260 million websites. We are going to use a free Let's Encrypt certificate to secure the MQTT messages between the Web Terminal and the Mosquitto MQTT broker.

Next, install the **Certbot** ACME client on the Ubuntu Server. Let's Encrypt issued certificates expire after six months. The Certbot ensures the certificates are updated before they expire.

The following are the [instructions for installing the Certbot on Ubuntu](https://certbot.eff.org/lets-encrypt/ubuntufocal-other?azure-portal=true).

1. The following ensures snapd is up to date and installs Certbot. Copy and paste the complete block of commands into the SSH session and press Enter.

    1. You will be prompted to enter your email address and confirm terms and conditions.
    1. You will be prompted for the domain name of your server. You copied the domain name to notepad.
    1. The process takes around 5 minutes to complete.

    ```bash
    sudo snap install core; sudo snap refresh core && \
    sudo snap install --classic certbot && \
    sudo ln -s /snap/bin/certbot /usr/bin/certbot && \
    sudo certbot certonly --standalone
    ```

    1. You can test the renewal process works with the following command.

    ```bash
    sudo certbot renew --dry-run
    ```

    1. You can view the Let's Encrypt certificates with the following command.

    ```bash
    sudo ls -all /etc/letsencrypt/live/$CommonName
    ```

## Create the Web Terminal username and password

The Web Terminal will use the Let's Encrypt certificate to encrypt MQTT traffic over the internet. The Web Terminal will also need to authenticate with the MQTT broker using username and password.

The following command will create the MQTT broker password file and will prompt you to enter a password for the **WebTerminal** username. Note down the username and password you create as they will be needed to configure the Web Terminal Static Web App.

1. Run the mosquitto password command.

    ```bash
    sudo mosquitto_passwd -c /etc/mosquitto/passwd WebTerminal
    ```

## Configure Mosquitto MQTT broker

We need to tell the Mosquitto Broker what ports to listen on and where the certificates are.

1. Run the following command to copy the following config to the /etc/mosquitto/conf.d/default.conf file.

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

1. Update the YOUR_DOMAIN_NAME placeholder with the domain name of your server using the Linux **sed** command.

    ```bash
    sudo sed -i "s/YOUR_DOMAIN_NAME/$CommonName/g" /etc/mosquitto/conf.d/default.conf
    ```

## Test the Mosquitto Broker

A useful troubleshooting tip for the Mosquitto Broker is to start up in interactive mode to ensure there are no issues.

1. We need to stop Mosquitto first then start in interactive mode. Press **ctrl+c** to exit Mosquitto interactive mode.

    ```bash
    sudo systemctl stop mosquitto && sudo mosquitto -c /etc/mosquitto/conf.d/default.conf
    ```

2. Update the Web Terminal configuration

    Open the Altair Web Terminal project

    1. Start Visual Studio Code.
    1. From the Visual Studio Code main menu, select **File**, then **Open folder**.
    1. Open the **Cloud-Enabled-Altair-on-Azure-Sphere** folder you cloned or downloaded.
    1. Open the **Altair_Web_Terminal** folder.
    1. **Select Folder** or the **OK** button to open the project.

    Update the **local.settings.json** file.

    1. Navigate to the Altair Web Terminal **api** folder.
    1. Open the **local.settings.json** file.
    1. Update the properties:
        * "MQTT_BROKER": "THE_DNS_NAME_OF_YOUR_VIRTUAL_MACHINE",
        * "MQTT_PASSWORD": "YOUR_WebTerminal_USERNAME_PASSWORD"

    Upload the Altair Web Terminal local settings

    1. Still in Visual Studio Code, press **F1**
    1. Type **static local**, and select **Azure Static Web Apps: Upload Local Settings...**.
    1. Select your subscription.
    1. Select the **Static Web App**. Enter the name your created **AltairWebTerminal**.
    1. Select environment. Enter **Production**.
    1. You will be prompted to overwrite existing settings. Confirm **Yes to all**.

    The setting will then be uploaded.

3. Start the Web Terminal and **Connect**

4. Observer the Mosquitto Broker interactive output. It will look similar to the following output:

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

We need to update the Altair emulator to connect to our new and secured Mosquitto MQTT broker.

1. Copy the new CA and Client certificates to the Altair emulator certs folder. The easiest way is from the file explorer. Navigate to the certs folder and open a new Terminal/Powershell window.
1. From the terminal window, we will run the **scp** to copy the certificates from our Mosquitto Virtual Machine to the certs folder. The following command assumes you copied your Virtual Machine private key to the ~/.ssh folder.

    ```bash
    scp -i ~/.ssh/<your_private_key>.pem <username>@<host_dns_name>:~/mosquitto_certs/* .
    ```

1. Open the Altair emulator project in Visual Studio Code and update the **ALTAIR_MQTT_HOST** definition in the **cmake/altair_config.cmake** file with the dns name of your Mosquitto broker.

    ```cmake
    add_compile_definitions(ALTAIR_MQTT_HOST="REPLACE_WITH_YOUR_VIRTUAL_MACHINE_DNS_NAME")    
    ```

1. Save the altair_config.cmake file, this will autogenerate the CMake cache.

1. Update the **app_manifest.json AllowedConnections** section the new Virtual Machine domain name. Remove the entry for test.mosquitto.org as you will no longer be using that endpoint.
1. Redeploy the Altair emulator to the Azure Sphere.
1. Check the Web Terminal, you should see the Altair emulator prompt to enter **MEMORY SIZE**.
1. Check the output from the Mosquitto Broker running in interactive mode. It should look similar to the following.

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

## Start the Mosquitto MQTT broker in daemon/service mode

1. Stop the interactive instance of the Mosquitto Broker with **ctrl+c**.
1. Start the Mosquitto broker in daemon mode.

    ```bash
    sudo systemctl enable mosquitto && sudo systemctl start mosquitto
    ```

## Run the Python Virtual Disk Server in the Virtual Machine

Running the Python Virtual Disk Server in the Virtual machine will significantly improve performance as it eliminates the round trip to the MQTT server from your desktop.

1. Clone the Altair project to the Virtual machine.

    ```bash
    cd ~/ && git clone --depth 1 https://github.com/AzureSphereCloudEnabledAltair8800/AzureSphereAltair8800.git Altair8800Emulator
    ```

## Autostart the Virtual Disk Server

    ```
    sudo chmod 744 ~/Altair8800Emulator/AltairPY_virtual_disk_server/pyvdisk.sh
    ```

1. Copy the Python Virtual Disk Server into the /opt directory.

    ```bash
    sudo cp -r ~/Altair8800Emulator/AltairPY_virtual_disk_server /opt/pyvdisk
    ```

1. Install the startup service

    ```bash
    sudo cp ~/Altair8800Emulator/AltairPY_virtual_disk_server/pyvdisk.service /etc/systemd/system
    ```

1. Reload systemd units.

    ```bash
    sudo systemctl daemon-reload
    ```

1. Start Python Virtual Disk Service

    ```bash
    sudo systemctl start pyvdisk.service
    ```

1. Check the status of the Python Virtual Disk Service

    ```bash
    sudo systemctl status pyvdisk.service
    ```

## Troubleshooting

The **mosquitto_pub** and **mosquitto_sub** tools are useful to test the certificates.

1. In the Virtual Machine

    ```bash
    cd ~/mosquitto_certs
    ```

    ```bash
    mosquitto_pub -h <REPLACE_WITH_YOUR_DOMAIN_NAME> -t "test" -m "hello world" -p 8884 --capath . --cafile ca.crt  --cert client.crt --key client.key
    ```

    If mosquitto_pub fails, an error message will be displayed. The most likely cause is the CA Common Name does not match the fully qualified domain name of your Virtual Machine.

### Test your certificates on the Server

```bash
mosquitto_pub -h $(hostname) -t "test" -m "hello world" -p 8884 --capath . --cafile ca.crt  --cert client.crt --key client.key

mosquitto_sub -h $(hostname) -t "test" -p 8884 --capath . --cafile ca.crt  --cert client.crt --key client.key
```
