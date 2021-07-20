Choose the best response for each question. Then select Check your answers.

## Multiple Choice
Which of the following describes container groups?
( ) Container groups have three containers.  {{That's incorrect. Container groups have two containers. One container listens on port 80, while the other listens on port 1433.}}
( ) Container groups expose a single private IP address, with one exposed port.  {{That's incorrect. Container groups exposes a single public IP address, with one exposed port.}}
(x) Container groups are scheduled on a single host machine. {{That's correct. Container groups are scheduled on a single host machine.}}

## Multiple Choice
Which of the following is a reason to select virtual machines over containers?
(x) Virtual machines provide complete isolation from the host operating system and other VMs.  {{That's correct. Containers only provide lightweight isolation from the host and other containers, but don't provide as strong a security boundary as a virtual machine.}}
( ) Virtual machines run the user mode portion of an operating system and can be tailored to contain just the needed services for the app. {{That's incorrect. Virtual machines run a complete operating system including the kernel.}}
( ) Virtual machines use Azure Disks for local storage for a single node.   {{That's incorrect. Virtual machines use a virtual hard disk (VHD) for local storage for a single VM. }}

## Multiple choice
Which of the following is a feature of Azure Container Instances?
(x) Billing occurs when the container is in use. {{That's correct. Organizations are only billed when the container is in use.}}
( ) Containers require several minutes to load.  {{That's incorrect. Containers launch in seconds and that is an advantage over virtual machines.}}
( ) Containers use Azure blobs for retrieve and persist state. {{That's incorrect. Containers use Azure file shares to retrieve and persist state. }}

