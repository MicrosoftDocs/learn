
Educational institutions often have different cost requirements and different requirements around roles and responsibilities.

Here, you'll learn the key configuration settings of an Azure Lab Services lab plan. This information helps you to configure an environment that simplifies the creation of labs and also complies with the organization's cost management requirements. You'll also learn about the different roles and responsibilities supported by Azure Lab Services.

## User profiles

Azure Lab Services was designed with three major personas in mind: administrators, educators, and students.  This section describes each persona and the tasks they’re typically responsible for. The tasks are associated with specific well-defined roles. For example, the educator is typically assigned the role of Lab Creator.

### Administrator

An IT administrator for organization is typically the lab plan owner.  The lab plan owner is often the one owns the Azure subscription and does the following tasks:

- Creates and organizes resource groups to contain lab plans and labs.
- Creates lab plans for your organization.
- Manages and configures policies across all labs.
- Gives permissions to educators in the organization to create a lab using the lab plan.

### Educator

Educators, often a teacher or an online trainer, creates labs using a pre-created lab plan. An educator does the following tasks:

- Creates a lab.
- Installs the appropriate software on virtual machines template.
- Publishes the lab to create VMs for the students.
- Specifies which students can access the lab.
- Sends registration link to the lab to students, if necessary.
- Use the lab to teach their course.

Some organizations may opt to have their administrators complete the previous tasks to create and manage labs on behalf of the educators.

### Student

A student does the following tasks:

- Registers for the lab, if needed.
- Connects to a VM in the lab and uses it for completing assigned work.

## Azure subscription

An Azure subscription is required for the Azure Lab Services administrator. This can be done by an IT department or an educator acting as the administrator.

## Lab plans

Lab plans are an Azure resource and contain settings used when creating new labs.  Lab plans control the networking setup, which VM images are available, and whether  integration with educational classroom software, such as Canvas, can be used for a lab.

## Automatic shut-down

Anytime a machine is **Running**, costs are being incurred, even if no one is connected to the VM.  You can enable several auto-shutdown features to avoid extra costs when the VMs aren't being used.  The are three auto-shutdown policies available in Azure Lab Services.

- Disconnect idle virtual machines.
- Shut down virtual machines when students disconnect from the virtual machine.
- Shut down virtual machines when students don't connect a recently started virtual machine.

The setting(s) apply to all the labs associated with the lab plan. A lab creator (educator) can override this setting at the lab level. The change to this setting at the lab plan will only affect labs that are created after the change is made.

## Configure regions

A lab plan can support multiple regions. You can configure the locations where you can create labs by enabling or disabling regions associated with the lab plan. Enabling a region allows lab creators to create labs within that region. You cannot create labs in disabled regions.

When you create a lab plan, you have to set an initial region for the labs, but you can enable or disable more regions for your lab at any time. If you create a lab plan by using the Azure portal, enabled regions initially includes the same region as the location of the lab plan.

## VM images

Azure Marketplace provides hundreds of images that you can enable so that lab creators can use them for creating their labs. Some images might include everything that a lab already needs. In other cases, you might use an image as a starting point, and then the lab creator can customize it by installing additional applications or tools.

The Marketplace images that are available when you select images are only the ones that satisfy the following conditions:

- Creates a single VM.
- Uses Azure Resource Manager to provision VMs.
- Doesn't require purchasing an extra licensing plan.
