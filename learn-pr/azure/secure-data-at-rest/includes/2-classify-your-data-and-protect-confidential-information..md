<!--Introductory paragraph topic sentence

Summary: A sentence that helps the learner prepare for the upcoming content. This makes sure to set the learner's expectations about what they're going to accomplish.

Scenario sub-task

Summary: A couple of sentences that specifies which section of the overall module scenario will be covered in this unit.

Task the learner will learn to accomplish

Summary: A sentence that describes the content the learner will know by the end of the unit.
 
Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Explanatory paragraph-->

<!--Explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

<!-- Optional knowledge check -->

## Notes from design doc
**Classify your data and protect confidential information.**

To understand what level of encryption is required for your product you need to classify the data to understand its risk. By the end of this unit, you will be able to:

*   Understand the classifications of Confidential, Internal or Public
*   Understand structured-vs-unstructured data.
*   Understand the options for At Rest, Keys and Secrets, and In Transit.

Cover the following topics:

*   Data exists in one of three basic states: at rest, in process and in transit.

    *   All three states require technical solutions for the data classification, albeit the principles of data classification should be the same for each. For example, data that is classified as confidential needs to remain confidential be it at rest, in process or in transit.
*   Data classifications:

    *   Terminology can change between organizations but typically fall into the three categories usually mapping to a High/Medium/Low sensitivity
    *   Confidential (High) - Data that if lost would be catastrophic to either an individual or organization and may include data such as

    *   Personal Data
    *   Financial Records
    *   Business data such as code or intellectual property
    *   Legal Data
    *   Authentication Data, credentials, cryptographic keys, certificates.
    *   Internal Use Only (Medium)

    *   Information including files and data that would not have a severe impact on an individual if lost or destroyed - this data may include

    *   Emails which can be deleted or distributed without causing a crisis
    *   Documents and files which do not include confidential data.
    *   With the exception of data that is made public or is confidential, all data within a business organization can be classified as Internal Use Only by default.
    *   Public (Low)

    *   Data and files that are not critical to business needs or have deliberately been released to the public for their use.
    *   This could include marketing material, press announcement
*   Structured-vs-Unstructured

    *   Structured Data, for example, is a database or spreadsheet
    *   Unstructured may be a document, source code or email.
    *   It's easier and less time consuming to manage structured data, however, organizations usually have much more unstructured data than structured.
*   Regardless of type, it is essential for organizations to manage data sensitivity which helps ensure sensitive or confidential data assets are managed with greater oversight than data assets considered public or free to distribute
*   After data is classified,  you need to have an approach to protect confidential data. At rest, Keys and Secrets, in transit:

    *   At rest, this can be addressed by Azure Storage Service Encryption. Covered in a later unit
    *   For Keys and Secrets,  this can be addressed by Azure Key Vault and managed identities. Covered in a later unit.
    *   For In transit, this can be addressed by SSL/TLS communications. Covered in a later unit.

**Knowledge check**

*   Would an email be structured or unstructured data?
*   Which of *credential*, *PR release*, or *public key* could be classified as Public(Low)?
*   Would a group email not classified as confidential be Internal Use or Public classification?
