How to provide classroom training in a cost-effective way is an important concern for most educational institutions.

In your educational institution, suppose you've migrated almost all of your systems into Azure. You want to complete the process by moving from on-premises training classrooms to cloud-based ones, but you're concerned about costs. You want to know how to manage the cloud resources that you'll need and how much work it takes to run those labs.

Here, you'll learn how Azure Lab Services can address those concerns.

## Cloud-based computer labs

Traditionally, if you wanted to teach classes using software, you'd need a classroom full of physical computers. Each student would use one to learn the material and run through exercises. At the end of each course, every computer must be reset to its initial state, so that another group of students can take the training. This reset is usually done by redeploying an operating system image.

An on-premises classroom like this can incur significant costs, such as:

- The purchase and maintenance of the hardware
- The administration time required to set up and reset classrooms
- The physical space that the classroom occupies

It's also challenging to scale up enough physical classrooms to meet high demand for a popular course.

## Student VMs with Marketplace or custom images

You can use Azure Lab Services to set up classroom environments in the cloud quickly and easily.

The virtual machines are based off either a Marketplace image or a custom image from an Azure Compute Gallery. Administrators can, optionally, allow educators to further customize the image. For example, an educator can install software specifically needed for a class. Virtual machine templates can include your own software packages or complex configurations. You could also include the training materials in this template.

:::image type="content" source="../media/2-lab-services-classrooms.png" alt-text="Diagram illustrating the relationship between an Azure Marketplace image and an Azure Lab Services classroom.":::

When you've configured a classroom, you can grant users (students) access to it, so they can complete the training. Users don't need an Azure subscription to use this service.

## Key capabilities

Azure Lab Services is designed to make it easy, both for you to run training classes, and for students to connect to them. Its key capabilities are:

- **Simple** Azure Lab Services provides a simple experience for administrators, educators, and students. When you grant access to a user (student), they receive an invitation and get immediate access. When users log on, they'll see a complete list of the virtual machines they can access. Educators can create labs with little or no interaction with an IT administrator, which also minimizes cost. The management of images and policies around labs is itself simple enough that an educator could take the role of an administrator if that makes sense for an organization.
- **Flexible** The service allows you to leverage many kinds of virtual machine images for your classroom labs.
- **Cost effective** The service provides cost optimization and tracking. Running virtual machines incurs costs in Azure. You see how individuals use virtual machines and set limits on usage. You can also set schedules to limit the time that virtual machines are running to stay in control of your budget.
- **Managed service** The service provides automatic management of infrastructure and scale. Azure provisions and manages all the class infrastructure for you. This infrastructure includes the virtual machines and underlying items, such as a virtual network and the necessary storage accounts. You can concentrate on providing the right training. If the class is popular, you could rapidly scale it up in a single step.