As system administrator at Contoso, you need to decide which entities to monitor; this includes considering which files and registry entries are critical to the company's operating systems, and the applications that employees need to run. You also know that many files and registry entries should remain unchanged; therefore, changes to those objects might indicate suspicious activity which you should investigate.

Conversely, there are many files and registry keys that you might reasonably expect to change, sometimes frequently. Monitoring those changes isn't efficient, and probably provides little, if any, benefit for security monitoring purposes.

## Which Windows objects should be monitored?

Microsoft Defender for Cloud recommends entities to monitor based on known attack patterns. These entities include files and Windows registry keys under `HKEY_LOCAL_MACHINE`. You can also create custom rules for files, folders, and registry keys that are important to your environment.

To review the recommended items, see [Choose what to monitor](/azure/defender-for-cloud/file-integrity-monitoring-overview#choose-what-to-monitor).

## Edit monitored entities

From the File Integrity Monitoring dashboard, open the rule configuration for the subscription. Review the recommended rules, remove rules that would create unnecessary noise, and add custom rules for critical resources that aren't covered.

Rules apply to the enabled subscription scope. You can define from one through 500 custom rules per subscription.

## Add a new entity to monitor

When you add a custom rule, provide a unique name and description, select at least one change type, and enter the file, folder, or registry path. Windows registry paths must begin with `HKLM`.

## Disable monitored entities

To stop monitoring an entity, edit or remove its rule from the subscription's File Integrity Monitoring configuration. Review rule changes carefully because they affect all machines in the enabled scope.

## Folder and path monitoring using wildcards

The file system in Windows Server is extensive. Manually configuring individual files for monitoring would take an extended period of time. Instead, you can use wildcards to help simplify tracking across directories. When you use wildcards, the following rules apply:

- A path can contain a maximum of three asterisks (`*`).
- Wildcards are allowed only at the start or end of a path segment.
- Windows file paths can contain letters, numbers, spaces, `_`, `.`, `\`, `*`, `?`, and `:`. They can't contain `/`.
- Windows registry paths must begin with `HKLM` and can use wildcards only at the start or end of a path segment.
- Paths can't exceed 260 characters.

Avoid broad paths that generate frequent expected changes. Excessive noise makes suspicious changes harder to identify.
