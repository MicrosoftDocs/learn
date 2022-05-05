Azure Lab Services includes a set of administrative objects that make it easy to control the behavior of your lab.

In your educational institution, you want to reassure the board that cloud-based labs won't result in uncontrolled costs, either for virtual machine usage or administration. You'll investigate how administrators set up labs and ensure they remain within budget.

Responsibilities for setting up, managing, and using using Azure Lab Services is neatly distributed among the three main roles, or personas: administrator, educator, and student, each of which has a different level of access:

- **Administrator**. This profile is the most powerful user role and typically creates and owns the lab plan. The lab plan owner configures policies and gives permissions to instructors to create and run labs.
- **Educator**. This profile, the Lab Creator role, is the instructor who runs labs and delivers training. The instructor creates new labs and configures the template virtual machines for it. They also add users to the lab. That is, they invite students to attend and grant them access.
- **Student**. This profile, the basic User role, is for students who access the lab, complete the training, and execute the lab steps.

Make sure your instructors only grant access to genuine students and take care to use schedules and quotas appropriately.

## Get an Azure subscription

An Azure subscription is required for the administrator role. This can be done by an IT department or an educator acting as the administrator.

## Configure a lab plan (administrator)

To create a virtual computer lab using Azure Lab Services, you first need to set up a lab plan in your Azure subscription. Creating resources such as a lab plan in the Azure portal is typically done by your institution’s IT department or Azure administrator. However, it's simple enough that an educator could also set up the lab plan. A lab plan is used to give permission to others to create labs and set policies that apply to the labs created from it.

## Configure labs (educator)

The labs consist of the virtual machines on which students will execute their training tasks. When you set up a lab, you need to make sure that these virtual machines include everything students need for their learning. For example:

- **Configure the operating system**. For Windows, you specify a version and edition. For Linux, you can also choose from different distributions, such as Ubuntu or SUSE. For Windows, you can also apply certain policies by default.
- **Custom or third-party software**. Include the software packages you're training your users on and any prerequisites.
- **Access to course materials**. Ensure that required training content is present on the hard drive so students can start training immediately.

You include all these items in a template virtual machine from which Azure creates the student virtual machines when the lab begins. 

When you set up the lab, you typically choose a VM image from the Azure Marketplace, which always includes the operating system and may have some other software packages. You can also use a custom image instead by saving it to Azure Compute Gallery.

Having chosen the image, you connect to it and install any extra software you need for the lab. For Windows virtual machines, you use Remote Desktop Protocol (RDP) to make this connection. For Linux, you use Secure Shell (SSH) instead. Complete your configuration and publish the template virtual machine. This virtual machine, in your configured state, is the starting point for the lab.

:::image type="content" source="../media/3-set-up-classroom.png" alt-text="Diagram illustrating the steps used to set up virtual machines in a classroom.":::

## Control usage (educator)

If your class is led by an instructor, all students study together in arranged time slots. You use a **schedule** for these times.

In Azure Lab Services, a schedule defines the time slots when the class runs. At the beginning of the time slot, Azure starts all the virtual machines in the lab for the students to use. The virtual machines are also stopped at the end of the time slot.

Alternatively, you might want students to take classes in their own time, when it fits in with their work. To enable this way of working, set a **quota**. A quota is a time limit, in hours, during which each student can use a lab virtual machine outside of the schedule. If the quota is set to zero, students can only use virtual machines during a schedule time slot or when an instructor turns on a virtual machine for them. 

If you want to run an instructor-led class but also enable students to study outside of scheduled timeslots, use a combination of schedules and quotas.

> [!IMPORTANT]
> Control carefully who you grant access to your lab and the length of their quotas. Fraudulent users are always looking for opportunities to run code for free; for example, to mine crypto currencies. You can use good security and limited quotas to mitigate this risk.