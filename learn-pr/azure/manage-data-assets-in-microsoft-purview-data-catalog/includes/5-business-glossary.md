The business glossary is a collection of terms and their definitions specific to your data estate and its operations. It provides a vocabulary for your business users to navigate your data and organization.

These terms can be then mapped to assets like a database, tables, columns etc., and even related to each other. This allows your data catalog to be a relatable, searchable representation of your data estate, rather than a repository full of technical jargon.

## Why have business glossary?

Our data assets already have classifications and sensitivity labels--what good is business glossary going to do for us?
A business glossary allows you to map data assets to business practices like:

- Standups, projects, and systems
- Business meetings
- Presentations
- Reporting and business rules
- Organizational language
- Etc.

Essentially, the business glossary allows users to search for and find data based on the everyday language they already use, rather than having to wade through technical titles to make guesses.

## Glossary vs classification vs sensitivity label vs managed attribute

We already have three kinds of labels for our data assets, so what's the difference?

- **Business glossary terms** - define the business vocabulary for an organization and help bridge the gap between technical data and its everyday context in your organization. For example: Fabrikam Monthly Financial Reporting, which can be attached to all data sources used to build the report to make it clear where the data is gathered or how data is being used.
- **Classifications** - descriptors that can be assigned to assets to tell what kind of data it is. Some examples of classifications are: passport number, driver's license number, credit card number.
- **Sensitivity labels** - a type of descriptor that allows you to identify and protect your organization's sensitive data. Sensitivity labels are used to identify the categories of classification types within your organizational data, and group security policies that you want to apply to each category. For example, a security policy to protect all data recognized as credit card numbers.
- **Managed attributes** - a set of user-defined attributes that provide more description or context for assets. A managed attribute has a name and a value. For example, “Department” is an attribute name and “Finance” is its value, so assets can be aligned with a department.

## What's in a term?

So, now that we know what a business glossary term is, what's inside?
Microsoft Purview supports eight out-of-the-box attributes for any business glossary term:

- Name (mandatory)
- Nickname
- Status
- Definition
- Stewards
- Experts
- Acronym
- Synonyms
- Related terms
- Resources
- Parent term

However, these attributes may not be sufficient to completely define a term in an organization. To solve this problem, Microsoft Purview provides a feature where you can define custom attributes for your glossary.

## Term templates

Term Templates allow you to create custom definitions for your terms in Microsoft Purview that can be used across your organization. For example, all finance-related custom attributes like cost center, profit center, accounting code can be grouped in a term template called Finance Template and the new Finance Template can be used to create all financial glossary terms so that they'll all contain these custom attributes.

All the standard attributes are grouped in a system default template. Any term template that you create will contain these attributes along with any other custom attributes created as part of template creation process.

## Developing your glossary

Microsoft Purview also has an in-built system for developing your business glossary. All terms have a 'status' which lets users know if a term is ready to be used.
Currently you can set the following status on each term:

- **Draft** - This term isn't yet officially implemented.
- **Approved** - This term is official/standard/approved.
- **Expired** - This term should no longer be used.
- **Alert** - This term needs attention.

:::image type="content" source="../media/business-glossary/asset-status.png" alt-text="Screenshot of glossary terms in Microsoft Purview with their status highlighted.":::
