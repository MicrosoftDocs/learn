## Snapshot-based backups

To make sure that the snapshot script runs successfully, make sure that Perl is installed on the Linux operating system on the HANA Large Instances server. Perl comes preinstalled on your HANA Large Instance unit. To check the Perl version, use the following command:

```bash
perl –v

```

## Set up storage snapshots

To set up storage snapshots with HANA Large Instances, follow these steps:

1.  Install the SAP HANA HDB client.
2.  Modify the **/etc/ssh/ssh\_config** to add the line `MACs hmac-sha1`
3.  Create an SAP HANA backup user account on the leading node for each SAP HANA instance you run, if applicable.
4.  Install the SAP HANA HDB client on all the SAP HANA Large Instances servers.
5.  On the first SAP HANA Large Instances server of each region, create a public key to access the underlying storage infrastructure that controls snapshot creation.
6.  Copy the scripts and configuration file from GitHub to the location of hdbsql in the SAP HANA installation.
7.  Modify the HANABackupDetails.txt file as necessary for the appropriate customer specifications.

If you run an MCOD scenario with multiple SAP HANA instances on one HANA Large Instance unit, you have separate storage volumes provisioned for each of the SAP HANA instances.

### Step 1: Install the SAP HANA HDB client

The Linux operating system installed on SAP HANA on Azure (Large Instances) includes the folders and scripts necessary to run SAP HANA storage snapshots for backup and disaster recovery purposes. Check for more recent releases in GitHub at [https://github.com/Azure/hana-large-instances-self-service-scripts/tree/master/snapshot\_tools\_v4.x](https://github.com/Azure/hana-large-instances-self-service-scripts/). Different scripts might have different minor releases within the same major release. It's your responsibility to install the SAP HANA HDB client on the HANA Large Instance units while you install SAP HANA.

### Step 2: Change the /etc/ssh/ssh\_config

Follow instructions in the **Enable communication with storage** section of the [Manual recovery of snapshot with HANA Studio document](https://github.com/Azure/hana-large-instances-self-service-scripts/blob/master/guides/Manual%20recovery%20of%20snapshot%20with%20HANA%20Studio.pdf).

### Step 3: Create a public key

To enable access to the storage snapshot interfaces of your HANA Large Instance tenant, establish a sign-in procedure through a public key.

On the first SAP HANA on Azure (Large Instances) server in your tenant, create a public key to access the storage infrastructure. With a public key, a password isn't required to sign in to the storage snapshot interfaces. You also don't need to maintain password credentials with a public key.

To generate a public key, follow instructions in the **Enable communication with storage** section of the [Manual recovery of snapshot with HANA Studio document](https://github.com/Azure/hana-large-instances-self-service-scripts/blob/master/guides/Manual%20recovery%20of%20snapshot%20with%20HANA%20Studio.pdf).

### Step 4: Create an SAP HANA user account

To start the creation of SAP HANA snapshots, create a user account in SAP HANA that the storage snapshot scripts can use. Create an SAP HANA user account within SAP HANA Studio for this purpose. The user must be created under the SYSTEMDB and not under the SID database for MDC. In the single container environment, the user is created in the tenant database. This account must have **Backup Admin** and **Catalog Read** privileges.

For details, refer to the **Enable communication with SAP HANA** section of the [Manual recovery of snapshot with HANA Studio document](https://github.com/Azure/hana-large-instances-self-service-scripts/blob/master/guides/Manual%20recovery%20of%20snapshot%20with%20HANA%20Studio.pdf).

### Step 5: Authorize the SAP HANA user account

In this step, you authorize the SAP HANA user account that you created so that the scripts don't need to submit passwords at runtime. The SAP HANA command hdbuserstore enables the creation of an SAP HANA user key. The key is stored on one or more SAP HANA nodes. The user key lets the user access SAP HANA without having to manage passwords from within the scripting process.

> [!IMPORTANT]
> Run the command with the same user context that the snapshot commands are run in. Otherwise, the snapshot commands won't work properly.

### Step 6: Get the snapshot scripts, configure the snapshots, and test the configuration and connectivity

Download the [most recent version of the scripts from GitHub](https://github.com/Azure/hana-large-instances-self-service-scripts/). For details regarding their usage, refer to the [Manual recovery of snapshot with HANA Studio document](https://github.com/Azure/hana-large-instances-self-service-scripts/blob/master/guides/Manual%20recovery%20of%20snapshot%20with%20HANA%20Studio.pdf).

### Step 7: Perform snapshots

When the preparation steps are finished, you can start to configure and schedule the actual storage snapshots. The script to be scheduled works with SAP HANA scale-up and scale-out configurations. For periodic and regular execution of the backup script, schedule the script by using the cron utility.

For details, refer to the **Perform snapshot backup - azure\_hana\_backup** section in the [Manual recovery of snapshot with HANA Studio document](https://github.com/Azure/hana-large-instances-self-service-scripts/blob/master/guides/Manual%20recovery%20of%20snapshot%20with%20HANA%20Studio.pdf).

When the script azure\_hana\_backup runs, it creates the storage snapshot in the following three phases:

1.  It runs an SAP HANA snapshot.
2.  It runs a storage snapshot.
3.  It removes the SAP HANA snapshot that was created before the storage snapshot ran.

To run the script, call it from the HDB executable folder to which it was copied.

The retention period is administered with the number of snapshots that are submitted as a parameter when you run the script. The amount of time that's covered by the storage snapshots is a function of the period of execution, and of the number of snapshots submitted as a parameter when the script runs.

If the number of snapshots that are kept exceeds the number that are named as a parameter in the call of the script, the oldest storage snapshot of the same label is deleted before a new snapshot runs. The number you give as the last parameter of the call is the number you can use to control the number of snapshots that are kept. With this number, you also can control, indirectly, the disk space that's used for snapshots.
