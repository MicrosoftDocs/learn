There may be many scenarios where form analysis is required. We present a few considerations here that offer insight into some applications of Form Recognizer. Using these scenarios, you may come up with other ideas on how you might integrate the Form Recognizer into your applications.

## Bulk Data Extraction

Businesses often receive various types of forms from their varying clients, which can be difficult to parse through and take up valuable time. By extracting the data from forms and combining it with existing operational systems and data warehouses, businesses can get insights and deliver value to their customers and business users.

## Integration with Cognitive Search

Many organizations sit on troves of historical data, and Azure Cognitive Search provides a sophisticated for that data. By integrating Form Recognizer with Cognitive Search, it's possible to add capabilities from Form Recognizer as a step in an end-to-end enrichment pipeline. The pipeline can then load the documents and do other transformations.

Organizations can search and retrieve data from file types that would normally require each file to be manually reviewed.

## Augmenting manual data entry

Many transactional use cases require manual intervention. Data entry can be tedious, and lead to errors. Form Recognizer can integrate into existing applications, and provides a standard JSON response, allowing developers to check manual data entry with Form Recognizer. The standard responses allow simple logic to check if data points from manual data entry and Form Recognizer are significantly different - for example, if a decimal place was missed during manual data entry.
