The **Computer Vision** service offers two APIs that you can use to read text.

- The **OCR** API:
    - Use this API to read small to medium volumes of text from images.
    - The API can read text in multiple languages.
    - Results are returned immediately from a single function call.
- The **Read** API:
    - Use this API to read small to large volumes of text from images and PDF documents.
    - This API uses a newer model than the OCR API, resulting in greater accuracy.
    - The Read API can read printed text in multiple languages, and handwritten text in English.
    - The initial function call returns an asynchronous operation ID, which must be used in a subsequent call to retrieve the results.

> [!div class="mx-imgBorder"]
> ![The computer vision service offers the OCR API and Read API.](../media/choose-api.png)

You can access both technologies via the REST API or a client library. In the next few units, we'll show you how to call the REST API and return a JSON response. Then for the exercise, you'll use a client library to return objects that abstract the JSON response. 
