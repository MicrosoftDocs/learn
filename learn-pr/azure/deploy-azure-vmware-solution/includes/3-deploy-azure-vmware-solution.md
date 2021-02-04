<!--
Add sentence that introduces this unit. 
Include diagram that gives overview of deployment process?

Consider video for difficult to explain conceptual topic (networking related?)
    - Placeholder: video/demo showing the creation of AVS and methods to ensure all settings are configured correctly.
    - Possible video: https://www.youtube.com/embed/gng7JjxgayI
    - Possible demo: https://bjd52q.axshare.com/#id=q3ewtk&p=dashboard&g=1
    
## Deploy AVS resource (Show this in detail with screenshots)
## Create Bastion or a jump host (Consider making this brief - see high-level overview of process here: https://docs.microsoft.com/en-us/learn/modules/connect-vm-with-azure-bastion/3-how-does-azure-bastion-work - Ok to copy/paste from Learn modules.)
## Connect to VNet with ExpressRoute
## Verify network routes are advertised (or shown?)
## Connect and sign into vCenter and NSX-T from the Bastion host
## Confirm NSX-T configurations 
advertised (shown/displayed?) NSX-T segment, DHCP services to NSX-T segment(optional), add VM on NSX-T segment, verify connectivity

-->

You can build out your AVS environment once all pre-planning steps are complete. AVS will provide you and your company an ability to deploy a vSphere cluster in Azure. AVS also allows you to easily migrate and deploy workloads for your company. You'll use all the information you gathered from the planning module to successfully deploy AVS to your subscription. 

To use AVS, you must first register the resource provider with your subscription, like how we talked about in the last unit. Registering the resource provider can be done through the portal, AZ-CLI, or PowerShell.

Next, you must hold contributor level rights to the subscription you use in order to deploy AVS.