TODO: Add intro

TODO: No "Space Game" -> Microsoft Learn - Ansible

## Create a service connection

Here, you create a service connection that enables Azure Pipelines to access your Azure subscription. Azure Pipelines uses this service connection to TODO:

1. In Azure DevOps, go to your **Space Game - web - Ansible** project.
1. Select **Project settings** from the bottom corner of the page.
1. Under **Pipelines**, select **Service connections**.
1. Select **+ New service connection** and then choose **SSH**.

    The **Add an SSH service connection** dialog appears.
1. From the dialog, fill in these fields:

    | Field               | Value                                        |
    |---------------------|----------------------------------------------|
    | **Connection name** | **SSH - Ansible VM** |
    | **Host name**     | Your VM's PIP, FE **23.102.38.60**           |
    | **Port number**    | **22**                      |
    | **User name**  | **azureuser**                   |
    | **Password or passphrase**  | Leave blank              |
    | **Private key**  | Your SSH private key                 |

1. Select **OK**.

    Azure DevOps performs a test connection to verify that it can connect to your Azure subscription. If Azure DevOps is unable to connect, you'll have the chance to sign in a second time.

Install Ansible addin for Azure Pipelines


Install add-in that provides access to the `Ansible@0` task in Azure Pipelines.

Knowledge: This add-in (could use commands or use this task, which handles many of the details for you.)

- https://marketplace.visualstudio.com/
- DevOps tab, "Ansible"
- Select
- **Get it free**
- Select org
- **Install**

#### Get starter code 

```bash
git fetch upstream ansible
git checkout -b ansible upstream/ansible
```

Modify *azure-pipelines.yml* like this:

```yml
trigger:
- '*'

stages:
- stage: 'Configure'
  displayName: 'Configure VMs'
  jobs: 
  - job: 'Configure'
    displayName: 'Configure VMs with Ansible'
    pool:
      vmImage: 'ubuntu-16.04'
    steps:
    - task: Ansible@0
      inputs:
        ansibleInterface: 'remoteMachine'
        connectionOverSsh: 'SSH - Ansible VM'
        playbookSourceRemoteMachine: 'agentMachine'
        playbookRootRemoteMachine: '$(System.DefaultWorkingDirectory)/ansible'
        playbookPathLinkedArtifactOnRemoteMachine: 'users.yml'
        inventoriesRemoteMachine: 'file'
        inventoryFileSourceRemoteMachine: 'agentMachine'
        inventoryFileLinkedArtifactOnRemoteMachine: 'ansible/azure_rm.yml'
        sudoEnabled: true
        sudoUser: 'azureuser'
        args: '--private-key ~/.ssh/id_ansible-vm'
```

Knowledge - how to add Ansible task using visual deigner

OLD - REMOVE

```yml
- task: Ansible@0
  inputs:
    ansibleInterface: 'agentMachine'
    playbookPathOnAgentMachine: 'users.yml'
    inventoriesAgentMachine: 'inlineContent'
    inventoryInlineDynamicAgentMachine: true
    inventoryInlineContentAgentMachine: |
      plugin: azure_rm
      include_vm_resource_groups:
      - learn-ansible-rg
      auth_source: auto

      keyed_groups:
      - prefix: tag
        key: tags
```

Add, commit, push

```bash
git add azure-pipelines.yml
git commit -m "Configure virtual machines with Ansible"
git push origin ansible
```

Watch it run

Eureka!

### See repair in action

From CloudShell, remove user

See the user.

```bash
IP_ADDRESS=$(az vm list-ip-addresses \
  --resource-group learn-ansible-rg \
  --name vm1 \
  --query [0].virtualMachine.network.publicIpAddresses[0].ipAddress \
  --output tsv)
ssh -i ~/.ssh/id_ansible-vm azureuser@$IP_ADDRESS "/usr/bin/getent passwd testuser1"
```

Remove the user.

```bash
ssh -i ~/.ssh/id_ansible-vm azureuser@$IP_ADDRESS "sudo /usr/sbin/userdel testuser1"
```

Verify user not present

```bash
ssh -i ~/.ssh/id_ansible-vm azureuser@$IP_ADDRESS "/usr/bin/getent passwd testuser1"
```

Manually run pipeline

See the user added once again

FIN