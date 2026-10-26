In this exercise, prepare a self-managed Elasticsearch cluster on three Azure VMs and install Kibana on a separate VM. Use authenticated HTTPS requests and a synthetic document to confirm that the nodes form one cluster. It's a disposable learning environment, not a production migration. Links to the guidance referenced in this exercise are in the summary's **More info** section.

Unless a step explicitly says **administrator workstation**, run command examples in Bash in an SSH session on the named **Ubuntu VM**, not in local Windows PowerShell. Run each block in order and stop if a command fails. Substitute every angle-bracket placeholder with your own value. Don't use the RPM commands from other vendor tutorials.

## 1. Prepare the lab

Elastic 9.5.5 is the published release selected for this revision. Before starting, check the Elastic Support Matrix and version policy; if this release no longer receives maintenance, use an approved maintained release consistently across the stack and recheck its installation instructions.

Use the following reference configuration with synthetic data only:

| Setting | Lab value |
| --- | --- |
| Resource group | A new `elastic-on-azure-vm-rg` |
| Region | East US 2, or another approved region with the required quota and sizes |
| OS image | Ubuntu Server 24.04 LTS, x64, Generation 2 |
| Elastic packages | Elasticsearch and Kibana 9.5.5 |
| VMs | `es-node1`, `es-node2`, `es-node3`, and `kibana-node` |
| Size of each VM | `Standard_D2s_v5`: 2 vCPUs and 8 GiB RAM |
| Storage per VM | 64 GiB persistent managed OS disk, Standard SSD LRS; no ephemeral OS disk |
| Network | `elastic-lab-vnet`, address space `10.42.0.0/16`; subnet `elastic-lab-subnet`, `10.42.0.0/24` |
| Private addresses | `es-node1`: `10.42.0.10`; `es-node2`: `10.42.0.11`; `es-node3`: `10.42.0.12`; `kibana-node`: `10.42.0.20` |
| Administrator | `azureuser`, authenticated with an SSH public key |
| Outbound connectivity | Standard NAT Gateway and its Standard public IP, or an approved existing egress path |

Confirm resource-creation permissions, at least eight available regional vCPUs, and sufficient Dsv5-family quota. These VM sizes are a starting configuration for this small lab, not a performance guarantee. In the Azure pricing calculator, estimate four VMs, four managed disks, NAT Gateway, its public IP, data processing/transfer, and any administrator connectivity resources. Record region, currency, anticipated runtime, and any substituted sizes.

You need an administrator workstation with SSH/SCP and **routed private connectivity** to this subnet, for example through an approved existing VPN. The workstation's browser must also reach the private Kibana address. Obtain the administrator source IP range that the subnet will actually see, and confirm that the proposed VNet range doesn't overlap connected networks. If it overlaps, choose a different range and replace the example addresses throughout this exercise.

> [!IMPORTANT]
> Establish an approved administrator network path before provisioning the lab. NAT Gateway provides outbound internet connectivity, not administrator ingress. An Azure portal login, an ordinary Cloud Shell session, or a Bastion SSH session alone doesn't give your local browser a route to private Kibana. Don't work around missing connectivity by exposing the application VMs publicly.

For browser HTTPS, either obtain an approved certificate/private key whose subject alternative name covers the Kibana private IP or follow the lab-only certificate-generation procedure in step 8. Your browser must trust its issuer. If your organization's policy doesn't allow a temporary lab CA, arrange an approved certificate before proceeding.

> [!IMPORTANT]
> This lab isn't a migration target for live sales data. A production design additionally needs measured capacity, fault-domain planning, restore-tested snapshots, monitoring, and an upgrade/recovery plan.

## 2. Provision the Azure resources

Create the exercise-only resource group. If the name already exists, choose a different name rather than reusing the group. Create the VNet and subnet from step 1, then establish the approved routed administrator path. Don't put shared VPN or other shared infrastructure in this disposable resource group.

Use the Create a Linux VM in the Azure portal guide for the creation flow, but override its example settings:

