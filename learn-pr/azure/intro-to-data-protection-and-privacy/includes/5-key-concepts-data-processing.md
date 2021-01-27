To understand how to comply with regulations such as GDPR and CCPA, you need to understand the key concepts and components of data processing.

## Key concepts of GDPR

The GDPR gives people rights to manage their personal data that an employer or other type of agency or organization has collected from them. The GDPR defines people as data subjects and the employer, agency, or organization as data controller or just controller. The GDPR defines personal data very broadly as any data that relates to an identified or identifiable natural person. The GDPR gives data subjects specific rights to their personal data, which include obtaining copies of personal data, requesting corrections to it, restricting the processing of it, deleting it, or receiving it in an electronic format so it can be moved to another controller. A formal request by a data subject to a controller to act on their personal data is called a data subject request (DSR).

## Key concepts of CCPA

Similarly, the CCPA provides privacy rights and obligations to Californian consumers, including rights that are similar to the GDPR's data subject rights, such as the right to delete, access, and receive their personal information to move it elsewhere. The CCPA also provides for certain disclosures, protections against discrimination, and "opt-out/ opt-in" requirements for certain data transfers classified as "sales."

### GDPR vs. CCPA

Similarities between GDPR and CCPA include:

- Transparency and disclosure obligations.

- Consumer rights to access, delete, and receive a copy of data.

- The CCPA definition of service providers that's similar to how GDPR defines processors with a similar contractual obligation.

- The CCPA definition of businesses that encompasses the GDPR definition of controllers.

The biggest difference is that the CCPA has a core requirement to enable an opt-out from the sale of data to third parties. The term *sale* broadly includes the sharing of data for valuable consideration.

## Data processing

The following list defines terms that are relevant to data processing:

- Controller. The natural or legal person, public authority, agency, or other body, which, alone or jointly with others, determines the purposes and means of the processing of personal data. The purposes and means of such processing are determined by Union or Member State law, the controller, or the specific criteria for its nomination might be provided by Union or Member State law.

-	Personal data and data subject. Any information relating to an identified or identifiable natural person, or data subject. An identifiable natural person is one who can be identified, directly or indirectly, by referring to:

    - An identifier such as a name, an identification number, location data, or an online identifier.
  
    - One or more factors specific to the physical, physiological, genetic, mental, economic, cultural, or social identity of that natural person.
  
- Processor. A natural or legal person, public authority, agency, or other body that processes personal data on behalf of the controller.

- Customer data. All data, including text, sound, video, image files, or software that's provided by, or on behalf of, a customer through use of the enterprise service. Customer data includes:

  - Identifiable information of end users; for example, usernames and contact information in Azure Active Directory (Azure AD).

  - Customer content that a customer uploads to or creates in specific services. Examples include customer content in an Azure Storage account, customer content of an Azure SQL database, or a customer's virtual machine (VM) image in Azure Virtual Machines.
  
- System-generated logs. Microsoft or other vendors generate logs and related data that help provide enterprise services to users. System-generated logs contain primarily pseudonymized data, such as unique identifiers. This is typically a number that the system generates that cannot, on its own, identify an individual person, but is used to deliver the enterprise services to users. System-generated logs might also contain identifiable information about end users, such as a username.

## Process of completing DSRs

A controller is obligated to promptly consider each DSR and provide a substantive response either by taking the requested action, or by providing an explanation for why they can't accommodate the DSR. A controller should consult with their own legal or compliance advisers regarding the proper disposition of any given DSR. Completing a DSR might involve several processes that are subject to your organization's GDPR compliance rules. These processes include:

-	Discovery. Use search and discovery tools to more easily find customer data that might be the subject of a DSR. After collecting potentially responsive documents, you can perform one or more of the DSR actions described in the following steps to respond to the request. Alternatively, you might determine that the request doesn't meet your organization's guidelines for responding to DSRs.

- Access. Retrieve personal data that resides in the Microsoft cloud and, if requested, make a copy of it available to the data subject.

- Rectification. Make changes or implement other requested actions on the personal data, where applicable.

- Restriction. Restrict the processing of personal data, either by removing licenses for various Azure services or turning off the desired services where possible. You can also remove data from the Microsoft cloud and retain it on-premises or at another location.

- Deletion. Permanently remove personal data that resides in the Microsoft cloud.

- Exporting and receiving (portability). Provide an electronic copy of personal data or personal information in a machine-readable format to the data subject. Personal information under the CCPA is any information relating to an identified or identifiable person. There is no distinction between a person's private, public, or work role. The defined term, "personal information," corresponds with "personal data" under the GDPR. However, the CCPA also includes family and household data.
