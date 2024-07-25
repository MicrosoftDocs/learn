## Project overview

Our project aims to launch a new website for our online grocery retailer. The primary goal is to ensure seamless sign-in and account creation experiences for both existing and new customers. The marketing team emphasizes brand representation, while the security team focuses on protecting user accounts. To achieve our goal, we’ll implement Microsoft Entra External ID, a cloud-hosted identity and access management solution.

### High-level approach

1. **Tenant Creation:** We’ll set up a tenant to store user accounts securely.
1. **App Registration:** Register our app to integrate with Microsoft Entra External ID.
1. **Customized User Experiences:**
    - **During Sign-In:** Customize the sign-in process, including branding elements.
    - **During Sign-Up:** Configure account creation, attribute collection, account types, and extension for information verification.
1. **Account Security:** Prompt users to enroll in multifactor authentication for enhanced security.

### Configuration options

Throughout the module, you can select your preferred configuration option to follow along.
![Screenshot of configuration options.](../media/prepare/1.png)

- The **Microsoft Entra admin center** provides an intuitive interface for straightforward configuration tasks.
- The **Microsoft Graph API** enables customization and automation of tasks.
