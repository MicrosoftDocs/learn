As more organizations implement mobile device strategies for accessing work or school data, protecting against data leakage becomes paramount. Intune's mobile application management solution for protecting against data leakage is App Protection Policies (APP). App Protection Policies are rules that ensure an organization's data remains safe or contained in a managed app, regardless of whether the device is enrolled. 

When configuring App Protection Policies, the number of various settings and options enable organizations to tailor the protection to their specific needs. Due to this flexibility, it may not be obvious which permutation of policy settings are required to implement a complete scenario. To help organizations prioritize client endpoint hardening endeavors, Microsoft has introduced a new taxonomy for security configurations in Windows 10. Intune is leveraging a similar taxonomy for its data protection framework for mobile app management.

## Choose a level of app protection 

The Intune App Protection Policies data protection framework is organized into three distinct configuration levels, with each level building off the previous level:

- **Enterprise basic data protection** (Level 1) ensures that apps are protected with a PIN and encrypted and performs selective wipe operations. For Android devices, this level validates Android device attestation. This is an entry level configuration that provides similar data protection control in Exchange Online mailbox policies and introduces IT and the user population to App Protection Policies.
- **Enterprise enhanced data protection** (Level 2) introduces App Protection Policies data leakage prevention mechanisms and minimum OS requirements. This is the configuration that is applicable to most mobile users accessing work or school data.
- **Enterprise high data protection** (Level 3) introduces advanced data protection mechanisms, enhanced PIN configuration, and App Protection Policies Mobile Threat Defense. This configuration is desirable for users that are accessing high risk data.

Each level has specific recommendations about how and what to set to meet each level of app protection.