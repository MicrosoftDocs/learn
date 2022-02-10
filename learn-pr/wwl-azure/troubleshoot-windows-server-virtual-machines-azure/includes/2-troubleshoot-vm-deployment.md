When you deploy VMs on Azure, there are two common problems that you might face. These are:

- Provisioning failures

- Allocation failures

The following table describes these failure types.

| Failure type| Description|
| :--- | :--- |
| Provisioning| Occurs when the operating system image doesn't load. This can be caused by the installer incorrectly performing preparation steps. It can also result when the installed selects an incorrect setting during image capture from the portal.|
| Allocation| Occurs when the selected cluster or region doesn't have available resources for the VM. It can also occur when the requested VM size isn't supported.|

## Understand provisioning failures

You can receive errors when you:

- Upload or capture a specialized VM image as a generalized image. This causes a provisioning failure.

- Upload or capture a generalized VM image as a specialized image. This causes a provisioning timeout error.

The following table describes the errors you might encounter in the preceding situations.

| Operating system| Uploading specialized image| Uploading generalized image| Capturing specialized image| Capturing generalized image|
| :--- | :--- | :--- | :--- | :--- |
| Windows generalized| Provisioning timeout error with the VM stuck at the OOBE screen| No errors| Provisioning timeout error because the original VM is not usable as it is marked as generalized| No errors|
| Windows specialized| No errors| Provisioning failure error with the VM stuck at the OOBE screen because the new VM is running with the original computer name, username, and password| No errors| Provisioning failure error because the new VM is running with the original computer name, username, and password. Also, the original VM is not usable because it is marked as specialized|

> [!TIP]
> You must ensure that the type of the image doesn't change during the capture process to avoid errors when you deploy your custom image.
### Resolve upload errors

To resolve both errors that result during upload, use `Add-AzVhd` to upload the original VHD, available on-premises, with the same setting as that for the operating system (generalized/specialized).

> [!TIP]
> To upload as generalized, remember to run `sysprep` first.
### Resolve capture errors

To resolve both errors that result during capture:

1. Delete the current image from the portal.

1. Recapture it from the current VHDs with the same setting as that for the operating system (generalized/specialized).

## Understand allocation failures

Allocation errors occur when your new VM request is pinned to a cluster that:

- Cannot support the VM size being requested.

- Doesn't have available free space to accommodate your request.

### Resolve VM size allocation failures

If you receive this error, then:

- Retry your request with a smaller VM size.

- If you can't change the size, then:

   1. Stop all the VMs in your availability set.

   1. Create your new VM of your desired size.

   1. Start the new VM and then restart the other VMs.

### Resolve VM resource allocation failures

If you receive this error, then:

- Try again later.

- If your new VM could be part of a different availability set, then:

   1. Create your new VM in a different availability set in the same region.

   1. Add the new VM to the same virtual network.

