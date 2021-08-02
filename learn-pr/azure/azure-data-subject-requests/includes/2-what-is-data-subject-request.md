Regulations provide people with rights to help manage the personal data that organizations or employers collect from them. These regulations often refer to people as data subjects or consumers, and the organizations or employers with that data as data controllers, or controllers. The GDPR provides these rights to data subject within the territorial reach of the GDPR. In the United States, the CCPA provides these rights to California consumers.

There are significant differences between the CCPA and the GDPR. However, it’s easier to focus on the similarities, which include:

- Transparency and disclosure obligations.
- Consumer rights to access, delete, and receive a copy of data that controllers collect.
- A definition of service providers that’s similar to how GDPR defines “processors” with a similar contractual obligation.
- A definition of “businesses” that encompasses the GDPR definition of “controllers.”

The biggest difference is the CCPA’s core requirement to enable an opt-out from data sales to third parties. “Sale” is broadly defined to include the sharing of data for valuable consideration. This obligation is more narrow and specific than the broad GDPR right to object to processing. The GDPR right encompasses this type of sale, but isn’t specifically limited to this type of sharing.

## DSRs explained?

Under GDPR and CCPA provisions, a person has the right to make a request to a data controller to review, change, or perform other actions to their personal data. A DSR is this formal request.

Under the GDPR and the CCPA, a person can ask to:

- Obtain copies of their personal data.
- Restrict processing of data.
- Delete data.

Under the GDPR, a person can also ask to:
- Object to and correct their data (GDPR only).
- Not be subject to automated decision-making. 

Under the CCPA, a consumer can also request:

- Certain disclosures.
- Protections against discrimination.
- To opt out or opt in to sales-related data transfers.

When a data controller receives a DSR, they must respond to it. Responses can include taking the requested action or explaining why they can't. Controllers should consult their legal or compliance experts for each DSR. Responding to a DSR can entail multiple steps that are subject to an organization's GDPR or CCPA compliance rules.

## Process for DSR responses

Microsoft services include administrative tools to help your organization respond to DSRs. Responding to a DSR includes the following DSR actions:

- **Discovery.** A DSR begins with discovery. Use Microsoft search and discovery tools to find customer data that might be the subject of a DSR. Organizations can also use third-party products to gather information. 

After collecting documents that might be relevant to a DSR, you can perform one or more of the following DSR actions . You might also determine that the request doesn't meet your organization's guidelines for responding to DSRs.

- **Access.**  Retrieve personal data that' s in Microsoft online services, and if requested, make a copy of it available to the data subject.
- **Rectification (GDPR only).** Make changes or implement other requested actions to the personal data, where applicable.
- **Restriction.** Restrict processing of the individual’s personal data. You can do this by turning off the desired services, where possible. Or you can remove licenses for various Azure services and Microsoft 365 or Microsoft Office 365 applications. You can also remove data from these Microsoft services and keep it on-premises or at another location.
- **Deletion.** Permanently remove personal data that's in Microsoft online services.
- **Exporting and receiving (portability).** Provide the data subject with an electronic copy of their personal data or information in a machine-readable format. Also, respond to a request to transmit their data to another controller.


> [!NOTE]
> Under the CCPA, personal information is defined as any information relating to an identified or identifiable person. There's no distinction between a person's private, public, or work role. However, the CCPA also includes family and household data. Under the GDPR, the defined term personal information corresponds to personal data.

The following units in this module introduce some of the technical procedures that you can use to respond to DSRs when the personal data resides in the Microsoft cloud.

## DSR terminology

The following list defines some of the terms that are relevant to DSR:

- **Controller.** This is a natural or legal person, public authority, agency, or other body. The controller, either alone or jointly, determines the purpose for, and means of, processing someone’s personal data. The controller, or the EU or member state, determines why and how such processing occurs. Additionally, the EU or member state law might provide specific criteria for its nomination.
- **Personal data and data subject.** Any information relating to an identified or identifiable natural person or data subject. An identifiable natural person is one who can be identified directly or indirectly in particular by:
   - An identifier such as a name, an identification number, location data, or an online identifier.
   - One or more factors specific to the physical, physiological, genetic, mental, economic, cultural, or social identity of that natural person.
- **Processor.** A natural or legal person, public authority, agency, or other body that processes personal data for the controller.
- **Customer data.** All data, including text, sound, video, image files, or software that's provided by Microsoft, or on behalf of a customer through Microsoft online services. Customer data includes:
   - Identifiable end-user information. An example is usernames and contact information in Azure AD.
   - Customer content that a customer uploads to, or creates in specific services. Such services could include an Azure Storage account, an Azure SQL database, or a customer's virtual machine (VM) image in Azure Virtual Machines.
- **System-generated logs.** Microsoft and other vendors generate logs and related data that help provide enterprise services to users. System-generated logs contain primarily pseudonymized  data, such as unique identifiers—typically system-generated numbers. These unique identifiers are used to deliver enterprise services to users. On their own, they can't be used to identify an individual person. However, system-generated logs might contain identifiable information about end users, such as a username.
