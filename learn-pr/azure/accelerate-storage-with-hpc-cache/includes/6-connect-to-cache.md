After the storage targets are successfully created, it's time to define the namespace and join the NFS clients to the Azure HPC Cache.

## Define Namespace

TODO: Add steps for defining the namespace.

## Client Requirements

NFS clients require network access, installed NFS utilities, and a local path for the `mount` command.

- Client machines need network access to the cache's virtual network and private subnet.
- Install the NFS utilities using either `sudo yum install -y nfs-utils` or `sudo apt-get install nfs-common`.
- Create a local directory on each client using a command like `sudo mkdir -p /mnt/hpc-cache/target`. Copy this command.

## Copy Mount Instructions

Azure HPC Cache provides a `mount` command that you can copy and paste for your NFS clients.

- With the cache open in the Azure Portal, click the "Mount Instructions" tab on the left.
- In the "Client path" field, paste the full `sudo mkdir` command.
- Choose a cache mount address. Rotate these addresses across the clients to evenly distribute the network traffic.
- Choose your virtual namespace path from the dropdown.
- The mount field automatically populates so you can click the copy button to copy the command to the clipboard.

## Run HPC Workload

Now that the clients are configured to access the Azure HPC Cache, they can begin their HPC workloads.
