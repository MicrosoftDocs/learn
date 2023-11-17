The **Azure AI Vision** service offers two APIs that you can use to read text.

- The **Read** API:
    - Use this API to read small to large volumes of text from images and PDF documents.
    - This API uses a newer model than the OCR API, resulting in greater accuracy.
    - The Read API can read printed text in multiple languages, and handwritten text in English.
    - The initial function call returns an asynchronous operation ID, which must be used in a subsequent call to retrieve the results.
- The **Image Analysis** API:
    - Currently still in preview, with reading text functionality added version 4.0.
    - Use this API to read small amounts of text from images.
    - Returns contextual information, including line number and position.
    - Results are returned immediately (synchronous) from a single function call.
    - Has functionality for analyzing images past extracting text, including detecting content (such as brands, faces, and domain-specific content), describing or categorizing an image, generating thumbnails and more.

You can access both technologies via the REST API or a client library. In the next few units, we'll show you how to call the REST API and return a JSON response for the Read API. Then for the exercise, you'll use a client library to return objects that abstract the JSON response.

Since the Image Analysis API functionality for extracting text from images was only added in version 4.0 and is still in preview, the rest of this module will only cover the Read API.
