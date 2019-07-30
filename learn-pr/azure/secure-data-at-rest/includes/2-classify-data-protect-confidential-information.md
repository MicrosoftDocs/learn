To understand what level of encryption is required for your product, you need to classify the data. By the end of this unit, you'll:

- Understand the classifications of Confidential, Internal, or Public.

- Understand structured vs unstructured data.

- Understand the options for At Rest, Keys, and Secrets.


## Data classification

All data can be in different states. At the most basic level, data can be in process (being generated), in transit (on the move), or at rest (settled and stored somewhere).  Data can be categorized into different levels of classifications. When data is classified in one of these levels, it has to adhere to this classification, whatever its current state. For example, when data is classified as highly confidential, it's expected to stick to this level of classification – whether it's in process, in transit or at rest.  You use technical solutions to address compliance with data classification.

Classification is based on the importance of the data to the business and its stakeholders. All data has some level of impact. This impact can be financial, legal, or reputational. It's common to read about frightening scenarios for organizations. Customer data may have been leaked, or a company's internal data might have been distributed online for all to access.  The impact on the organization and its customers can be devastating.  That's the reason why data is classified by its expected impact on the business and stakeholders.

The terms used can vary between organizations but they generally fall into the following general levels: High, Medium, and Low.  For example, an organization might have these three classifications:

- **Confidential (High level)** – if this data is exposed or lost, it would be devastating to the organization or the concerned individual, whether they're a customer or an employee.

  Here are some examples of the type of data that could be classified with this level:

  - Personal data.
  - Financial data.
  - Code or intellectual property belonging to an organization.
  - Legal data.
  - Passwords, user/application credentials, cryptographic keys, and certificates.

- **Internal Use Only (Medium level)** – if this data is exposed or lost, the impact wouldn't be so severe as for confidential data. However, because it's information that should only be viewed internally, it would still have an impact. This information might help malicious actors to understand how to access data of higher-level confidentiality.  

  Here are some examples of the type of data that could be classified with this level:

  - Emails that can be deleted or distributed without a severe impact.
  - Files that don't include any confidential data.

  Unless classified explicitly as confidential, or for public consumption, you should consider all data in an organization to be – at a minimum – classified at this medium level.

- **Public (Low)** – the data that can be shown publicly outside of the organization.  Often, this is data that must be deliberately shared to the outside world for business purposes.

  - For example, manuals explaining a new product.

  - A new public website showcasing a new solution.

  - A public interview to make an announcement concerning a new strategy.



## Structured and unstructured data 

Generally, you can categorize data into either structured or unstructured. Structured data is easy to work with and more readable. Think about a spreadsheet showing employee details. You'd have columns for details about each employee – for example, employee ID, their role, and their salary. Here's an example showing what structured data could look like:

| Employee ID | Role     | Salary  |
| ----------- | -------- | ------- |
| 12345       | Cashier  | $25,102 |
| 67890       | Cashier  | $25,102 |
| 10123       | Security | $25,301 |

Unstructured data is easier to work with for computers – it's also more flexible, and a good choice for data that has high velocity. Here's an example of this sort of information in unstructured format:

```json
{
	"employees": [
        {
			"employee_id": 62345,
			"role": "Seller",
			"salary": "$25,101",
            "social_id": "@green_tea1"
		},
		{
			"employee_id": 17230,
			"role": "Seller",
			"salary": "$25,101",
            "social_id": "@spiderPerson99"
		},
		{
			"employee_id": 24122,
			"role": "Security",
			"salary": "$25,301"
		}
	]
}
```

Notice that the data is more flexible. The social ID field doesn't need to be present for employees with security roles. With structured data, you'd need a whole column present for it, even if it isn't relevant for some employees.

Data would generally be in unstructured format if it needs to go through applications to use. The application would apply structure to it. For example, in an email application, the source data would be in an unstructured format. A structure would be applied to the data by the application. In another example, streaming data about live locations of traveling users can be fed in unstructured format to an application. That application is then used to draw holistic insights from this high velocity unstructured data.

All data must be managed and classified based on its impact on the organization and its stakeholders, regardless of whether it's in a structured or unstructured format. 

After you've classified the data – whether it's unstructured or structured – you must protect it. Here, you'll focus on how to protect this data at rest. In later units, you'll address how solutions such as Azure Storage Service Encryption, Azure Disk Encryption, Azure Key Vault, and others are employed to ensure your data is secured and protected.
