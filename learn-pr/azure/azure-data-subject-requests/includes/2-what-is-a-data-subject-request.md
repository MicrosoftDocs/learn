Regulations provide rights to people (data subjects and consumers) to manage their personal data that organizations or employers (data controllers or controllers) have collected from them. In the EU, the GDPR provides these rights. In the United States of America, the CCPA provides these rights to Californian consumers. The following table lists some of the differences between the GDPR and the CCPA.

|GDPR|CCPA|
|----|----|
|Effective May 25, 2018|Effective January 1, 2020|
|Applies to any controller of EU citizens’ data, regardless of their location or size|Applies to controllers in California earning more than $25 million USD or controllers that sell personal information|
|Penalties for non-compliance and breaches|Penalties for breaches and provisions for consumer lawsuits|

## What is a DSR?

<!--Richard, please review edit to this section. -->Under the provisions of the GDPR and CCPA, a person has the right to make a request to the data controller to review, change, or perform other actions to their personal data. A DSR is a formal request from a data subject or consumer to a data controller, asking them to perform an action on their personal data. The GDPR gives personal data rights such as:

- Obtaining copies
- Requesting corrections
- Restricting the processing of data
- Deleting data

The CCPA additionally provides for:

- Certain disclosures.
- Protections against discrimination.
- Opt-out/opt-in requirements for sales-related data transfers.

When a data controller receives a DSR, they are obligated to promptly consider it and provide an appropriate response, either by taking the requested action, or by explaining why they can't execute the DSR. Controllers should consult their legal or compliance experts for each DSR. Executing a DSR could entail multiple steps that are subject to an organization's GDPR or CCPA compliance rules. 

## DSR process

You can use Microsoft products and service and administrative tools to respond to DSRs. The procedure to respond to a DSR includes the following phases:

- Discovery. Use search and discovery tools to more easily find customer data that might be the subject of a DSR. After collecting potentially responsive documents <!--Richard, not clear what a “responsive document” means; do we mean “documents that might be relevant to a DSR”?-->, you can respond to the request by performing one or more of the DSR actions that the following steps describe. Alternatively, you might determine that the request doesn't meet your organization's guidelines for responding to DSRs.

- Access. Retrieve personal data that resides in the cloud services from Microsoft and, if requested, make a copy of it available to the data subject.

- Rectification. Make changes or implement other requested actions on the personal data, where applicable.

- Restriction. Restrict the processing of personal data, either by removing licenses for various Azure services and Microsoft 365 or Office 365 applications, or turning off the desired services where possible. You can also remove data from the Microsoft cloud and retain it on-premises or at another location.

- Deletion. Permanently remove personal data that resides in the Microsoft cloud.

- Exporting and receiving (portability). Provide an electronic copy of personal data or personal information in a machine-readable format to the data subject. Personal information under the CCPA is any information relating to an identified or identifiable person. There is no distinction between a person's private, public, or work role. The defined term *personal information* corresponds with *personal data* under the GDPR. However, the CCPA also includes family and household data.

> [!NOTE]
> The following units introduce some of the technical procedures that you can use to respond to DSRs when personal data resides in the Microsoft cloud.

## DSR terminology

The following list defines terms that are relevant to DSR:

- Controller. The natural or legal person, public authority, agency, or other body, which, alone or jointly with others, determines the purposes and means of the processing of personal data. <!--Richard, this next sentence doesn’t read properly. The “, the controller, or the specific criteria” bit is confusing. Is there a typo?-->The purposes and means of such processing are determined by Union or Member State law, the controller, or the specific criteria for its nomination might be provided by Union or Member State law.

- Personal data and data subject. Any information relating to an identified or identifiable natural person, or data subject. An identifiable natural person is one who can be identified, directly or indirectly, by referring to:

  - An identifier such as a name, an identification number, location data, or an online identifier.
  
  - One or more factors specific to the physical, physiological, genetic, mental, economic, cultural, or social identity of that natural person.
  
- Processor. A natural or legal person, public authority, agency, or other body that processes personal data on behalf of the controller.

- Customer data. All data, including text, sound, video, image files, or software that's provided by, or on behalf of, a customer through use of the enterprise service. Customer data includes:

  - Identifiable information of end users; for example, user names and contact information in Azure AD.

  - Customer content that a customer uploads to or creates in specific services. Examples include customer content in an Azure Storage account, customer content in an Azure SQL database, or a customer's virtual machine (VM) image in Azure Virtual Machines.
  
- System-generated logs. Microsoft or other vendors generate logs and related data that help provide enterprise services to users. System-generated logs contain primarily pseudonymized data, such as unique identifiers. This is typically a number that the system generates that cannot, on its own, identify an individual person, but is used to deliver the enterprise services to users. System-generated logs might also contain identifiable information about end users, such as a user name.
