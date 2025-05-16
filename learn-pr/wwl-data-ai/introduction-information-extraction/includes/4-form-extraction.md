Forms and other documents have text data with *semantic meaning*. Semantic meaning refers to the intended meaning or interpretation of words, phrases, or symbols in a given context. Semantic meaning goes beyond just the literal definition of a word (syntax) and focuses on what the word or sentence actually conveys.

*Document intelligence* describes AI capabilities that process text and attach semantic meaning to the extracted text. As an extension of optical character recognition (OCR), document intelligence automates the process of extracting and understanding information. 

Consider an organization that needs to process large numbers of receipts for expenses claims, project costs, and other accounting purposes. Using document intelligence, the company can take a scanned image of a receipt, digitize the text with OCR, and extract semantic meaning. The semantic meaning of data in forms can be described in field-value pairs. 

- The **field name**, is the key, or type of data entry.   
- The **feild description** is the definition of what the field name represents.  
- The **value** cooresponds with the field name and is the data specific to the content.  

For example, in an invoice, the fields recognized may include:

- Name, address, and telephone number of the merchant
- Date and time of the purchase
- Name, quantity, and price of each item purchased
- Total, subtotals, and tax values

The data in forms is recognized with *bounding boxes*.

![A screenshot of a scanned receipt for the purchase of a Surface Pro and a Surface Pen.](../media/contoso-receipt.png)

For example, the address information in on the receipt is saved as a `field name`, `address` and a `value`, `123 Main Street` with coordinates [4.1, 2.2], [4.3, 2.2], [4.3, 2.4], [4.1, 2.4]. Machine learning models can interpret the data in a document or form because they're trained to recognize patterns in bounding box coordinate locations.

The results of data extraction are associated with **confidence levels** for each field and data pair. This *confidence level* is a percentage between 0 and 1, indicating the likely level of accuracy. Data extracted with a high confidence score (closer to 1) could be relied on more confidently to actually represent what is in the original content. 