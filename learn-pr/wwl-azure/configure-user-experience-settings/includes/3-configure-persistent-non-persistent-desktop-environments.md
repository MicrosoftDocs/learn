Persistent virtual desktop saves the operating system state in between reboots. Other software layers of the virtual desktop solution provide the users easy and seamless access to their assigned VMs, often with a single sign-on solution.

There are several different implementations of persistent virtual desktop.

 -  **Traditional VMs**, where the VM has its own virtual disk file, starts up normally, and saves changes from one session to the next. The difference is how the user accesses this VM. There may be a web portal the user signs in to that automatically directs the user to one or more virtual desktop devices (VMs) assigned to them.
 -  **Image-based persistent VMs**, optionally with personal virtual disks (PVD). In this type of implementation, there is a base/gold image on one or more host servers. A VM is created, and one or more virtual disks are created and assigned to this disk for persistent storage.
    
     -  When the VM is started, a copy of the base image is read into the memory space of that VM. At the same time, a persistent virtual disk assigned to that VM, with any previous OS deltas is merged through a complex process.
     -  Changes such as event log writes and log writes are redirected to the read/write virtual disk assigned to that VM.
     -  In this circumstance, OS and app servicing may operate normally, using traditional servicing software such as Windows Server Update Services, or other management technologies.
 -  **Master/gold image**. The difference between a persistent virtual desktop device and a "normal" virtual desktop device is the relationship to the master/gold image. Eventually updates must be applied to the master. It is at this point where organizations decide how the user persistent changes are handled. In some cases, the disk with the user changes is discarded or reset. It may also be that the changes the user makes to the machine are kept through monthly Quality Updates, and the base is reset following a Feature Update.

## Non-persistent virtual desktop environments

When a non-persistent virtual desktop implementation is based on a base or "gold" image, the optimizations are mostly performed in the base image, and then through local settings and local policies.

With image-based non-persistent (NP) virtual desktop environments, the base image is read-only. When an NP virtual desktop device (VM) is started, a copy of the base image is streamed to the VM. Activity that occurs during startup and thereafter until the next reboot is redirected to a temporary location. Usually the users are provided network locations to store their data. In some cases, the user’s profile is merged with the standard VM to provide the user their settings.

One important aspect of NP virtual desktop that is based on a single image, is servicing. Updates to the operating system (OS) and components of the OS are delivered once per month. With image based virtual desktop environment, there is a set of processes that must be performed to get updates to the image:

 -  On a given host, all the VMs on that host, based from the base image must be shut down or turned off. This means the users are redirected to other VMs.
 -  In some implementations, this is referred to as "draining." The virtual machine or session host, when set to draining mode, stops accepting new requests, but continues servicing users currently connected to the device.
 -  In draining mode, when the last user logs off the device, that device is then ready for servicing operations.
 -  The base image is then opened and started up. All maintenance activities are then performed, such as OS updates, .NET updates, app updates, and so on.
 -  Any new settings that need to be applied are applied at this time.
 -  Any other maintenance is performed at this time.
 -  The base image is then shut down.
 -  The base image is sealed and set to go back into production.
 -  Users are allowed to log back on.

One of the challenges with non-persistent virtual desktop is that when a user logs off, nearly all the OS activity is discarded. The user’s profile and/or state may be saved to a centralized location, but the virtual machine itself discards nearly all changes that were made since last boot. Therefore, optimizations intended for a Windows computer that saves state from one session to the next are not applicable.
