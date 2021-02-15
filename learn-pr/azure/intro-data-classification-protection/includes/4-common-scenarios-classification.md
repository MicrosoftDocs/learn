When classifying data, you need to establish a methodology. There's no software or technology that can tell you how to classify your data. There are many different ways to establish a data classification methodology, and they usually depend on the type of organization or company and the type of business or work the company or organization is doing. It also depends on the data that the company or organization manages. This unit focuses on some of the most common scenarios and approaches.

## Most common types of data classification

Although you can choose to classify your data in many different ways, some of the most common types of data classification include:

- **Classification based on data content**. If you use this approach, you need to classify your data based on the content. For example, based on the data content, you can assign classification labels such as public, internal, confidential, and highly confidential. In some cases, this approach requires that you manually review each document (or other data format) to determine and apply proper classification labels. This could be a time-consuming process. In some cases, you can automate this type of classification by searching for specific keywords in the data and use that as a condition for classification. For example, you can search for a specific pattern or word (such as contract) to automatically classify the data.
- **Classification based on data location**. In this approach, data is classified by where it resides. You can use this approach in scenarios where you’ve already applied a location-based classification. For example, if you have all your confidential contracts in one folder on your file server, then you can automatically apply the appropriate classification label to all documents in this folder. However, this type of data classification is not efficient in today's world where data resides on different locations.
- **Context-based classification**. With this approach, you classify data based on metadata (or context) that's related to a specific file. This could be:
  - An application that created the file, for example, financial software.
  - The person who created the document, for example, a manager.
  - The location in which the file was created or modified, for example, the marketing department building.
- **User-based classification**. This classification approach relies on a user who creates, reviews, or modifies data. Because this classification type relies on user judgment, it is the least consistent classification type. Also, this classification type requires well-trained personnel and well-defined rules for classification. For example, you can apply this classification type for sending emails. After a user composes an email, they should choose the appropriate classification label before sending the email to the recipient.

> [!NOTE]
> It’s important to understand the difference between the classification type, which is also called the classification method, and the classification label. The classification type can be one of the four types that you just learned about, but the classification label is actually the metadata that you assign to classified data.

Some of the most used classification labels include:

- Personal
- General
- Confidential
- Highly Confidential
- Restricted
- Public

## Common requirements for data classification

Data classification is usually based on a certain requirement. A company might choose to classify its data to help ensure better management and protection of that data, both internally and externally. In such a scenario, the company might develop and apply a data classification policy internally, and it might or might not follow general guidelines and regulations.

However, there are many legal frameworks or regulations that require or encourage companies and organizations to classify their data. Requirements based on legal regulations might vary, depending on the types of data that organization or company collects, uses, stores, processes, or transmits.

For example, the GDPR requires that organizations and companies that manage the personal data of EU citizens must classify the types of data they collect, so that they can comply with GDPR regulations. Also, the GDPR itself already categorizes some types of data such as biometric data, race, ethnic origin, political opinions, and health data as sensitive, and these types of data needs protection, not just classification. This means that organizations need to know what types of data they hold, and how to classify this data.

## Relation between data classification and data protection

Data classification and data protection are two separate and very different processes. It is crucial to have a good understanding on outcomes and results of each process.

As discussed before, the result of data classification is metadata, which provides information on how data is classified and lets you label data later. For example, this information can have the value public, confidential, or restricted. However, in the technical context, classification and metadata do not provide data protection. They might provide protection in the human context, which means that a well-educated employee won’t share or misuse data that is classified as confidential. However, classification doesn't technically prevent a user from doing anything with the data.

Conversely, data protection is a technology that provides specific technical context that in most cases, prevents access to data or data content. For example, you can help protect data by applying encryption, which prevents unauthorized users from accessing it, or by applying digital signatures, which prevent users from changing the content. Also, you can help protect data by applying a permission model that specifies who can access data, and what kind of access they will have. The NTFS file system provides this type of permission model.

> [!NOTE]
> It’s important to understand that data classification doesn’t guarantee or provide data protection. Very commonly, data protection is based on the classification value, but you need to implement a manual, or preferably automatic, process that’ll apply protection based on the classification value.

You can use technologies such as Azure Information Protection, which you’ll learn about in later units, to automatically classify the data based on criteria you establish and provide automatic data protection by encrypting data based on the classification label that's assigned. For example, you can configure data protection in such a way that each file that's classified and labeled as confidential is encrypted and is accessible only to users that are member of a particular group, such as Managers.
