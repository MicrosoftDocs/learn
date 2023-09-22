If you want to extract text, languages, and other information from documents with unpredictable structures, you can use the read, general document, or layout models.

In your polling company, customers and partners often send specifications, tenders, statements of work, and other documents with unpredictable structures. You want to know if Azure AI Document Intelligence can analyze and extract values from these documents.

Here, you'll learn about the prebuilt models that Microsoft provides for general documents.

## Using the read model

The Azure AI Document Intelligence read model extracts printed and handwritten text from documents and images. It is used to provide text extraction in all the other prebuilt models.

The read model can also detect the language that a line of text is written in and classify whether it is handwritten or printed text.

> [!NOTE]
> The detection of handwriting is only supported for Latin languages.

For multi-page PDF or TIFF files, you can use the `pages` parameter in your request to fix a page range for the analysis.

The read model is ideal if you want to extract words and lines from documents with no fixed or predictable structure.

## Using the general document model

The general document model extends the functionality of the read model by adding the detection of key-value pairs, entities, selection marks, and tables. The model can extract these values from structured, semi-structured, and unstructured documents.

The general document model is the only prebuilt model to support entity extraction. It can recognize entities such as people, organizations, and dates and it runs against the whole document, not just key-value pairs. This approach ensures that, when structural complexity has prevented the model extracting a key-value pair, an entity can be extracted instead. Remember, however, that sometimes a single piece of text may return both a key-value pair and an entity.

> [!NOTE]
> At the time of writing, the general document model is in preview.

The types of entities you can detect include:

- `Person`. The name of a person.
- `PersonType`. A job title or role.
- `Location`. Buildings, geographical features, geopolitical entities.
- `Organization`. Companies, government bodies, sports clubs, musical bands, and other groups.
- `Event`. Social gatherings, historical events, anniversaries.
- `Product`. Objects bought and sold.
- `Skill`. A capability belonging to a person.
- `Address`. Mailing address for a physical location.
- `Phone number`. Dialing codes and numbers for mobile phones and landlines.
- `Email`. Email addresses.
- `URL`. Webpage addresses.
- `IP Address`. Network addresses for computer hardware.
- `DateTime`. Calendar dates and times of day.
- `Quantity`. Numerical measurements with their units.

## Using the layout model

As well as extracting text, the layout model return selection marks and tables from the input image or PDF file. It's a good model to use when you need rich information about the structure of a document.

When you digitize a document, it can be at an odd angle. Tables can have complicated structures with or without headers, cells that span columns or rows, and incomplete columns or rows. The layout model can handle all of these difficulties to extract the complete document structure. 

For example, each table cell is extracted with:

- Its content text.
- The size and position of its bounding box.
- If it's part of a header column.
- Indexes to indicate its row and column position in the table.

Selection marks are extracted with their bounding box, a confidence indicator, and whether they are selected or not. 

## Learn more

- [Language support for Azure AI Document Intelligence](/azure/applied-ai-services/form-recognizer/language-support)
- [Azure AI Document Intelligence read model](/azure/applied-ai-services/form-recognizer/concept-read)
- [Azure AI Document Intelligence general document model](/azure/applied-ai-services/form-recognizer/concept-general-document)
- [Azure AI Document Intelligence layout model](/azure/applied-ai-services/form-recognizer/concept-layout)
