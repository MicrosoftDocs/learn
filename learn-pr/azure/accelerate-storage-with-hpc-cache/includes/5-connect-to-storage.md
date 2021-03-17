After the Azure HPC Cache is created, it’s time to point it to your data. Ideally there’s an Express Route or high-speed connection between Azure and the data.

From the Home page of the Azure Portal, click the HPC Cache in your Recent Resources section. On the left navigation, choose “Storage Targets.”

## Storage Targets

An HPC Cache “storage target” is the NFS storage server like a NetApp or EMC Isilon where your HPC data is kept. Click the ‘Add Storage Target” button in the upper left.

In the new pane, provide a name for your storage target. This name doesn’t have the strict requirements that other fields have and can include spaces.

Leave the target type as NFS.

For the hostname, enter the fully qualified domain name of your storage server. Your custom DNS server will resolve this name.

### Usage Model

The “Usage model” field lets you choose the closest match for how you plan to use your cache. Based on your choice, Azure HPC Cache will apply several internal settings to optimize your cache for that workload type. If you decide later that your usage model has changed, you can change your selection.

[Explain the model options? Insert a table?]

Click OK at the bottom. The cache will begin establishing the connection to the storage server.
