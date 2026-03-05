After you install and configure the Microsoft Purview Information Protection scanner, the next step is to run it. The scanner can operate in **discovery mode** to analyze content without enforcing protection or in **enforcement mode** to apply sensitivity labels and encryption.

## Run a discovery scan

Start by running a discovery scan to identify sensitive content without making any changes to files. This helps validate that the scanner is working correctly and provides insight into where sensitive data resides.

You can start the scan in one of two ways:

**In the Microsoft Purview portal**:

1. Go to **Settings** > **Information Protection** > **Information protection scanner** > **Content scan jobs**
1. Select your job, then select **Scan now**.

**Using PowerShell**:
Run this command:

``` powershell
Start-Scan
```

The scanner crawls all configured repositories and logs its findings.

## Monitor scan progress

Track the scan's status using the portal or PowerShell:

- **Portal**: Refresh the scan job status and look for updates in the **LAST SCAN RESULTS** and **LAST SCAN (END TIME)** columns.
- **PowerShell**: Run `Get-ScanStatus` to check scan status.

## View scan reports

When the scan finishes, reports are saved locally on the scanner server:

``` shell
%localappdata%\Microsoft\MSIP\Scanner\Reports
```

Reports include:

- `.txt` summary files with scan time, number of scanned files, and detection counts
- `.csv` files with detailed results for each file

The scanner sends data to the Microsoft Purview portal about every five minutes. The portal displays results for the most recent scan only.

## Apply labels and protection

After you review the discovery results, update the scan job to enforce your labeling policies. In the scan job settings, turn on **Enforce sensitivity labeling policy** and, if applicable, **Enable DLP rules** to apply data loss prevention.

To switch to enforcement mode using PowerShell:

``` powershell
Set-ScannerContentScan -Schedule Always -Enforce On
```

## Stop a scan

To stop a scan that's currently running:

- **Portal**: Select the scan job then select **Stop scan**.
- **PowerShell**: Run `Stop-Scan`.

## Rescan files

After the first scan, only new or modified files are scanned. To apply updated policies or label changes across all content, start a full rescan.

To start a full rescan:

- **Portal**: Go to the scan job and select **Rescan all files**.
- **PowerShell**: Run `Start-Scan` with updated policy settings.

If prompted after making changes to the scan job, be sure to choose No when asked if you want to skip a full rescan.