1. Create each of the four VMs with the image, size, and administrator from step 1. Use your approved SSH public key and retain the corresponding private key on the workstation, not on a VM.
1. On **Disks**, select a 64 GiB managed OS disk with **Standard SSD** storage. This lab uses the package's default `/var/lib/elasticsearch` data directory on that persistent OS disk. Production workloads should be sized separately, usually with dedicated managed data disks.
1. On **Networking**, select `elastic-lab-vnet` and `elastic-lab-subnet`. Set **Public IP** to **None** and **Public inbound ports** to **None**. Apply these settings to Kibana as well as all Elasticsearch nodes. Don't create a load balancer, install NGINX, or open port 80.
1. Select **Review + create**, review validation and pricing, then select **Create** and complete any SSH-key confirmation. Wait for deployment completion.
1. Before installing Elastic, open each VM's **Networking** > **Network settings**, select its network interface, then **IP configurations** > its primary IP configuration. Set private-IP assignment to **Static** and the address from step 1, then save. An address change can restart the VM; wait for completion before connecting. Leave Ubuntu's network interface configured by DHCP rather than manually changing its guest IP.

See the guidance on static private IP configuration, managed disks, and Elasticsearch data paths. Don't put cluster data on temporary storage. A successful Azure deployment doesn't yet mean Elasticsearch is installed.

## 3. Configure connectivity before downloading packages

For a new NAT-based lab, follow the **Create the NAT gateway** section of Create a Standard NAT Gateway. Create `elastic-lab-nat` in the lab resource group and region, create its Standard public IP `elastic-lab-egress-ip`, and associate the gateway with `elastic-lab-subnet`. Don't repeat that quickstart's VM or Bastion deployment. The public IP belongs to the gateway, not to any VM. If an approved firewall/egress path already exists, use it instead; don't alter shared routing or add NAT indiscriminately.

Allow DNS resolution, time synchronization, and the Ubuntu and Elastic package endpoints through that egress path. NAT alone isn't an outbound content filter.

> [!NOTE]
> Don't assume that a new private subnet provides internet connectivity. Current Azure portal defaults and the applicable newer network API behavior require explicit outbound connectivity. Existing virtual networks aren't all automatically changed. See Azure outbound connectivity guidance.

Create `elastic-lab-nsg` in the lab resource group and associate it with `elastic-lab-subnet`. Add the following **inbound** rules before connecting. Use **IP Addresses** for explicit source/destination addresses, **Any** for source ports, and replace `<administrator-source-CIDR>` with the approved routed source range. Each comma-separated list represents multiple IP addresses in one augmented rule.

| Priority | Name | Protocol / destination port | Sources | Destinations | Action |
| --- | --- | --- | --- | --- | --- |
| 100 | AllowAdminSSH | TCP / 22 | `<administrator-source-CIDR>` | `10.42.0.10,10.42.0.11,10.42.0.12,10.42.0.20` | Allow |
| 110 | AllowElasticsearchTransport | TCP / 9300 | `10.42.0.10,10.42.0.11,10.42.0.12` | `10.42.0.10,10.42.0.11,10.42.0.12` | Allow |
| 120 | AllowElasticsearchHTTPS | TCP / 9200 | `10.42.0.10,10.42.0.11,10.42.0.12,10.42.0.20` | `10.42.0.10,10.42.0.11,10.42.0.12` | Allow |
| 130 | AllowAdminKibana | TCP / 5601 | `<administrator-source-CIDR>` | `10.42.0.20` | Allow |
| 200 | DenyOtherLabIngress | Any / Any | Any | `10.42.0.0/24` | Deny |

The deny rule is essential: Azure's default `AllowVNetInBound` rule otherwise permits other VNet traffic. Lower numeric priorities are evaluated first. Retain the default outbound rules for this disposable NAT-based lab; organizational egress filtering is separate. Match any guest firewall rules to these flows and inspect both subnet and NIC effective rules. NSGs are stateful, so response traffic for allowed outbound connections doesn't need an extra inbound allow. These rules assume the routed workstation prerequisite; a different management design needs corresponding rules. See the guidance on NSG rule evaluation.

From the **administrator workstation**, connect to each VM using its private address, for example:

```console
ssh -i "<ssh-private-key-path>" azureuser@10.42.0.10
```

Verify SSH host identity through your approved process. On each VM, run `sudo apt-get update` and resolve any DNS, routing, or repository errors before continuing.

