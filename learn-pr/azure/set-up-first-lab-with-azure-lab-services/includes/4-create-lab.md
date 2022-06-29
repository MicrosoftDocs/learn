
Recall that a lab is powerful because it provides a quick and repeatable way to spin up a preconfigured virtualized classroom environment. You can use Azure Lab Services to add labs (virtual machines) that are preconfigured with required software components.

Your educational institution has a large and expanding student body, and you need to use Azure Lab Services to create many classroom labs. The educators who configure each lab will access these VMs through Remote Desktop (RDP) or Secure Sockets Layer (SSL).

In this unit, you'll learn about adding labs to an existing lab plan in Azure Lab Services, and how to connect to a lab for the purpose of pre-installing software.

## Labs

The labs consist of the virtual machines on which students will execute their training tasks. When you set up a lab, you choose the operating system. For Windows, you specify a version and edition. For Linux, you can also choose from different distributions, such as Ubuntu or SUSE.

When you set up the lab, you typically choose a VM image from the Azure Marketplace, which always includes the operating system and may have some other software packages. You can also use a custom image instead by saving it to Azure Compute Gallery.

When you create the lab, you create the template virtual machine. From this virtual machine, Azure Lab Services will create each student virtual machine when the lab begins.

## Automatic shut-down

When you create a lab, the same auto-shutdown policies are available as when you create a lab plan. The default values are set in the lab plan policy.

If you set the policies in the lab, they apply to all virtual machines in the lab.

## Template virtual machine

Having chosen the image, you connect to it and install any extra software you need for the lab. For Windows virtual machines, you use Remote Desktop Protocol (RDP) to make this connection. For Linux, you use Secure Shell (SSH) instead. Complete your configuration and publish the template virtual machine. This virtual machine, in your configured state, is the starting point for the lab.

When you set up a lab, you need to make sure that these virtual machines include everything students need for their learning. For example:

- Custom or third-party software. Include the software packages you're training your users on and any prerequisites.
- Access to course materials. Ensure that required training content is present on the hard drive so students can start training immediately.

## Schedules

Schedules are the time slots that an educator creates so the lab VMs are available for class time.  Schedules can be one-time or recurring.  Any scheduled time doesn't count against extra time students may be given to complete homework.

Scheduled time is commonly used when students are following the educator's directions during class hours.

All the student VMs are started with schedules.  (Unclaimed VMs aren't started when schedules run.)  VMs are started even if a student doesn't sign into a VM.  You can help reduce likelihood of accruing costs when a VM isn't being used by configuring the automatic shutdown of VMs for a lab.

There are two types of schedules.

- **Standard**.  This schedule will start all student VMs at the specified start time and shut down all lab VMs at the specified stop time.
- **Stop only**.  This schedule will stop all lab VMs at the specified time, even if the VM was manually started by an educator or student.

## Quotas

Quota is the limit of time a student may use their VM outside of class.  Allowing time for homework is done by using quota hours.  If no quota is assigned, students can only use their VM during scheduled time or if the educator starts the VM for them.  

Quota hours are counted when the student starts the lab VM themselves.  If an educator manually starts the lab VM for a student, quota hours aren't used for that student.

A lab can use either quota time, scheduled time, or a combination of both.

## Workflow

Here's the typical workflow when using Azure Lab Services:

1. The person that created the lab plan adds other users to the **Lab Creator** role.
   - For example, the administrator (who created the lab plan) assigns educators to the **Lab Creator** role on the lab plan or resource group so that they can create labs for their classes.
   - The administrator can also assign educators the **Lab Creator** role on the resource group that contains one or more lab plans.
1. Then, the educators create labs with VMs for their classes and send registration links to students in the class.
   - If the administrator assigned the **Lab Creator** role at the resource group, the educator can choose from all lab plans in that resource group when creating new labs.
1. Students use the registration link that they receive from educators to register to the lab.
   - Once they're registered, they can use VMs in the labs to do the class work and homework.
   - If integration with Microsoft Teams or Canvas Learning Management System (Canvas LMS) is used, this step is skipped by the students.

:::image type="content" source="../media/4-set-up-classroom.png" alt-text="Diagram describing the roles of educators and students in Azure Lab Services.":::