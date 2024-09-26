As more organizations implement mobile device strategies for accessing work or school data, protecting against data leakage becomes paramount. Intune's mobile application management solution for protecting against data leakage is App Protection Policies (APP). APP ensures an organization's data remains contained in a managed app. APP operates regardless of whether the device is enrolled. 

When organizations configure APP, the number of various settings and options enable them to tailor the protection to their specific needs. Due to this flexibility, it might not be obvious which permutation of policy settings are required to implement a complete scenario. To help organizations prioritize client endpoint hardening tasks, Microsoft introduced a new taxonomy for security configurations in Windows 10/11. Intune applies a similar taxonomy for its data protection framework for mobile app management.

## Choose a level of app protection

The Intune APP data protection framework is organized into three distinct configuration levels, with each level building off the previous level:

- **Enterprise basic data protection** (Level 1) ensures that apps are protected with a PIN and encrypted. Also performs selective wipe operations. For Android devices, this level validates Android device attestation. Enterprise basic data protection is an entry level configuration that provides similar data protection control in Exchange Online mailbox policies. This configuration introduces IT and the user population to App Protection Policies.
- **Enterprise enhanced data protection** (Level 2) introduces APP, data leakage prevention mechanisms, and minimum OS requirements. This configuration is applicable to most mobile users accessing work or school data.
- **Enterprise high data protection** (Level 3) introduces advanced data protection mechanisms, enhanced PIN configuration, and APP Mobile Threat Defense. This configuration is desirable for users that are accessing high risk data.

Each level has specific recommendations about how and what to set to meet each level of app protection. For more information in Intune, see [Data protection framework using app protection policies](/mem/intune/apps/app-protection-framework?azure-portal=true).