## 4. Install and start the first Elasticsearch node

On `es-node1`, configure the official APT repository. Repeat this repository block later on each of the other three VMs before installing its package. These commands are for fresh Ubuntu hosts; don't add a duplicate Elastic repository to an existing installation.

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg unzip
curl --fail --silent --show-error https://artifacts.elastic.co/GPG-KEY-elasticsearch \
  -o /tmp/elastic-signing-key.asc
gpg --show-keys --with-fingerprint /tmp/elastic-signing-key.asc
```

Compare the primary-key fingerprint with `4609 5ACC 8548 582C 1A26 99A9 D27D 666C D88E 42B4` in the Debian installation guide. If it differs, stop and check the official guidance rather than importing an unverified key.

```bash
sudo gpg --dearmor --output /usr/share/keyrings/elasticsearch-keyring.gpg \
  /tmp/elastic-signing-key.asc
sudo chmod 644 /usr/share/keyrings/elasticsearch-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/9.x/apt stable main" \
  | sudo tee /etc/apt/sources.list.d/elastic-9.x.list
sudo apt-get update
```

Install the exact release and record the installed version:

```bash
sudo apt-get install -y elasticsearch=9.5.5
dpkg-query -W -f='${Package} ${Version}\n' elasticsearch
```

Use the bundled JDK. If the requested version can't be installed, stop and check package availability and the maintenance policy; don't silently install a different version on one node.

Before starting **each Elasticsearch node**, review the system-configuration guidance. Disable swap for these dedicated lab hosts with `sudo swapoff -a`, and comment out any swap entries in `/etc/fstab`; also disable any image-specific mechanism that recreates swap. Check `swapon --show` again after an OS reboot. Check `sysctl vm.max_map_count`; if below `1048576`, set `vm.max_map_count=1048576` in `/etc/sysctl.conf`, run `sudo sysctl --system`, and check again. The package may configure this automatically, so inspect the effective value instead of adding conflicting definitions.

The package configures service limits. Inspect them using `systemctl show elasticsearch -p LimitNOFILE -p LimitNPROC`; use the system-configuration guidance if bootstrap checks fail. Keep automatic heap sizing and the default node roles.

Open `/etc/elasticsearch/elasticsearch.yml` with `sudoedit`. Following the package guide's **Set up a node as the first node in a cluster** section, edit existing settings rather than appending duplicate keys:

```yaml
cluster.name: es-on-azure
transport.host: 10.42.0.10
transport.port: 9300
http.host: 0.0.0.0
http.port: 9200
```

Retain the default node name, the package-generated TLS/keystore settings, and the initial bootstrap entry for this first node. Don't replace the whole file or set `discovery.seed_hosts` before this initial bootstrap. The HTTP binding includes loopback for local checks and the private interface for enrollment and Kibana; it's appropriate here only because no VM has a public IP and network access is restricted.

Enable and start the package service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
sudo systemctl status elasticsearch.service --no-pager
```

For a Debian/systemd installation, set or reset the built-in administrator password with the documented tool; don't wait for an interactive-start password message:

```bash
sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic
```

Store the generated credential securely. Don't paste it into the module, commands, screenshots, or a shared document. Check the local HTTPS endpoint; `curl` prompts for the password:

```bash
sudo curl --fail --silent --show-error \
  --cacert /etc/elasticsearch/certs/http_ca.crt \
  --user elastic "https://localhost:9200/"
```

Confirm the expected cluster name and installed version. Inspect the generated configuration and logs to confirm that security, HTTP TLS, and transport TLS are enabled, with the required certificates/keystore entries present. A working HTTP endpoint alone doesn't prove transport TLS. If startup, TLS setup, or HTTPS fails, inspect the Elasticsearch logs and the automatic-configuration exceptions before proceeding. Don't disable security, add an incomplete manual TLS configuration, or discard an existing data directory to get past a failure.

## 5. Enroll the other Elasticsearch nodes

On `es-node2`, repeat step 4's repository setup, exact-version package installation, and OS prerequisite checks, but **don't start its service or copy the first node's bootstrap configuration**. On the running first node, create a node enrollment token:

```bash
sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s node
```

