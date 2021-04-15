To use the Form Recognizer resource you first need an Azure subscription, which you can create for free, and a Form Recognizer resource. The resource provides you with an endpoint and key, with which you can access the Form Recognizer service through REST or by using the appropriate software development kit (SDK). SDKs are available in these languages:

* .NET
* Python
* Java
* JavaScript

The service analyzes JPG and PNG images, and PDF or TIFF documents, and extracts the key data you need, and compiles the data in JSON format.

## The services

There are three services with different functions available through Form Recognizer:

**Layout API** extracts text, tables, selection marks, and structure information from documents and returns them in an organized structured JSON response. Documents can be from various file formats and quality, including phone-captured images, scanned documents, and PDFs.

![Example of Layout API with selection marks, text, and tables identified and represented in JSON format.](../media/layout-tool-example.jpeg)

**Pre-built models** analyze three unique form types: invoices, sales receipts, and business cards. This service combines Optical Character Recognition (OCR) capabilities with deep learning models that understand invoice, receipt, and business card information to extract key information in multiple languages.

**Custom models** are created by uploading five or more sample forms. Form recognizer then 'trains' a custom model that can extract data tailored specifically to your forms. After you train a custom model, you can test and retrain it to reliably extract data from more forms according to your needs.

Form Recognizer is designed to put the key information you need in one place. By using the pre-built or customs model, it becomes easier to find and utilize that information.
