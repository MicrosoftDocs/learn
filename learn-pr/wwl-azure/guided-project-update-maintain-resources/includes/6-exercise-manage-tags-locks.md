This procedure demonstrates how to apply tags and locks to Azure resources for better management and protection.

## Step 1: Add a Delete Lock to the VM

1. Go to the VM created earlier.
2. Click **Locks** under **Settings**.
3. Click **+ Add**.
4. Name the lock and select **Delete** as the lock type.
5. Click **OK**.

## Step 2: Add a Purpose Tag to the VM

1. Go to the VM and click **Tags**.
2. Add a tag with:
   - Name: `PURPOSE`
   - Value: `file-server`
3. Click **Save**.

## Step 3: Review Tagged Resources

1. In the Azure Portal, search for **Tags**.
2. Click on the `file-server` tag value.
3. Review all resources associated with this tag.