On `es-node2`, use the token with the Debian/RPM reconfiguration tool before the first service start:

```bash
sudo /usr/share/elasticsearch/bin/elasticsearch-reconfigure-node \
  --enrollment-token "<node-enrollment-token>"
```

Review and confirm the reconfiguration prompt. In `elasticsearch.yml`, set `cluster.name: es-on-azure`, `transport.host: 10.42.0.11`, `transport.port: 9300`, `http.host: 0.0.0.0`, and `http.port: 9200`. Retain the generated certificate, trust, and discovery configuration. Use the service commands from step 4 to enable and start the service, then confirm that it joins the original cluster.

As soon as the second node joins, perform step 6 on the first two nodes before any restart. Then repeat the enrollment sequence for `es-node3`, using `transport.host: 10.42.0.12` and a newly generated token, and apply step 6 to all three nodes. Tokens expire after 30 minutes. Treat them as temporary credentials. A token created with `-s kibana` can't enroll an Elasticsearch node. Don't bootstrap three independent clusters and attempt to merge their data directories.

See the Debian guide's Reconfigure a node to join an existing cluster section.

## 6. Consolidate discovery configuration

As soon as the second node has joined, update the first node's discovery configuration before any restart. After all three nodes have joined, check the configuration on **every** node.

Remove `cluster.initial_master_nodes` from the established cluster's configuration, and set `discovery.seed_hosts` to stable private addresses of the three master-eligible nodes:

```yaml
discovery.seed_hosts:
  - "10.42.0.10:9300"
  - "10.42.0.11:9300"
  - "10.42.0.12:9300"
```

Don't reintroduce `cluster.initial_master_nodes` when restarting or adding nodes. Use the Debian guide's Update the config files section. This matters even when initial enrollment appears to have succeeded.

## 7. Check cluster membership and health

On `es-node1`, run authenticated HTTPS requests:

```bash
sudo curl --fail --silent --show-error \
  --cacert /etc/elasticsearch/certs/http_ca.crt \
  --user elastic "https://localhost:9200/_cat/nodes?v"

sudo curl --fail --silent --show-error \
  --cacert /etc/elasticsearch/certs/http_ca.crt \
  --user elastic "https://localhost:9200/_cluster/health?pretty"
```

Expect three nodes in the intended cluster. Check roles, the elected master, and that no health condition is being concealed. For this three-node lab with allocatable replicas, require green health before declaring success; investigate unassigned shards rather than treating any HTTP 200 response as success.

From the other nodes, verify the same `cluster_uuid` using step 4's local HTTPS root request and the same cluster administrator password. After discovery consolidation, run `sudo systemctl restart elasticsearch.service` on **one node at a time**, allowing each to rejoin and the cluster to recover before restarting another. This is a lab check, not a substitute for the production rolling-restart procedure.

## 8. Install Kibana and configure HTTPS

On `kibana-node`, repeat step 4's repository setup, then install Kibana, **not Elasticsearch**:

```bash
sudo apt-get install -y kibana=9.5.5
dpkg-query -W -f='${Package} ${Version}\n' kibana
```

### Prepare the browser certificate

If you already have an approved server certificate and corresponding private key, securely transfer them to `kibana-node` and continue with **Install the certificate and enroll Kibana**. Include the necessary intermediate certificates in the server certificate file. Its subject alternative name must cover `10.42.0.20`, or use your approved DNS name consistently in the certificate and browser URL.

Otherwise, with approval to trust a temporary lab CA, run the following on **es-node1**. It creates a separate, short-lived CA for browser-to-Kibana HTTPS; it **doesn't** replace Elasticsearch's automatically configured CA or transport certificates.

