Classifying data requires that you establish a methodology. No software or technology can tell you exactly how to classify your data. There are many ways to establish a data-classification methodology. Which method you choose depends on your organization and the type of business it's doing. It also depends on the data your organization manages. This unit explains some of the most common scenarios and approaches.

## Most common types of data classification

You can choose to classify your data in many different ways. However, some of the most common data-classification types include:

- **Classification based on data content**. <!-- ID/SME: Please don't use bold to emphasize the introduction of bulleted items. We should use bold sparingly and only for UI items and options. If you really need to emphasize something, such as a new word you're introducing, use italic font. --> Use to classify your data based on its content. You might want to assign classification labels such as public, internal, confidential, and highly confidential. In some cases, this approach requires you manually review each document (or other data format). You then can determine and apply proper classification labels. This process might be time-consuming. However, you could automate it by using keyword searches in data. You then use those searches as conditions for classification. If you search for a specific pattern or word (such as "contract"), you then can automatically classify data that includes it.
- **Classification based on data location**. Use to classify data based on where it is. You also can use it when you’ve already applied a location-based classification. Maybe your confidential contracts are in one folder on a file server. You can automatically apply the appropriate classification label to all of that folder's documents. However, this classification type isn't necessarily efficient if your data is in several different locations.
- **Context-based classification**. Use to classify data based on metadata (or context). For a specific file, this might be:
  - The application that created the file, such as financial software.
  - The person who created the document, such as a manager.
  - The location in which the file was created or modified, such as the marketing-department building.
- **User-based classification**. Use for people who create, review, or modify data. However, this approach relies on user judgment. Therefore, it's the least consistent classification type. Also, it requires well-trained personnel and well-defined classification rules. You might want to apply this classification type for sending emails. When a user composes an email, they must choose the appropriate classification label before sending it.

> [!NOTE]
> It’s important to understand the different classification types, methods, and labels. The classification type or method is one of the four types just discussed. However, the classification label is the metadata you assign to classified data.

The most common classification labels include:

- Personal
- General
- Confidential
- Highly Confidential
- Restricted
- Public

## Common requirements for data classification

A specific organizational requirement typically drives data classification. A company might choose to classify its data to help ensure it's better managed and protected, internally and externally. In this scenario, the company might develop and apply a data-classification policy internally. Conversely, it might (or might not) follow general guidelines and regulations.

Many legal frameworks and regulations require or encourage organizations to classify their data. Requirements based on legal regulations might vary. They can depend on the types of data an organization collects, uses, stores, processes, or transmits.

The GDPR provides a good example. It requires organizations that manage personal data of EU citizens must classify the data types they collect. If they don't, they're not complying with GDPR regulations. Also, the GDPR itself categorizes some data types as *sensitive*, including biometric data, race, ethnic origin, political opinions, and health data. It then requires these data types have protection. Therefore, organizations must know what data types they have, how to classify them, and whether they're required to help protect them.

## Relation between data classification and data protection

Data classification and data protection are two separate and very different processes! It's crucial to understand the outcomes and results of each process.

<!-- ID/SME: To address acrolinx's concern with repeated uses of "for example", I've rewritten this paragraph. Please confirm it's OK. -->As discussed before, the result of data classification is metadata. This metadata provides information on data's classification and enables you to label it. Perhaps you label it *public*, *confidential*, or *restricted*. In the technical context, classification and metadata don't provide data protection. They might provide protection in the human context, which means a well-educated employee won’t share or misuse data classified as confidential. However, classification doesn't technically prevent a user from doing anything with the data.

Conversely, data protection is a technology that provides specific technical context. In most cases, this helps prevents access to data. You often can help protect data by applying encryption. It helps prevents unauthorized users from accessing it. You also can apply digital signatures that help prevent users from changing content. Additionally, apply a permission model to help protect data. It specifies who can access data and what type of access they have. The NTFS file system provides this type of permission model.

> [!NOTE]
> It’s important to understand that data classification doesn’t guarantee or provide data protection. Very commonly, data protection is based on data's classification value. You then must implement a manual or automatic process that applies protection based on the classification value.

Use technologies such as Azure Information Protection, which you’ll learn about in later units, to:

- Classify data automatically based on criteria you establish.
- Provide automatic data protection by encrypting data based on classification labels you assign.

Perhaps you configure data protection for each file classified and labeled as confidential. You then configure it to be encrypted and accessible only to users who are members of a particular group, such as Managers.
