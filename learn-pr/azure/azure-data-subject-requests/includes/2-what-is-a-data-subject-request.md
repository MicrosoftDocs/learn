Regulations provide people with rights to help manage their personal data that organizations or employers have collected from them<!-- ID/SME: Should "from them" be "about them?" -->. These regulations will often refer to people as *data subjects* or *consumers*, and the organizations or employers with that data as *data controllers*, or *controllers*. In the EU, the GDPR provides these rights. In the United States, the CCPA provides these rights to Californian consumers. The following table describes some of the differences between the GDPR and the CCPA.

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

When a data controller receives a DSR, they address it<!-- ID/SME: Are they obligated, or required? And I switched "consider" for "address." Please verify this is okay. --> and provide an appropriate response. Responses may include taking the requested action or explaining why they can't fulfill the DSR. Controllers should consult their legal or compliance experts for each DSR, as fulfilling a DSR could entail multiple steps that are subject to an organization's GDPR or CCPA compliance rules.

## DSR process

<!-- ID/SME: This first sentence doesn't transition to the second sentence. I would recommend either moving this sentence to the bottom of the five phases list (currently this would be at line 41), or somehow adding a transition to the second sentence. For example, You can use Microsoft products such as ... and their administrative tools to help.... -->You can use Microsoft products and service and administrative tools to help respond to DSRs. The procedure to respond to a DSR includes the following phases<!-- ID/SME: The word "phases" implies steps taken, or a process of a specific order. If this is the case, the following bulleted items should be changed to numbered steps. If this isn't the case, can we replace "phases" with another word? -->:
<!-- After editing this module, I'm still not clear whether they must use Microsoft products to gather information from Microsoft products, or whether there are other options such as third-party products. We should clarify this. -->
- Discovery. Use Microsoft search and discovery tools to more easily find customer data that might be the subject of a DSR. After collecting documents that might be relevant to a DSR, you can perform one or more of the DSR actions that the following steps<!-- ID/SME: I don't see any following (numbered) steps. --> describe. You might also determine that the request doesn't meet your organization's guidelines for responding to DSRs.

- Access. Retrieve personal data that's in <!-- ID/SME: "Azure cloud services?" -->Microsoft cloud services, and if requested, make a copy of it available to the data subject.

- Rectification. Make changes or implement other requested actions to the personal data, where applicable.

- Restriction. Restrict personal data processing. You can turn off the desired services where possible, or remove licenses for various Azure services and Microsoft 365 or Office 365 applications. You can also remove data from the Microsoft cloud<!-- ID/SME: Per the Microsoft Cloud Style Guide: "o refer to the Microsoft offering for cloud services, use Microsoft Azure or Azure, not cloud (to avoid confusion and promote Microsoft branding)." Therefore, can we change "the Microsoft cloud" to "Azure?" If you agree, please search & replace (s/r) throughout all of these units.--> and keep it on-premises or at another location.

- Deletion. Permanently remove personal data that's in the Microsoft cloud.

- Exporting and receiving (portability). Provide the data subject with an electronic copy of their personal data or personal information in a machine-readable format.

> [!NOTE]
Under the CCPA, *personal information* is defined as any information relating to an identified or identifiable person. There's no distinction between a person's private, public, or work role. Under the GDPR, the defined term *personal information* corresponds with *personal data*. However, the CCPA also includes family and household data.

> [!NOTE]<!-- ID/SME: Since I made the above info into a Note, I'm not sure we should have two notes in a row. I would suggest changing it to plain text here, or moving it somewhere else as plain text. -->
> The following units in this module introduce some of the technical procedures that you can use to respond to DSRs when the personal data resides in the Microsoft cloud.

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
  
- <!-- ID/SME: This is the only bullet that looks like it's not verbatim from the GDPR, so I'll edit it. -->System-generated logs. Microsoft or other vendors generate logs and related data that help provide enterprise services to users. System-generated logs contain primarily pseudonymized data, such as unique identifiers&mdash;typically system-generated numbers. These unique identifiers are used to deliver enterprise services to users, but on their own they can't be used to identify an individual person. However, system-generated logs might contain identifiable information about end users, such as a username.
