For a device to autopilot/registration-overview, it must be associated with a tenant ID. This association ensures that Microsoft Entra ID can recognize the device and manage access to organizational applications and resources.

Without this association, features such as multifactor authentication (MFA) and single sign-on (SSO) won't be available. As a result, users may be unable to authenticate or access organizational resources.

## Tenant IDs

Azure subscriptions have a trust relationship with Microsoft Entra ID, which is responsible for authenticating users, services, and devices. Each subscription is linked to a specific tenant ID. There are several ways to [find the tenant ID](entra/fundamentals/how-to-find-tenant#find-tenant-id-through-the-microsoft-entra-admin-center) associated
For guidance on how to [create a new tenant](entraew-tenant#to-create-a-new-tenant, refer to the Microsoft Entra documentation.

## Helpful definitions
An [Entra tenant](microsoft-365/education/deploy/intro-azure-active-directory#what-is-a-microsoft-entra-tenant) is a security boundary that’s under an organization’s control. Within this boundary, administrators can manage directory objects (such as users and groups) and configure tenant-wide settings.

A [service principal](entra/identity-platform/app-objects-and-service-principals?toc=%2Fazure%2Factive-directory%2Fworkload-identities%2Ftoc.json&bc=%2Fazure%2Factive-directory%2Fworkload-identities%2Fbreadcrumb%2Ftoc.json&tabs=browser#service-principal-object) represents an application withinhorized to access Azure resources. It defines the access policies and permissions for the application or user, enabling authentication during sign-in and authorization during resource access.