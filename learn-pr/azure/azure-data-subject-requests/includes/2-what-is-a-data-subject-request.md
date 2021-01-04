Regulations exist that provide rights to people (data subjects and consumers) to manage personal data that has been collected from them by organizations or employers (data controller or controller). In the European Union (EU) the General Data Protection Regulation (GDPR) provides these rights. In the United States, the California Consumer Privacy Act (CCPA) provides California consumers with these rights. 

|GDPR|CCPA|
|----|----|
|Effective May 25, 2018|Effective January 1, 2020|
|Applies to any controller of EU citizens data regardless of their location or size|Applies to controllers in California earning more than $25 million USD or controllers that sell personal information|
|Penalties for non-compliance and breaches|Penalties for breaches and provisions for consumer lawsuits|

Reference: "Four differences between the GDPR and the CCPA" <!--- If I know correctly, reference URLs and URLs that provide additional information/reading should be (only?) in the last topic. Personally I'm OK if URLs are included also in other topics, but IDs will decide if that is allowed/acceptable. --->
<!--- ID: I have moved the URL to last unit but left the name of the reference in this case as it is not MS content RL ---> 

## What is a data subject request?

Under the provisions of these regulations a person has the right to review, change, or request other actions be performed by the data controller. When a data subject or consumer makes a formal request to a data controller to take an action on their personal data, this is known as a Data Subject Request (DSR).  GDPR gives personal data rights including:
- obtain copies
- request corrections
- restrict the processing
- deleting

The CCPA additionally provides for:
- certain disclosures
- protections against discrimination
- opt-out/opt-in requirement for sales related data transfers

When a data controller receives a DSR they are obligated to promptly consider each DSR and provide an appropriate response either by taking the requested action, or by providing an explanation why they can't execute the DSR. Controllers should consult their legal or compliance experts for each DSR. Executing a DSR could entail multiple steps that are subject to organization's GDPR or CCPA compliance rules. <!--- If this is not GDPR specific, I would suggest to update to "... organization's GDPR or CCPA compliance rules". ---> 
<!--- Updated - RL --->

## DSR Process

It is possible to use the Microsoft products, service and administrative tools to help respond to DSRs The procedure to respond to a DSR includes:

-	Discovery. Use search and discovery tools to more easily find customer data that might be the subject of a DSR. After collecting potentially responsive documents, you can perform one or more of the DSR actions described in the following steps to respond to the request. Alternatively, you might determine that the request doesn't meet your organization's guidelines for responding to DSRs.

- Access. Retrieve personal data that resides in the Microsoft cloud and, if requested, make a copy of it available to the data subject.

- Rectification. Make changes or implement other requested actions on the personal data, where applicable.

- Restriction. Restrict the processing of personal data, either by removing licenses for various Azure services and Microsoft 365/Office 365 applications or turning off the desired services where possible. <!--- Is this explanation supposed to be Microsoft Azure specific? Or it would make sense to add a sentence about Microsoft 365/Office 365? Or that is the intention of the next sentence? ---> <!--- I have updated the sentence to include M365 and O365 - RL ---> You can also remove data from the Microsoft cloud and retain it on-premises or at another location.

- Deletion. Permanently remove personal data that resides in the Microsoft cloud.

- Exporting and receiving (portability). Provide an electronic copy of personal data or personal information in a machine-readable format to the data subject. Personal information under the CCPA is any information relating to an identified or identifiable person. There is no distinction between a person's private, public, or work role. The defined term, "personal information," corresponds with "personal data" under the GDPR. However, the CCPA also includes family and household data.

 In the following units we will introduce some of the technical procedures used to respond to DSRs when personal data resides in the Microsoft cloud.
 
## DSR Terminology

The following list defines terms that are relevant to DSR:

- Controller. The natural or legal person, public authority, agency, or other body, which, alone or jointly with others, determines the purposes and means of the processing of personal data. The purposes and means of such processing are determined by Union or Member State law, the controller, or the specific criteria for its nomination might be provided by Union or Member State law.

-	Personal data and data subject. Any information relating to an identified or identifiable natural person, or data subject. An identifiable natural person is one who can be identified, directly or indirectly, by referring to:

    - An identifier such as a name, an identification number, location data, or an online identifier.
  
    - One or more factors specific to the physical, physiological, genetic, mental, economic, cultural, or social identity of that natural person.
  
- Processor. A natural or legal person, public authority, agency, or other body that processes personal data on behalf of the controller.

- Customer data. All data, including text, sound, video, image files, or software that's provided by, or on behalf of, a customer through use of the enterprise service. Customer data includes:

  - Identifiable information of end users; for example, usernames and contact information in Azure Active Directory (Azure AD).

  - Customer content that a customer uploads to or creates in specific services. Examples include customer content in an Azure Storage account, customer content of an Azure SQL database, or a customer's virtual machine (VM) image in Azure Virtual Machines.
  
- System-Generated Logs. Microsoft or other vendors generate logs and related data that help provide enterprise services to users. System-generated logs contain primarily pseudonymized data, such as unique identifiers. This is typically a number that the system generates that cannot, on its own, identify an individual person, but is used to deliver the enterprise services to users. System-generated logs might also contain identifiable information about end users, such as a username.

