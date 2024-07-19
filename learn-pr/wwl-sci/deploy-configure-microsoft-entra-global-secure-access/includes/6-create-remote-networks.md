Remote networks are remote locations, such as a branch office, or networks that require internet connectivity. Setting up remote networks connects your users in remote locations to Global Secure Access. Once a remote network is configured, you can assign a traffic forwarding profile to manage your corporate network traffic. Global Secure Access provides remote network connectivity so you can apply network security policies to your outbound traffic.

There are multiple ways to connect remote networks to Global Secure Access. In a nutshell, you're creating an Internet Protocol Security (IPSec) tunnel between a core router, known as the customer premises equipment (CPE), at your remote network and the nearest Global Secure Access endpoint. All internet-bound traffic is routed through the core router of the remote network for security policy evaluation in the cloud. Installation of a client isn't required on individual devices.

There are five primary steps to configure a Remote Network. In this phase, you're building a bridge from an on-premises router in your office to Global Secure Access. These steps can be performed in Microsoft Entra admin center or via the Microsoft Graph API. Note the final step is performed on the on-premises router.

| Steps | Description |
| :--- | :--- |
| Basics | Define the name of your remote network and the region where you want to connect. |
| Connectivity | Enter the data about your on-premises router, where the signal comes from. |
| Traffic Forwarding | Add a traffic forwarding profile to define the type traffic network traffic to allow through. |
| Review Configuration | In the step your confirm the setup of the remote network and gather settings you need to configure in the on-premises router. |
| Setup on-premises router | Use the management console of your on-premises router to enter the Microsoft connectivity setting from previous step. |

## Configure - Basics
1. Sign in to the Microsoft Entra admin center as a Global Secure Access Administrator.
2. Browse to Global Secure Access > Connect > Remote networks.
3. BASICS tab - Select the Create remote network button and provide the details.

   | Values requested |
   | :--- |
   | Name |
   | Region |

## Set up - Connectivity
4. Select **Next: Connectivity**.

   | Values requested |
   | :--- |
   | Name |
   | Device type - usually a router |
   | IP address of the device |
   | Type of redundancy to enable |
   | Bandwidth |

## Enable - Traffic forwarding profiles
5. Select **Next** to open the Traffic forwarding setup.
 - You can create a new traffic forwarding profile, or select one created during Microsoft Entra Private Access or Microsoft Entra Internet Access.

## Complete configuration - Set up your on-premises router
All your remote networks appear on the Remote network page. Select the View configuration link in the Connectivity details column. These details contain the connectivity information from the Microsoft side of the bidirectional communication channel that you use to set up your CPE.

With the Microsoft connection data, it's time to update the on-premises router configuration. This step is performed in management console your CPE, not in Microsoft Entra admin center. Until you complete this step, your IPsec isn't set up. IPsec is a bidirectional communication. Internet Key Exchange (IKE) negotiations happen between two parties before the tunnel is successfully set up. So, don't miss this step.

