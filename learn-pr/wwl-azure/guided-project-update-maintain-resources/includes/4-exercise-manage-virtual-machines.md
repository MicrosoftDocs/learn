This procedure modifies the virtual machine created earlier by changing its subnet, scaling its size, attaching storage, and configuring auto-shutdown.

## Step 1: Change the Assigned Subnet
Move the VM to the `fileServers` subnet.

1. Stop the VM from the **Virtual machines** blade.
2. Go to **Networking** under the VM settings.
3. Click **Detach network interface**.
4. Create a new network interface in the `fileServers` subnet.
5. Attach the new interface to the VM.
6. Start the VM.

## Step 2: Vertically Scale the VM
Increase the VM size to improve performance.

1. Go to the VM and click **Size** under **Settings**.
2. Select the next larger size (e.g., `Standard_B1ms`).
3. Click **Resize**.
:::image type="content" source="../media/virtual-machine-overview.png" alt-text="Screenshot of the virtual machine overview blade.":::

## Step 3: Add Attached Storage
Attach a new disk to the VM.

1. Go to the VM and click **Disks**.
2. Click **+ Add data disk**.
3. Create a new managed disk with minimal size (e.g., 10 GB).
4. Click **Save**.

## Step 4: Set Auto-Shutdown
Configure the VM to shut down daily at 9PM.

1. Go to the VM and click **Auto-shutdown** under **Operations**.
2. Enable auto-shutdown.
3. Set the time to 9:00 PM.
4. Click **Save**.
