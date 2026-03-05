For large organizations, automation enables greater administrative control over data that is being labeled. Configuring and testing SITs, along with proper label setup, can make Automatic Labeling more practical, particularly in situations involving company acquisitions but is applicable to organizations of any size. Sensitivity labels can be automatically applied to Microsoft 365 items, such as files and emails, based on predefined conditions to ensure consistent protection. 

## Two methods for automatic labeling

- Microsoft Purview offers two methods for automatically applying sensitivity labels to content: client-side labeling in Office apps and service-side labeling via auto-labeling policies.

- Client-side labeling occurs during document editing or email composition and allows users to accept or reject suggested labels, offering flexibility but requiring user interaction.

- Service-side labeling applies labels to saved content in SharePoint, OneDrive, or Exchange Online without user involvement, making it ideal for large-scale, consistent protection.

The [comparison of auto-labeling in Office apps and auto-labeling policies](/purview/apply-sensitivity-label-automatically#compare-auto-labeling-for-office-apps-with-auto-labeling-policies) provides configuration guidance for each approach and can help organizations choose the most effective method.

## Comparison of labeling methods

The table illustrates differences between client-side and service-side auto-labeling:

| Aspect | Client-side auto-labeling | Service-side auto-labeling |
|-----|-----|-----|
| **Trigger method** | Manual action by the user | Automatic after content is saved or sent |
| **Location of action** | On the user's device (for example, Office apps) | In cloud services like SharePoint, OneDrive, Exchange Online |
| **Dependency on user** | High: Relies on user awareness and action | None: Labels applied without user involvement |
| **Technology used** | User interface and local settings | Predefined policies and Sensitive Information Types (SITs) |
| **Risk of human error** | Higher: Users might forget or mislabel | Lower: Consistent labeling based on rules |
| **Compliance impact** | Variable: Depends on user behavior | Strong: Ensures consistent labeling across large data volumes |
| **Best use case** | Small teams or environments with high user training | Large organizations aiming for scalable, automated compliance |

How can an organization maximize the effectiveness of a sensitivity label? By applying these labels at the container level, administrators can implement protections such as restricting access from unmanaged devices and preventing the discovery of private teams.
