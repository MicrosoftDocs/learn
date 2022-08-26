The business glossary is a definition of terms specific to a domain of knowledge that is commonly used, communicated, and shared in organizations as they are conducting business.

A glossary provides vocabulary for business users.  It consists of business terms that can be related to each other and allows them to be categorized so that they can be understood in different contexts. These terms can be then mapped to assets like a database, tables, columns etc. This helps in abstracting the technical jargon associated with the data repositories and allows the business user to discover and work with data in the vocabulary that is more familiar to them.

A business glossary is a collection of terms. Each term represents an object in an organization and it is highly likely that there are multiple terms representing the same object. A customer could also be referred to as client, purchaser, or buyer. These multiple terms have a relationship with each other. The relationship between these terms could one of the following:

synonyms - different terms with the same definition
related - different name with similar definition
The same term can also imply multiple business objects. It is important that each term is well-defined and clearly understood within the organization.

## Why have business glossary?

Our data assets already have classifications and sensitivity labels-- what good is business glossary going to do for us?
A business glossary allows you to map data assets to business practices like:

- Standups, projects, and systems
- Business meetings
- Presentations
- Reporting and business rules
- Organizational language
- Etc...

Essentially, the business glossary allows users to search for and find data based on the every day language they already use, rather than having to wade through technical titles to make guesses.

## Glossary vs classification vs sensitivity label vs managed attribute

We already have three kinds of labels for our data assets, so what's the difference?

**Business glossary** terms define the business vocabulary for an organization and helps in bridging the gap between various departments in your company.
**Classifications** are annotations that can be assigned to entities. The flexibility of classifications enables you to use them for multiple scenarios such as understanding the nature of data stored in the data assets or defining access control policies.
**Sensitivity labels** are a type of annotation that allows you to classify and protect your organization's data, without hindering productivity and collaboration. Sensitivity labels are used to identify the categories of classification types within your organizational data, and group the policies that you wish to apply to each category.
**Managed attribute** A set of user-defined attributes that provide a business or organization level context to an asset. A managed attribute has a name and a value. For example, “Department” is an attribute name and “Finance” is its value.

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

Term Templates provides glossary custom attributes to be logically grouped together in catalog. The feature allows you to group all the relevant custom attributes together in a template and then apply the template while creating the glossary term. For example, all finance- related custom attributes like cost center, profit center, accounting code can be grouped in a term template Finance Template and the Finance template can be used to create financial glossary terms.

All the standard attributes are grouped in a system default template. Any term template that you create will contain these attributes along with any additional custom attributes created as part of template creation process.

## Bulk upload and editing

Data estates can be very large, so while glossary terms can be created and assigned manually through the Microsoft Purview governance portal, there are also options to operate in bulk.

You can use a CSV template and import terms in bulk using the Microsft Purview governance portal.

You can also edit assets in bulk and apply terms to multiple assets at the same time.
