Regulations provide people with rights to help manage their personal data that organizations or employers have collected from them. These regulations will often refer to people as *data subjects* or *consumers*, and the organizations or employers with that data as *data controllers*, or *controllers*. In the EU, the GDPR provides these rights. In the United States, the CCPA provides these rights to Californian consumers. The following table describes some of the differences between the GDPR and the CCPA.

|GDPR|CCPA|
|----|----|
|Effective May 25, 2018|Effective January 1, 2020|
|Applies to any controller of EU citizens’ data, regardless of their location or size|Applies to controllers in California earning more than $25 million USD or controllers that sell personal information|
|Penalties for non-compliance and breaches|Penalties for breaches, and provisions for consumer lawsuits|

## What is a DSR?

Under GDPR and CCPA provisions, a person has the right to make a request to the data controller to review, change, or perform other actions to their personal data. A *DSR* is this formal request. A person submitting a DSR to the data controller asks them to perform a specific action (or actions) on their personal data.

Under the GDPR, a person can request to:

- Obtain copies
- Have corrections made
- Restrict the processing of data
- Delete data

The CCPA additionally provides for:

- Certain disclosures
- Protections against discrimination
- Opt-out/opt-in requirements for sales-related data transfers

When a data controller receives a DSR, they address it and provide an appropriate response. Responses may include taking the requested action or explaining why they can't fulfill the DSR. Controllers should consult their legal or compliance experts for each DSR, as fulfilling a DSR could entail multiple steps that are subject to an organization's GDPR or CCPA compliance rules.

## DSR process

You can use Microsoft products and service and administrative tools to help respond to DSRs. The procedure to respond to a DSR includes the following phases:
<!-- After editing this module, I'm still not clear whether they must use Microsoft products to gather information from Microsoft products, or whether there are other options such as third-party products. We should clarify this. -->
- Discovery. Use Microsoft search and discovery tools to more easily find customer data that might be the subject of a DSR. After collecting documents that might be relevant to a DSR, you can perform one or more of the DSR actions that the following phases describe. You might also determine that the request doesn't meet your organization's guidelines for responding to DSRs.

- Access. Retrieve personal data that's in Microsoft cloud services, and if requested, make a copy of it available to the data subject.

- Rectification. Make changes or implement other requested actions to the personal data, where applicable.

- Restriction. Restrict personal data processing. You can turn off the desired services where possible, or remove licenses for various Azure services and Microsoft 365 or Office 365 applications. You can also remove data from the Microsoft cloud and keep it on-premises or at another location.

- Deletion. Permanently remove personal data that's in the Microsoft cloud.

- Exporting and receiving (portability). Provide the data subject with an electronic copy of their personal data or personal information in a machine-readable format.

> [!NOTE]
Under the CCPA, *personal information* is defined as any information relating to an identified or identifiable person. There's no distinction between a person's private, public, or work role. Under the GDPR, the defined term *personal information* corresponds with *personal data*. However, the CCPA also includes family and household data.

The following units in this module introduce some of the technical procedures that you can use to respond to DSRs when the personal data resides in the Microsoft cloud.

## DSR terminology

The following list defines some of the terms that are relevant to DSR:<!-- ID/SME: As far as I can tell, these are definitions directly from GDPR. -->
<!-- ID/SME: Because these terms are GDPR definitions, I won't edit them. However, if it's plagiarism for us to copy them specifically, then we should rewrite them. -->
- Controller. The natural or legal person, public authority, agency, or other body, which, alone or jointly with others, determines the purposes and means of the processing of personal data. The purposes and means of such processing are determined by Union or Member State law, the controller, or the specific criteria for its nomination might be provided by Union or Member State law.

- Personal data and data subject. Any information relating to an identified or identifiable natural person, or data subject. An identifiable natural person is one who can be identified, directly or indirectly, by referring to:

  - An identifier such as a name, an identification number, location data, or an online identifier.
  
    - One or more factors specific to the physical, physiological, genetic, mental, economic, cultural, or social identity of that natural person.
  
- Processor. A natural or legal person, public authority, agency, or other body that processes personal data on behalf of the controller.

- Customer data. All data, including text, sound, video, image files, or software that's provided by, or on behalf of, a customer through use of the enterprise service. Customer data includes:

  - Identifiable information of end users; for example, usernames and contact information in Azure AD.

  - Customer content that a customer uploads to or creates in specific services. Examples include customer content in an Azure Storage account, customer content of an Azure SQL database, or a customer's virtual machine (VM) image in Azure Virtual Machines.
  
- System-generated logs. Microsoft or other vendors generate logs and related data that help provide enterprise services to users. System-generated logs contain primarily pseudonymized data, such as unique identifiers&mdash;typically system-generated numbers. These unique identifiers are used to deliver enterprise services to users, but on their own they can't be used to identify an individual person. However, system-generated logs might contain identifiable information about end users, such as a username.