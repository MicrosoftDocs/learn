The following workflow and component diagram outlines how playbooks can run in different circumstances, one after another. In the workflow, Ansible playbooks:

:::image type="content" source="../media/ansible-workflow-015a9ae4.png":::


1.  Provision resources. Playbooks can provision resources. In the following diagram, playbooks create load-balancer virtual networks, network security groups, and virtual machine scale sets on Azure.
2.  Configure the application. Playbooks can deploy applications to run services, such as installing Apache Tomcat on a Linux machine to allow you to run a web application.
3.  Manage future configurations to scale. Playbooks can alter configurations by applying playbooks to existing resources and applications—in this instance, to scale the VMs.

In all cases, Ansible makes use of core components such as roles, modules, APIs, plugins, inventory, and other components.

> [!NOTE]
> By default, Ansible manages machines using the *ssh* protocol.

> [!NOTE]
> You don't need to maintain and run commands from any central server. Instead, there's a control machine with Ansible installed, and from which playbooks are run.
