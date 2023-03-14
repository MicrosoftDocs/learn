

One thing that makes cloud services different from traditional on-premises virtual desktop infrastructures (VDIs) is how they handle security responsibilities.

When you use Azure Virtual Desktop, it’s important to understand that while some components come already secured for your environment, you'll need to configure other areas yourself to fit your organization’s security needs.

Listed below are the security needs you're responsible for in your Azure Virtual Desktop deployment:

| **Security need**            | **Is the customer responsible for this?** |
| ---------------------------- | ----------------------------------------- |
| Identity                     | Yes                                       |
| User devices (mobile and PC) | Yes                                       |
| App security                 | Yes                                       |
| Session host OS              | Yes                                       |
| Deployment configuration     | Yes                                       |
| Network controls             | Yes                                       |
| Virtualization control plane | No                                        |
| Physical hosts               | No                                        |
| Physical network             | No                                        |
| Physical datacenter          | No                                        |

The security needs the customer isn't responsible for are handled by Microsoft.

Microsoft recommends enabling Microsoft Defender for Cloud for subscriptions, virtual machines, key vaults, and storage accounts.

With Microsoft Defender for Cloud Standard, you can:

 -  Manage vulnerabilities.
 -  Assess compliance with common frameworks like Payment Card Industry (PCI).
 -  Strengthen the overall security of your environment.
