In Azure Cognitive Search, an index is a persistent collection of JSON documents and other content used to enable search functionality. The documents within an index can be thought of as rows in a table, each document is a single unit of searchable data in the index. 

### Index schema

The index includes a definition of the structure of the data in these documents, called its schema. An example of an index schema is below: 

```json
{
  "name": "hotels",  
  "fields": [
    { "name": "HotelId", "type": "Edm.String", "key": true, "filterable": true },
    { "name": "HotelName", "type": "Edm.String", "searchable": true, "filterable": false, "sortable": true, "facetable": false },
    { "name": "Rating", "type": "Edm.Double", "filterable": true, "sortable": true, "facetable": true },
    { "name": "Address", "type": "Edm.ComplexType", 
      "fields": [
          { "name": "StreetAddress", "type": "Edm.String", "filterable": false, "sortable": false, "facetable": false, "searchable": true },
          { "name": "City", "type": "Edm.String", "searchable": true, "filterable": true, "sortable": true, "facetable": true },
          { "name": "StateProvince", "type": "Edm.String", "searchable": true, "filterable": true, "sortable": true, "facetable": true },
          { "name": "PostalCode", "type": "Edm.String", "searchable": true, "filterable": true, "sortable": true, "facetable": true },
          { "name": "Country", "type": "Edm.String", "searchable": true, "filterable": true, "sortable": true, "facetable": true }
        ]
    },
    { "name": "Location", "type": "Edm.GeographyPoint", "filterable": true, "sortable": true },
    { "name": "Rooms", "type": "Collection(Edm.ComplexType)", 
      "fields": [
          { "name": "Description", "type": "Edm.String", "searchable": true, "filterable": false, "sortable": false, "facetable": false, "analyzer": "en.lucene" },
          { "name": "BedOptions", "type": "Edm.String", "searchable": true }
        ]
    }
  ]
}
```

### Index attributes

An Azure Cognitive Search index can be thought of as a container of searchable documents. In database terms, the index is a table in the database, and each document is a row. Tables have columns, and the columns can be thought of as equivalent to the fields in a document. Columns have data types, just as the fields do on the documents.

![Diagram that illustrates how documents are stored in the search index with associated fields.](../media/what-is-an-index.png)

Azure Cognitive Search needs to know how you'd like to search and display the fields in the documents, and you specify that by assigning attributes, or behaviors, to these fields. For each field in the document, the index stores its name, the data type, and supported behaviors for the field such as, is the field searchable, can the field be sorted?

### Field behaviors

When creating your index, you need to choose the behaviors each field supports. The available options depend on what type of data is stored in the field:

- **Retrievable**: can this field be returned in the search results
- **Filterable**: can this field be used in filter expressions
- **Sortable**: can this field be sorted on in order by queries
- **Facetable**: can this field be used to group results to enable faceted navigation of the results
- **Searchable**: only available on text fields. Can this field be searched against
- **Analyzer to use**: only available on text fields. You choose the language analyzer for the field that processes text in a query.

The most efficient indexes use only the behaviors that are needed. If you forget to set a required behavior on a field when designing, the only way to get that feature is to rebuild the index.

The following image depicts the fields when designing an Index in Azure:

![Screenshot showing an example index with different fields.](../media/2-index-workflows.png)










