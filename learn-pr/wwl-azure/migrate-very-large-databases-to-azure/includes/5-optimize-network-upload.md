

Jumbo Frames are ethernet frames larger than the default 1500 bytes. Typical Jumbo Frame sizes are 9000 bytes. An increase of the frame size on the source DB server, all intermediate network devices such as switches, and the Intel R3load servers reduce CPU consumption and increases network throughput. The Frame Size must be identical on all devices otherwise resource-intensive conversion occurs.

Additional networking features such as Receive Side Scaling (RSS) can be switched on or configured to distribute network processing across multiple processors Running R3load servers on VMware has proven to make network tuning for Jumbo Frames and RSS more complex and isn't recommended unless there very expert skill level available.

R3load exports data from DBMS tables and compresses this raw format-independent data in dump files. These dump files need to be uploaded into Azure and imported to the Target SQL Server database.

The performance of the copy and upload to Azure of these dump files is a critical component in the overall migration process.

There are two basic approaches for upload of R3load dump files:

## Copy from on-premises R3load export servers to Azure blob storage via Public Internet with AzCopy

On each of the R3load servers run a copy of AzCopy with this command line:

```bash
Azcopy copy "C:\ExportServer_1\Dumpfiles" "https://[storage_account].blob.core.windows.net/ExportServer_1/Dumpfiles?[SAS_Token]" --recursive
```

:::image type="content" source="../media/4-intel-r3load-servers-running-r3load-320bdf60.png" alt-text="Diagram illustrating copying from on-premises R 3 load export servers to Azure blob storage via Public Internet with A z Copy.":::

You can increase throughput by setting the AZCOPY\_CONCURRENCY\_VALUE environment variable. This variable specifies the number of concurrent requests that can occur.

If your computer has fewer than 5 CPUs, then the \[value\] of this variable is set to 32. Otherwise, the default value is equal to 16 multiplied by the number of CPUs. The maximum default value of this variable is 300, but you can manually set this value higher or lower:

:::row:::
  :::column:::
    **Operating system**
  :::column-end:::
  :::column:::
    **Command**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Windows
  :::column-end:::
  :::column:::
    `set AZCOPY_CONCURRENCY_VALUE=[value]`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Linux
  :::column-end:::
  :::column:::
    `export AZCOPY_CONCURRENCY_VALUE=[value]`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    macOS
  :::column-end:::
  :::column:::
    `export AZCOPY_CONCURRENCY_VALUE=[value]`
  :::column-end:::
:::row-end:::

Use the azcopy env to check the current value of the AZCOPY\_CONCURRENCY\_VALUE environment variable. If the value is blank, then you can read which value is being used by looking at the beginning of any AzCopy log file. The selected value, and the reason it was selected, are reported there.

Before you set the concurrency value, run a benchmark test. The benchmark test process reports the recommended concurrency value. Alternatively, if your network conditions and payloads vary, set this variable to the word AUTO instead of to a particular number. The AUTO value causes AzCopy to always run the same automatic tuning process that it uses in benchmark tests.

If a customer has a powerful server and fast internet the concurrency value can be increased. If the concurrency value is increased too high, connection to the R3load export server is lost due to network saturation. Monitor the network throughput in Windows Task Manager. Copy throughput of over 1 Gigabit per second per R3load Export Server can be easily achieved. Copy throughput can be scaled up by having more R3load servers (four are depicted in the previous diagram).

A similar script needs to be run on the R3load Import servers in Azure to copy the files from Blob onto a file system that R3load can access.

## Copy from on-premises R3load export servers to an Azure VM or blob storage via a dedicated ExpressRoute connection using AzCopy, Robocopy, or a similar tool

```bash
Robocopy C:\Export1\Dump1 \\az_imp1\Dump1 /MIR /XF *.SGN /R:20 /V /S /Z /J /MT:8 /MON:1 /TEE /UNILOG+:C:\Export1\Robo1.Log
```

The block diagram following illustrates four Intel R3load servers running R3load. In the background, Robocopy is started uploading dump files. When entire split tables and packages are completed the SGN file is copied either manually or via a script. When the SGN file for a package arrives on the import R3load server, it triggers import for this package automatically.

:::image type="content" source="../media/4-intel-r3load-servers-running-r3load-320bdf60.png" alt-text="Block diagram illustrating 4 Intel R 3 load servers running R 3 load.":::

> [!NOTE]
> Copying files over NFS or Windows SMB protocols is not as fast or robust as mechanisms such as AzCopy. It is recommended to test performance of both file upload techniques. It is recommended to notify Microsoft Support for VLDB migration projects as very high throughput network operations might be misidentified as Denial of Service attacks.
