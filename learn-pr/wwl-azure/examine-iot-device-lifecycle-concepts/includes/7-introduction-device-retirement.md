Device retirement includes replacing or decommissioning devices after a failure, upgrade cycle, or at the end of the service lifetime. The device twin can be used to maintain device info if the physical device is being replaced, or archived if the device is being retired. Use the IoT Hub identity registry for securely revoking device identities and credentials.

## Disable devices

You can disable devices by updating the status property of an identity in the identity registry. Typically, you use this property in two scenarios:

 -  During a provisioning orchestration process.
 -  If for any reason, you think a device is compromised or has become unauthorized.

The disable feature is not available for modules.
