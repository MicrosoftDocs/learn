Group Policy settings present as GPOs in AD DS user interface tools, but a GPO actually includes two components.

## What are Group Policy containers and templates?

These two components are described in the following table.

:::row:::
  :::column:::
    **Component**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    The Group Policy container
  :::column-end:::
  :::column:::
    The Group Policy Objects container is located in Active Directory and it stores GPO metadata. It doesn't contain actual settings, but information on when GPO was created, how many times user and computer settings were modified, GPO version and its GUID (which is used to link Group Policy settings to a Group Policy template.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    The Group Policy template
  :::column-end:::
  :::column:::
    This template is a collection of files stored in the SYSVOL of each domain controller in the `%SystemRoot%\SYSVOL\Domain\Policies\GPOGUID` path, where GPOGUID is the globally unique identifier (GUID) of the Group Policy container. The Group Policy template contains the Group Policy settings.
  :::column-end:::
:::row-end:::


> [!NOTE]
> Similar to all AD DS objects, each Group Policy container includes a GUID attribute that uniquely identifies the object within AD DS.

When you change the settings of a GPO, the changes are saved to the SYSVOL share. By default, the domain controller that holds the PDC Emulator operations master role is used. Changes made are then replicated to other domain controllers.

> [!TIP]
> By default, when Group Policy refresh occurs, the client-side extensions apply settings in a GPO only if the GPO has been updated.

The Group Policy client can identify an updated GPO by its version number, as the following describes:

 -  Each GPO has a version number that increments each time you make a change.
 -  The version number is stored as a Group Policy container attribute and in a text file, GPT.ini, in the Group Policy template folder.
 -  The Group Policy client knows the version number of each GPO it has previously applied.
 -  If, during the Group Policy refresh, the Group Policy client discovers that the version number of the Group Policy container has changed, Windows Server will inform the client-side extensions that the GPO is updated.

## GPO replication

The Group Policy container and the Group Policy template both replicate between all domain controllers in the local domain in AD DS. However, these two items use different replication mechanisms.

 -  The Group Policy container in AD DS replicates by using the Directory Replication Agent (DRA). The DRA uses a topology that the Knowledge Consistency Checker generates, which you can define or refine manually. The result is that the Group Policy container replicates within seconds to all domain controllers in a site and replicates between sites based on your intersite replication configuration.
 -  The Group Policy template in the SYSVOL replicates by using the Distributed File System Replication (DFS-R).

> [!CAUTION]
> Because the Group Policy container and Group Policy template replicate separately, it is possible for them to become out-of-sync for a brief time. Typically, when this happens, the Group Policy container will replicate to a domain controller first.

Systems that obtained their ordered list of GPOs from that domain controller will identify the new Group Policy container. Those systems will then attempt to download the Group Policy template, and they'll notice that the version numbers are not the same. A policy processing error will record in the event logs.

If the reverse happens, and the GPO replicates to a domain controller before the Group Policy container, clients that obtain their ordered list of GPOs from that domain controller won't be notified of the new GPO until the Group Policy container has replicated.
