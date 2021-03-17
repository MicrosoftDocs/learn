Azure Form Recognizer is a cognitive service that extracts data from images and documents using machine learning. Form Recognizer can analyze and extract data from various types of documents, including forms, tables, written and typed documents, receipts, invoices, and business cards.

Extracting data manually from large numbers of forms is difficult. Using a service, such as Form Recognizer, you can automate this process and help lower errors for data entry, save time, and ensure easily accessible data.

Form Recognizer is a service available by REST API and SDK that runs on Azure. The service analyzes JPG and PNG images, and PDF or TIFF documents, and extracts the key data you need, and compiles the data in JSON format.

## The services

There are three services with different functions available through Form Recognizer:

**Layout API** extracts text, tables, selection marks, and structure information from documents and returns them in an organized structured JSON response. Documents can be from a variety of formats and quality, including phone-captured images, scanned documents, and PDFs.

![Example of Layout API with selection marks, text, and tables identified and represented in JSON format.](../media/layout-tool-example.jpeg)

**Pre-built models** analyze three unique form types: invoices, sales receipts, and business cards. This service combines Optical Character Recognition (OCR) capabilities with deep learning models that understand invoice, receipt, and business card information to extract key information in multiple languages.

**Custom models** are created by uploading five or more sample forms. Form recognizer then trains a custom model that can extract data tailored specifically to your forms. After you train a custom model, you can test and retrain it to reliably extract data from more forms according to your needs.

Your small business may start out by using pre-built models to analyze sales receipts and invoices, saving yourself time from doing all of the data entry manually. Later, you may look to a custom model for regulary receipts and invoices to help fully automate your data entry with a high degree of accuracy.
