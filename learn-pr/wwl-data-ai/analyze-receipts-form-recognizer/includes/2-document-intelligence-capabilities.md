Document intelligence relies on machine learning models that are trained to recognize data in text. The ability to extract text, layout, and key-value pairs are known as *document analysis*. Document analysis provides locations of text on a page identified by bounding box coordinates. 

![A screenshot of a scanned receipt for the purchase of a Surface Pro and a Surface Pen.](../media/contoso-receipt-small.png)

For example, the information in on the receipt `123 Main Street` is saved as a `key`, `address` and a `value`, `123 Main Street`. Document analysis could record the location of the field value as bounding box coordinates [4.1, 2.2], [4.3, 2.2], [4.3, 2.4], [4.1, 2.4]. Machine learning models can interpret the data in a document or form because they are trained to recognize patterns in bounding box coordinate locations and text.

A challenge for automating the process of analyzing documents is that forms and documents come in all different formats. For example, while tax forms and driver's license documents both include an individual's name, the bounding box coordinates for the name differ. Separate machine learning models need to be trained to provide high quality results for different forms and documents. In this way, sometimes you might be able to use prebuilt machine learning models that have been trained on commonly used document formats. Other times, you might need to customize a machine learning model to recognize a unique document format. 

Automating the process of reading text and recording data can accelerate operations, create better customer experiences, improve decision making, and more. Next you will explore how to use Azure AI services to implement document intelligence.  

