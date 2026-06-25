For Azure NetApp Files NFS volumes or dual-protocol volumes with the Unix security style, you have the option to set the Unix permissions and the change ownership mode (Chown Mode) options.

You can specify these settings during volume creation or after volume creation.

### Configure Unix permissions

- The Azure NetApp Files Unix Permissions functionality enables you to specify change permissions for the mount path.
- The Unix permissions setting is set to 0770 by default.
- This default setting grants read, write, and execute permissions to the owner and the group, but no permissions are granted to other users.
- You can specify a custom Unix permissions value (for example, 0755) to give the desired permission to the owner, group, or other users.
- The setting does not apply to the files under the mount path.

#### Considerations

- The Unix permissions you specify apply only for the volume mount point (root directory).
- You can modify the Unix permissions on the source volume but not on the destination volume that is in a cross-region replication configuration.

To modify Unix permissions, right-click the **volume**, and select **Edit**. In the Edit window that appears, specify a value for **Unix Permissions**.

:::image type="content" source="../media/unix-permissions-edit.png" alt-text="Screenshot of Edit dialog showing Unix Permissions set to 0777." border="true" lightbox="../media/unix-permissions-edit.png":::

### Change ownership mode

The change ownership mode (**Chown Mode**) functionality enables you to set the ownership management capabilities of files and directories.

Two options available for Chown Mode are:

- Restricted (default) - Only the root user can change the ownership of files and directories.
- Unrestricted - Non-root users can change the ownership for files and directories that they own.

:::image type="content" source="../media/export-policy-chown-mode.png" alt-text="Screenshot showing export policy rule with Chown Mode dropdown expanded." border="true" lightbox="../media/export-policy-chown-mode.png":::
