The modern security perimeter extends beyond an organization's network perimeter to include user and device identity. Organizations now use identity-driven signals as part of their access control decisions.

Microsoft Entra Conditional Access brings signals together, to make decisions, and enforce organizational policies. Conditional Access is Microsoft's Zero Trust policy engine taking signals from various sources into account when enforcing policy decisions.

:::image type="content" source="../media/conditional-access-signal-decision-enforcement-8a36a2ff.png" alt-text="Screenshot showing how conditional access signal decision enforcement works.":::


Conditional Access policies, at their simplest, are if-then statements; if a user wants to access a resource, they must complete an action. **Example**: A payroll manager wants to access the payroll application and is required to do multifactor authentication to access it.

Administrators are faced with two primary goals:

 -  Empower users to be productive wherever and whenever
 -  Protect the organization's assets

Use Conditional Access policies to apply the right access controls when needed to keep your organization secure.

## Common signals

Conditional Access takes signals from various sources into account when making access decisions.

:::image type="content" source="../media/conditional-access-central-policy-engine-zero-trust-bbcae403.png" alt-text="Screenshot showing an example of common signals.":::


> [!IMPORTANT]
> Conditional Access policies are enforced after first-factor authentication is completed. Conditional Access isn't intended as an organization's first line of defense for scenarios like denial-of-service (DoS) attacks, but it can use signals from these events to determine access.

## Common signals

These signals include:

 -  User or group membership
    
    
     -  Policies can be targeted to specific users and groups giving administrators fine-grained control over access.
 -  IP Location information
    
    
     -  Organizations can create trusted IP address ranges that can be used when making policy decisions.
     -  Administrators can specify entire countries/regions IP ranges to block or allow traffic from.
 -  Device
    
    
     -  Users with devices of specific platforms or marked with a specific state can be used when enforcing Conditional Access policies.
     -  Use filters for devices to target policies to specific devices like privileged access workstations.
 -  Application
    
    
     -  Users attempting to access specific applications can trigger different Conditional Access policies.
 -  Real-time and calculated risk detection
    
    
     -  Signals integration with Microsoft Entra ID Protection allows Conditional Access policies to identify and remediate risky users and sign-in behavior.
 -  Microsoft Defender for Cloud Apps
    
    
     -  Enables user application access and sessions to be monitored and controlled in real time. This integration increases visibility and control over access to and activities done within your cloud environment.

## Common decisions

 -  Block access
    
    
     -  Most restrictive decision
 -  Grant access
    
    
     -  The least restrictive decision can still require one or more of the following options:
        
        
         -  Require multifactor authentication
         -  Require the device to be marked as compliant
         -  Require Hybrid Microsoft Entra ID joined device
         -  Require approved client app

## Commonly applied policies

Many organizations have common access concerns that Conditional Access policies can help with, such as:

 -  Requiring multifactor authentication for users with administrative roles
 -  Requiring multifactor authentication for Azure management tasks
 -  Blocking sign-ins for users attempting to use legacy authentication protocols
 -  Requiring trusted locations for Microsoft Entra ID multifactor authentication registration
 -  Blocking or granting access from specific locations
 -  Blocking risky sign-in behaviors
 -  Requiring organization-managed devices for specific applications
