After migration and before decommissioning the source, verify that all data has been transferred completely and correctly. Data validation confirms the migration is complete and gives you confidence to proceed with cutover.

## Completeness checks

Verify that the full data estate has been transferred:

- Compare total file and object counts between source and target.
- Compare total data volume. Account for differences in block sizes and metadata overhead between source and target file systems.
- Verify directory structure completeness: spot-check deeply nested paths and directories with large numbers of files.
- Check for skipped or failed items in the migration tool's logs. All managed tools, including Storage Mover, File Sync, and Data Box, produce detailed transfer logs.

## Integrity checks

Managed migration tools like Storage Mover or ISV solutions typically validate integrity automatically. If you use unmanaged tools, validate data before deleting it from the source.

Verify that the transfer didn't corrupt any data:

- AzCopy supports MD5 checksum validation using the `--check-md5` flag. Use this for critical datasets.
- Azure Storage Mover performs automatic checksum validation during transfer.
- For offline migrations (Data Box), the service validates checksums during the data hydration process.
- For large estates, consider sampling: verify checksums on a representative subset of files across different directories and file types.

## Metadata and permissions

File-level validation confirms the data is there. You also need to confirm that metadata and access controls have been preserved:

- Verify that file timestamps (created, modified) are preserved if required by your use case. Not all tools preserve all timestamp types.
- Check access control lists (ACLs) and NTFS permissions on the target, especially for SMB-based migrations to Azure Files.
- Verify that POSIX permissions are preserved for NFS migrations.
- Confirm that custom metadata or extended attributes have been transferred if applicable.

## Application-level validation

Beyond file-level checks, you need to validate that applications function correctly with the migrated data:

- Run application smoke tests against the target storage before full cutover.
- Verify that search indexes, catalogs, or databases referencing file paths are updated.
- Test read and write operations from each application that consumes the migrated data.

## Handling validation failures

When validation reveals issues, follow a structured approach to resolve them before proceeding:

- **Review migration tool logs first**: Skipped or failed items are typically logged with a reason (permission denied, path too long, unsupported characters, file locked). Address the root cause before re-running.
- **Re-run delta sync**: For items that failed due to transient issues (network interruption, source file locked during transfer), a delta sync pass typically picks up and transfers the missed items.
- **Path and naming conflicts**: Windows and Azure storage services have different rules for path length, reserved characters, and case sensitivity. Files that violate the target's naming rules are skipped silently by some tools. Identify these files and rename or restructure them on the source before retrying.
- **Escalation path**: Define in advance who is responsible for resolving validation issues, such as the storage admin, application owner, or migration vendor. Also define the maximum acceptable time to resolution before the cutover window is affected.

> [!TIP]
> Don't treat validation as a one-time step. Run completeness and integrity checks after every major sync pass, not just the final one. Catching issues early avoids delays during the cutover window.

## Validation sign-off

Establish a formal sign-off gate before proceeding to cutover. This ensures all stakeholders confirm that the migration meets their requirements:

- **Storage administrator**: Confirms file counts, data volume, and transfer logs show no unresolved errors.
- **Application owners**: Confirm that smoke tests pass and applications can read and write data on the target.
- **Security team**: Confirms that permissions, ACLs, and encryption settings on the target match the agreed security posture.
- **Compliance / records management**: For regulated data, confirms that retention policies, immutability settings, and audit trails are in place on the target.

Document the sign-off with a timestamp and the names of the approvers. This record is valuable for audit purposes and provides a clear decision point for proceeding to cutover.

## Source data retention after validation

Even after successful validation, keep the source data available as a safety net:

- Maintain the source in a read-only state for a defined retention period after cutover (for example, 30–90 days depending on your risk tolerance and regulatory requirements).
- Set a planned decommission date for the source at the start of the migration project. This avoids indefinite dual-storage costs and ensures the migration has a clear end state.
- If the source is on-premises hardware with a lease or contract end date, align the retention period with that deadline and communicate it to stakeholders.
- After the retention period expires with no issues reported, formally decommission the source and close out the migration project.

With validation complete and sign-off documented, you're ready to plan and execute the production cutover.