```bash
sudo install -d -m 700 /root/elastic-lab-pki
sudo /usr/share/elasticsearch/bin/elasticsearch-certutil ca --pem \
  --days 30 --out /root/elastic-lab-pki/kibana-ca.zip
sudo unzip /root/elastic-lab-pki/kibana-ca.zip -d /root/elastic-lab-pki
sudo /usr/share/elasticsearch/bin/elasticsearch-certutil cert --pem \
  --name kibana-server --ip 10.42.0.20 --days 30 \
  --ca-cert /root/elastic-lab-pki/ca/ca.crt \
  --ca-key /root/elastic-lab-pki/ca/ca.key \
  --out /root/elastic-lab-pki/kibana-server.zip
sudo unzip /root/elastic-lab-pki/kibana-server.zip -d /root/elastic-lab-pki
install -d -m 700 "$HOME/kibana-tls"
sudo install -o azureuser -g azureuser -m 600 \
  /root/elastic-lab-pki/kibana-server/kibana-server.crt "$HOME/kibana-tls/"
sudo install -o azureuser -g azureuser -m 600 \
  /root/elastic-lab-pki/kibana-server/kibana-server.key "$HOME/kibana-tls/"
sudo install -o azureuser -g azureuser -m 600 \
  /root/elastic-lab-pki/ca/ca.crt "$HOME/kibana-tls/kibana-lab-ca.crt"
sudo openssl x509 -in /root/elastic-lab-pki/ca/ca.crt -noout -fingerprint -sha256
```

Keep the CA private key on `es-node1`; never copy it to the workstation or Kibana VM. This lab uses filesystem-protected, unencrypted PEM server keys. For production, use your organization's PKI and key-protection process. The certificate utility reference describes the options.

On the **administrator workstation**, change to a private, nonsynchronized directory accessible only to your account. Download the three staged files over SSH, then upload only the server certificate and server private key to Kibana. Use the correct SSH key for each VM:

```console
scp -i "<es-node1-ssh-private-key-path>" azureuser@10.42.0.10:kibana-tls/kibana-server.crt .
scp -i "<es-node1-ssh-private-key-path>" azureuser@10.42.0.10:kibana-tls/kibana-server.key .
scp -i "<es-node1-ssh-private-key-path>" azureuser@10.42.0.10:kibana-tls/kibana-lab-ca.crt .
scp -i "<kibana-ssh-private-key-path>" kibana-server.crt kibana-server.key azureuser@10.42.0.20:
```

Confirm the downloaded CA's SHA-256 certificate fingerprint matches the one displayed on `es-node1`. Import **only `kibana-lab-ca.crt`** into the trust store used by your lab browser, following your platform and organization policy. Record that trust change for cleanup. Never import a private key as a trusted root, bypass a certificate warning, or distribute this lab CA for general use.

### Install the certificate and enroll Kibana

On **kibana-node**, install the PEM files:

```bash
sudo install -o root -g kibana -m 640 "$HOME/kibana-server.crt" /etc/kibana/kibana-server.crt
sudo install -o root -g kibana -m 640 "$HOME/kibana-server.key" /etc/kibana/kibana-server.key
rm -- "$HOME/kibana-server.crt" "$HOME/kibana-server.key"
```

If using an organizational certificate, adapt the source filenames. If its private key is encrypted, supply `server.ssl.keyPassphrase` using the Kibana keystore, rather than publishing it in an example. The Kibana private-key passphrase setting reference describes its purpose.

Open `/etc/kibana/kibana.yml` with `sudoedit` and configure the private listener and browser TLS, editing existing keys rather than creating duplicates:

```yaml
server.host: "10.42.0.20"
server.port: 5601
server.ssl.enabled: true
server.ssl.certificate: /etc/kibana/kibana-server.crt
server.ssl.key: /etc/kibana/kibana-server.key
```

Leave the Elasticsearch connection settings unconfigured until enrollment. See the Kibana HTTPS guidance for certificate permissions and browser trust.

Generate a fresh Kibana enrollment token on an Elasticsearch node:

```bash
sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
```

On **kibana-node**, start the service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable kibana.service
sudo systemctl start kibana.service
sudo systemctl status kibana.service --no-pager
```

Record the six-digit verification code in the service status, or inspect `sudo journalctl -u kibana.service --no-pager` if needed. In the workstation browser, open `https://10.42.0.20:5601` (or the approved DNS name). Supply the Kibana enrollment token, select **Configure Elastic**, and supply the verification code if prompted. If the token has expired, generate another one. Follow the Debian enrollment flow. Log in with `elastic` for initial administration, then create appropriately scoped users for routine work.

