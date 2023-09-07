
Self-service password reset (SSPR) is a feature of Microsoft Entra that allows users to change or reset their password, without administrator or help desk involvement.  SSPR has several key benefits for organizations and users:
- SSPR reduces IT support costs by enabling users to reset passwords on their own.
- SSPR allows users to get back to work faster and be more productive.
- Administrators can change settings to accommodate new security requirements and roll these changes out to users without disrupting their sign-in.
- SSPR includes robust audit logs that are available from an API, enabling data to be imported to a Security Incident and Event Monitoring (SIEM) system of choice.

If a user's account is locked or they forget or want to change their password, they can follow a prompt to reset it and get back to work. This ability reduces help desk calls and loss of productivity when a user can't sign in to their device or an application.

To use self-service password reset, users must be:

- Assigned a Microsoft Entra ID license. Refer to the Learn More section of the summary and resources unit for a link to the Licensing requirements for Microsoft Entra self-service password reset.
- Enabled for SSPR by an administrator.
- Registered, with the authentication methods they want to use. Two or more authentication methods are recommended in case one is unavailable.

The following authentication methods are available for SSPR:

- Mobile app notification
- Mobile app code
- Email
- Mobile phone
- Office phone
- Security questions

When users register for SSPR, they're prompted to choose the authentication methods to use. If they choose to use security questions, they pick from a set of questions to prompt for, and then provide their own answers. Security questions can only be used during the self-service password reset (SSPR) process to confirm who you are, as a secondary form of authentication. Security questions aren't used as an authentication method during a sign-in event. Administrator accounts can't use security questions as verification method with SSPR.

> [!NOTE]
> By default, administrator accounts are enabled for self-service password reset and are required to use two authentication methods to reset their password, such as an email address, authenticator app, or a phone number. Administrators don't have the ability to use security questions.

When a user resets their password using self-service password reset, it can also be written back to an on-premises Active Directory. Password write-back allows users to use their updated credentials with on-premises devices and applications without a delay.

To keep users informed about account activity, admins can configure email notifications to be sent when an SSPR event happens. These notifications can cover both regular user accounts and admin accounts. For admin accounts, this notification provides an extra layer of awareness when a privileged administrator account password is reset using SSPR. All global admins would be notified when SSPR is used on an admin account.

