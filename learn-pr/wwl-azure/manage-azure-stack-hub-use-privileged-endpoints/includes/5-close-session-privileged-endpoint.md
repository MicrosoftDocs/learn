You close a session by using the `Close-PrivilegedEndpoint` cmdlet. This cmdlet closes the endpoint and transfers the log files to an external file share for retention.

To close the endpoint session:

1.  Create an external file share that's accessible by the PEP.
2.  Run the following cmdlet:

```
Close-PrivilegedEndpoint -TranscriptsPathDestination "\\fileshareIP\SharedFolder" -Credential Get-Credential

```

The cmdlet uses the parameters in the following table:

:::row:::
  :::column:::
    **Parameter**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **Type**
  :::column-end:::
  :::column:::
    **Required**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    TranscriptsPathDestination
  :::column-end:::
  :::column:::
    Path to the external file share defined as "fileshareIP\\sharefoldername"
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Credential
  :::column-end:::
  :::column:::
    Credentials to access the file share.
  :::column-end:::
  :::column:::
    SecureString
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