Confirm that Kibana connects to the intended cluster using HTTPS and trusts its Elasticsearch HTTP CA. Browser-to-Kibana trust and Kibana-to-Elasticsearch trust are separate; **don't replace enrollment's Elasticsearch CA with the browser's lab CA**.

After enrollment, update the existing `elasticsearch.hosts` setting to include all three nodes:

```yaml
elasticsearch.hosts:
  - "https://10.42.0.10:9200"
  - "https://10.42.0.11:9200"
  - "https://10.42.0.12:9200"
```

Preserve the enrollment-generated service-account authentication and `elasticsearch.ssl.certificateAuthorities` settings. Restart Kibana with `sudo systemctl restart kibana.service` and confirm access again. See the multiple-node connection guidance.

> [!NOTE]
> This exercise provisions one Kibana VM. It demonstrates installation, not Kibana high availability. A production multi-instance deployment requires the shared settings described in the preceding unit.

## 9. Verify a synthetic document

Use Kibana's Dev Tools Console during initial administration. Create a dedicated lab index with an explicit replica:

```http
PUT module-lab-check
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 1
  }
}

PUT module-lab-check/_doc/1?refresh=wait_for
{
  "message": "Azure VM lab connectivity check"
}

GET module-lab-check/_doc/1

GET _cluster/health/module-lab-check?wait_for_status=green&timeout=60s

GET _cat/shards/module-lab-check?v
```

Confirm that the document response contains `"found": true` and the expected message. The health response must have `"status": "green"` and `"timed_out": false`. The shard response must show one primary (`p`) and one replica (`r`), both `STARTED` on different nodes. A response with HTTP 200 alone isn't sufficient.

In Kibana, find **Data Views** using global search, create a data view with index pattern `module-lab-check`, and select **I don't want to use the time filter** because the document has no timestamp field. Open **Discover**, select this data view, and locate the message. See the Create a data view guide.

Don't use real transactions, credentials, or customer data as a payload. An optional ingestion project using Logstash is separate from this exercise; see the summary's next steps.

## 10. Troubleshoot without weakening the configuration

Use the following checks to troubleshoot common problems without disabling security controls:

| Symptom | Check |
| --- | --- |
| SSH or browser connection times out | Workstation route, actual source IP range, subnet/NIC effective NSG rules, guest firewall, listener address, and service status |
| Package download fails | DNS and explicit outbound connectivity, correct repository, signing key, and availability of the exact package version |
| A node fails to start | `/var/log/elasticsearch/es-on-azure.log`, system settings, memory/disk capacity, duplicate YAML keys, and bootstrap configuration |
| Node enrollment fails | A fresh `node`-scoped token, first-node HTTPS reachability, private transport connectivity, matching versions and cluster name |
| Certificate error | Correct issuing CA, certificate expiration and subject alternative name, matching server key, and service read permissions; never use `curl -k` |
| Kibana doesn't start | `sudo journalctl -u kibana.service --no-pager`, certificate/key format and permissions, Elasticsearch hosts, and enrollment settings |
| Yellow/red health | Shard state and `GET _cluster/allocation/explain` in Dev Tools; correct the allocation cause rather than setting replicas to zero |

## 11. Clean up

> [!WARNING]
> Resource-group deletion permanently removes the resources and their data. Inspect the group first and continue only if it contains exclusively disposable exercise resources. Don't delete a shared network, a production deployment, or data you need to retain.

In the Azure portal, open the exercise resource group, review its contents, select **Delete resource group**, and complete the name/confirmation prompt. Wait for deletion to finish. Check for lab resources created outside that group, including disks, snapshots, public IPs, and egress resources. Remove only resources belonging to this exercise. Have the network administrator remove lab-specific connectivity configuration if necessary, without deleting shared connectivity services.

Remove the downloaded server private key and other temporary certificate copies from the workstation. Remove only the temporary lab CA trust entry you added, using its recorded fingerprint; don't remove organizational trust anchors. Delete lab-specific SSH private keys only if they aren't used elsewhere. Deleting the VM resource group doesn't remove workstation files or trust-store entries.

Stopping a service or shutting down the guest OS isn't complete Azure cleanup. Deallocation stops VM compute charges but doesn't necessarily stop charges for retained storage or networking. See the guidance on VM billing states.
