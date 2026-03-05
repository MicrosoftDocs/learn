Email is one of the most common ways organizations share sensitive information. It might be a doctor's office sending lab results to a patient, a bank issuing statements to customers, or an attorney sharing a contract with a client. In any of these cases, it's important to make sure only the intended recipient can read the message.

Microsoft 365 includes several options to help protect the contents of email. One of the most flexible options is **Microsoft Purview Message Encryption**, which lets users send encrypted email to both internal and external recipients—even if the recipient uses Gmail, Yahoo, or another non-Microsoft email service.

Message encryption is part of the Microsoft Purview Information Protection stack. It's built on Azure Rights Management, which provides encryption, identity, and authorization controls to help keep sensitive content secure.

## How message encryption works

When a user sends a message that matches a policy or mail flow rule with encryption enabled, the message is encrypted before it leaves the organization. Recipients then use a supported method to authenticate and decrypt the message. Depending on the recipient's email service and client, this might happen directly in Outlook or through a secure web portal.

Encryption happens automatically when the message meets the defined conditions, which can be based on keywords, recipient domains, or other criteria. Recipients can read and respond to the message without needing special software, and they don't need a Microsoft 365 subscription.

## How message encryption compares to other options

Microsoft 365 includes other encryption technologies that serve different purposes:

- **Information Rights Management (IRM)**: Also built on Azure RMS, IRM adds usage restrictions in addition to encryption. It's a good choice when you need to prevent forwarding, printing, or copying.

- **S/MIME**: Uses certificates for encryption and digital signing. S/MIME is often used in government settings or when strict peer-to-peer encryption is required, but it requires more overhead to manage.

- **Transport Layer Security (TLS)**: Encrypts the connection between mail servers. TLS helps secure data in transit between trusted endpoints but doesn't encrypt the message content itself.

Microsoft recommends using Message Encryption to protect the contents of email sent outside your organization. It's a good option when you don't need to restrict how the recipient can use the message.

## Typical use cases

Here are some examples of when Microsoft Purview Message Encryption makes sense:

- A healthcare provider sends test results to a patient
- An HR department shares onboarding documents with a new hire using a personal email address
- A legal team sends confidential case information to an external attorney

This type of encryption is best suited for secure communication across organizational boundaries, where you want to keep content private but still allow recipients to open and respond with minimal friction.
