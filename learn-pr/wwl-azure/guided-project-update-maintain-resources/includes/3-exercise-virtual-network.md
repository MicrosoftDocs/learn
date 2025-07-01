This procedure updates the virtual network created in Procedure 1 by adding a new subnet and configuring a network security group (NSG) to allow FTP traffic.

## Step 1: Add a Second Subnet
Expand the virtual network to include a new subnet for file servers.

1. Go to **Virtual networks** and select the virtual network created earlier.
2. Under **Settings**, click **Subnets**.
3. Click **+ Subnet**.
4. Name the subnet `fileServers`.
5. Specify an address range that does not overlap with `primarySubnet`.
6. Click **Add**.

## Step 2: Create a Network Security Group
Create an NSG to control traffic to the new subnet.

1. Search for **Network security groups** and click **+ Create**.
2. Select the resource group and region.
3. Enter a name for the NSG (e.g., `ftp-nsg`).
4. Click **Review + create**, then **Create**.

## Step 3: Add an FTP Rule to the NSG
Allow FTP traffic through the NSG.

1. Go to the newly created NSG.
2. Under **Settings**, click **Inbound security rules**.
3. Click **+ Add**.
4. Set the following:
   - Source: Any
   - Source port ranges: *
   - Destination: Any
   - Destination port ranges: 21
   - Protocol: TCP
   - Action: Allow
   - Priority: 100
   - Name: `Allow-FTP`
5. Click **Add**.

## Step 4: Associate NSG with Subnet
Apply the NSG to the `fileServers` subnet.

1. Go to the virtual network and select **Subnets**.
2. Click on `fileServers`.
3. Under **Network security group**, select the NSG created above.
4. Click **Save**.
