When classifying data, you need to establish a methodology for this process. There is no software or technology that can tell you how to classify your data. There are many different ways on how you can approach this, and this usually depends on the type of organization or company, as well as on type of business or work the company or organization is doing. Of course, it also depends on data that company or organization handles. Let's look at some more most common scenarios and approaches. 

## Most common types of data classification

Although you can choose to classify your data in many different ways, some most common type of data classification include:

- **Classification based on data content** - If you use this approach, you need to classify your data based on the content. For example, based on the data content you can assign classification labels such as *public*, *internal*, *confidential* and *highly confidential*. In some cases, this approach requires that you manually review each document (or other data format) to determine and apply proper classification label. This may be a very time consuming process. Also, in some cases, you can automate this type of classification by searching for specific keywords in the data, and use that as a condition for classification. For example, you can search for a specific pattern or word (such as *contract*) to automatically classify the data.
- **Classification based on data location** - In this approach, data is classified by location where it resides. You can use this approach if scenarios where you already applied some kind of location-based classification. For example, if you have all your confidential contracts in one folder on your file server, then you can automatically apply appropriate classification label to all documents in this folder. However, this type of data classification is not very efficient in today's world where data resides on many different locations.
- **Context based classification** - With this approach, you classify data based on some kind of meta data (or context) related to specific file. It can be an application that created the file (for example, financial software), the person who created the document (for example, managers), or the location in which files were created or modified (for example, marketing department building).
- **User based classification** - This classification approach relies on a user who create, review of modify data. Because this classification type relies on user judgement, it is least consistent classification type. Also, this classification type requires well trained personnel, and well defined rules for classification. For example, this classification type can be applied for sending emails. After a user writes an email, he or she should choose appropriate classification label, before the email is sent to the recipient.

It is important to understand the difference between classification type (sometimes also referred as classification method) from classification label. While classification type can be one of the four types that we just described, classification label is actually the meta data that you assign to classified data. 

Some most commonly used classification labels include:

- Personal
- Internal
- Confidential
- Highly Confidential
- Restricted
- Public

## Common requirements for data classification

Data classification is usually being done based on some kind of requirement. A company may choose to classify its data, so it can be better handled and protected both internally and externally. In such scenario, data classification policy is completely developed and applied internally, and it might or might not follow some general guidelines or regulations. 

However, there any many legal frameworks or regulations that require or encourage companies and organizations to classify their data. Requirements based on legal regulations may vary depending on the types of data that organization or company collects, uses, stores, processes, or transmits.

For example, when it comes to GDPR, organizations and companies that handle the personal data of EU citizens must classify the types of data they collect in order to comply with GDPR regulations. Also, GDPR itself already categorizes some types of data such as biometric data, race, ethnic origin, political opinions, and health data – as sensitive and these data needs protection, not just classification. This means that organizations need to know what types of data they hold, and how to classify this data. Other examples of such regulations are SOC 2, HIPAA, PCI and others.

## Relation between data classification and data protection

Data classification and data protection are two separate and very different processes. It is crucial to have a good understanding on outcomes and results of each process. 

As we discussed before, result of data classification (whichever method is used) is meta data, usually a label, that provides an information on how data is classified. For example, this label can be *public*, *confidential* or *restricted*. However, classification and label do not provide data protection, in technical context. It may provide protection in human context, so that well educated employee will not share or misuse data classified as *confidential*, but classification actually does not technically prevent a user from doing anything with the data.

On the other hand, data protection is a technology that provides specific technical context that, in most cases, prevents access to data or data content. For example, data can be protected by applying encryption, which prevents unauthorized users from accessing it, or by applying digital signature, which prevents users from changing the content. Also, data can be protected by applying a permission model which specify who can access data, and what kind of access will have. NTFS provides such permission model.

> [!NOTE]

> It is important to understand that data classification does not guarantee or provide data protection. Very commonly, data protection is based on classification label, but you need to implement manual, or preferably automatic process that will apply protection based on classification label.

You can use technology such as Azure Information Protection (which we will discuss later) that will automatically classify the data based on criteria you establish, and provide automatic data protection by encrypting data based on classification label assigned. For example, you can configure data protection in a way that each file that is classified and labeled as **confidential** is encrypted and accessible only to users that are member of group *Managers*.