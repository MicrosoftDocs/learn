Choose the best response for each question. Then select Check your answers.

## Multiple Choice
Another IT administrator creates an Azure virtual machine scale set with five virtual machines. Later, alerts show the VMs are all running at max capacity with the CPU being fully consumed. However, additional VMs are not deploying in the scale set. What should be done to ensure that additional VMs are deployed when the CPU is 75% consumed?
(x) Enable the autoscale option. {{That's correct. When autoscale is enabled the parameters for when to scale are configured. To meet the requirements of this scenario, enable the autoscale option so that additional VMs are created when the CPU is 75% consumed.}}
( ) Manually increase the instance count. {{That's incorrect. Manually increases the instance count is time consuming and error prone. Is there a more automated way to do this?}}
( ) Change the CPU percentage to 50%. {{That's incorrect. There is no need to change the CPU percentage requirement.}}

## Multiple Choice
The DevOps team for a large food delivery company is configuring a virtual machine scale set. Friday night is typically your busiest time. Conversely, 7 AM on Wednesday is generally your quietest time. Which of the following virtual machine scale set features should be configured?
( ) Autoscale {{That's incorrect. Autoscale will automatically increase or decrease the number of VM instances that run your application. Is there a better solution based on demand? }}
( ) Metric-based rules {{That's incorrect. Metric-based rules are better for situations like CPU usage or storage disk capacity. }}
(x) Schedule-based rules {{That's correct. With schedule-based rules administrators proactively schedule the scale set to deploy one or any number of additional instances. This will accommodate a spike in demand and then scale back down when the spike ends.}}

## Multiple Choice
Virtual machine scale sets deploy and manage which of the following?
(x) a set of identical VM instances created from the same base OS image and configuration. {{That's correct. This approach lets administrators easily manage hundreds of VMs without additional configuration tasks or network management.}}
( ) a mix of virtual machines with different OS images and configurations. {{That's incorrect. Virtual machine scale sets deploy and manage a set of identical VM instances.}}
( ) whatever is needed for the application, an identical set or a mixed set of virtual machines. {{That's incorrect. Virtual machine scale sets deploy and manage a set of identical VM instances.}}
 





