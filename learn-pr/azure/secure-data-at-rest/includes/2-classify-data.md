Your organization has several systems that store customer details, financial information, and other data that needs to be protected. You need to understand the data better by classifying it, by identifying the different states that it can be in, and by learning the ways in which data can be structured.

Here, you learn the different states of data. We discuss the classifications of confidential, internal, or public data, and show you how to differentiate structured data from unstructured data.

## Data states

All data can be in different states at different moments in time. At the most basic level, data can have theses states:

- **Data at rest** is settled and stored somewhere. It can include storage objects and files that are on physical media. The media can be optical disks or magnetic disks such as HDDs.
- **Data in transit** is being moved, whether over a network or between two locations (or applications).
- **Data in use** is being processed, updated, generated, or accessed in some way.

A typical piece of data might go through all states throughout its lifecycle.

Data states and classifications are linked. You can't meet classification requirements for your data if you don't understand what its states are, and plan accordingly. 

If you can understand the states of your data throughout its lifecycle, together with its classification, you can put together solutions to better protect your data and meet regulatory and business requirements. Consider encrypting your data regardless of its state, unless the data is classified as explicitly not to be encrypted.

## Data classification

Data can be categorized into levels of classifications. When data is classified in one of these levels, it has to adhere to this classification, whatever its current state. For example, when data is classified as highly confidential, it's expected to stick to this level of classification whether it's in process, in transit, or at rest.

Classification is based on the importance of the data to the business and its stakeholders. All data has some level of impact. This impact can be financial, legal, or reputational.

Customer data can be leaked, or a company's internal data might be distributed online for all to access. The impact on the organization and its customers can be devastating. For these reasons, data is classified according to its expected impact on the business and stakeholders.

The terms for classification can vary between organizations, but they generally fall into the following levels: high, medium, and low. For example, an organization might have these three classifications:

- **Confidential (high level)**: If this data is exposed or lost, it substantially affects the organization or the individual, whether they're a customer or an employee. Examples are:

  - Personal data such as names and addresses.
  - Financial data such as account balances and deposits.
  - Code or intellectual property that belongs to an organization.
  - Passwords, user/application credentials, cryptographic keys, and certificates.
  
- **Internal use only (medium level)**: Information that should only be viewed internally, and must not be shared with anyone outside the organization. Examples are:

  - Emails that can be deleted or distributed without a severe impact.
  - Files that don't include any confidential data.

  You should consider all data in an organization to be classified at the medium level at a minimum. Change your expectations if the data is classified explicitly as confidential or for public consumption.

- **Public (low level)**: This data can be shown outside the organization. Often, this data must be deliberately shared to the outside world for business purposes. Examples are:

  - API documentation for a product or service that the organization offers to customers.
  - A new public website that's showcasing a new solution.
  - A public interview to make an announcement about a new strategy.

## Structured and unstructured data

Generally, you can categorize data as either structured or unstructured. 

Structured data can reside in a spreadsheet or a relational database. This type of data is in a fixed field that's part of a larger record. Think about a spreadsheet that shows employee details. You'd have columns for details about each employee, such as employee ID, role, and salary. Here's an example that shows what that type of structured data might look like:

| Employee ID | Role     | Salary  |
| ----------- | -------- | ------- |
| 12345       | Cashier  | $25,102 |
| 67890       | Cashier  | $25,102 |
| 10123       | Security | $25,301 |

Unstructured data might include images, videos, and files such as word processor documents. This type of data isn't captured in conventional, predefined fixed fields. For example, the source data for a PDF document is in an unstructured format but the application for that document, presents the data in a meaningful way. In another example, streaming video data of live streamers is unstructured in its raw form, but it's presented in a meaningful way for viewers.

All data must be managed and classified based on its impact on the organization and its stakeholders, regardless of whether it's in a structured or unstructured format.
