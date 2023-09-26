Support for multiple languages can be added to a search index. You can add language support manually by providing all the translated text fields in all the different languages you want to support. You could also choose to use Azure AI Services to provide translated text through an enrichment pipeline. 

Here, you'll see how to add fields with different languages to an index. You'll then constrain results to fields with specific languages. Finally, create a scoring profile to boost the native language of your end users.

### Add language specific fields

To add multiple languages to an index, first, identify all the fields that need a translation. Then duplicate those fields for each language you want to support.

For example, if an index has an English description field, you'd add description_fr for the French translation and description_de for German. For each field, add to its definition the [corresponding language analyzer](/azure/search/index-add-language-analyzers#supported-language-analyzers).

The JSON definition of the index could look like this:

```json
    {
      "name": "description",
      "type": "Edm.String",
      "facetable": false,
      "filterable": false,
      "key": false,
      "retrievable": true,
      "searchable": true,
      "sortable": false,
      "analyzer": "en.microsoft",
      "indexAnalyzer": null,
      "searchAnalyzer": null,
      "synonymMaps": [],
      "fields": []
    },
    {
      "name": "description_de",
      "type": "Edm.String",
      "facetable": false,
      "filterable": false,
      "key": false,
      "retrievable": true,
      "searchable": true,
      "sortable": false,
      "analyzer": "de.microsoft",
      "indexAnalyzer": null,
      "searchAnalyzer": null,
      "synonymMaps": [],
      "fields": []
    },
    {
      "name": "description_fr",
      "type": "Edm.String",
      "facetable": false,
      "filterable": false,
      "key": false,
      "retrievable": true,
      "searchable": true,
      "sortable": false,
      "analyzer": "fr.microsoft",
      "indexAnalyzer": null,
      "searchAnalyzer": null,
      "synonymMaps": [],
      "fields": []
    },
    {
      "name": "description_it",
      "type": "Edm.String",
      "facetable": false,
      "filterable": false,
      "key": false,
      "retrievable": true,
      "searchable": true,
      "sortable": false,
      "analyzer": "it.microsoft",
      "indexAnalyzer": null,
      "searchAnalyzer": null,
      "synonymMaps": [],
      "fields": []
    },
```

### Limit the fields for a language

In this module, you've already seen how to limit the fields returned in a search request. You can also select which fields are being searched. Your language specific search solution can combine these two features to focus on fields with specific languages in them.

`search='parfait pour se divertir'&$select=listingId, description_fr, city, region, tags&$searchFields=tags, description_fr&queryType=full`

Using the `searchFields` and `select` properties in the above results would return these results from the real estate sample database.

```json
{
  "@odata.context": "https://advanced-cognitive-search.search.windows.net/indexes('realestate-us-sample-index')/$metadata#docs(*)",
  "value": [
    {
      "@search.score": 12.124968,
      "listingId": "OTM4MjY1OA2",
      "description_fr": "Il s'agit d'un condo et est parfait pour se divertir.  Cette maison offre des vues côtières Situé à proximité d'une rivière et un bureau, moulures and une véranda couverte.",
      "city": "Seattle",
      "region": "wa",
      "tags": [
        "condo",
        "entertaining",
        "coastal views",
        "river",
        "office",
        "crown mouldings",
        "covered front porch"
      ]
    },
```

### Enrich an index with multiple languages using Azure AI Services

If you don't have access to translations, you can enrich your index and add translated fields using Azure AI Services.

The steps are to add fields for each language, add a skill for each language, and then map the translated text to the correct fields.

For example, let's add Japanese and Ukrainian translations to an example retail properties index.

#### Add the new fields

Add two new fields to the index with these properties, the first to store the Japanese translation and the seconded the Ukrainian:

```json
{
  "name": "description_jp",
  "type": "Edm.String",
  "facetable": false,
  "filterable": false,
  "key": false,
  "retrievable": true,
  "searchable": true,
  "sortable": false,
  "analyzer": "ja.microsoft",
  "indexAnalyzer": null,
  "searchAnalyzer": null,
  "synonymMaps": [],
  "fields": []
},
{
  "name": "description_uk",
  "type": "Edm.String",
  "facetable": false,
  "filterable": false,
  "key": false,
  "retrievable": true,
  "searchable": true,
  "sortable": false,
  "analyzer": "uk.microsoft",
  "indexAnalyzer": null,
  "searchAnalyzer": null,
  "synonymMaps": [],
  "fields": []
}
```

#### Add the translation skillsets

You add two skills into the skillset definition to translate the `document/description` fields into the two languages.

```json
"skills": [
  {
    "@odata.type": "#Microsoft.Skills.Text.TranslationSkill",
    "name": "#1",
    "description": null,
    "context": "/document/description",
    "defaultFromLanguageCode": "en",
    "defaultToLanguageCode": "ja",
    "suggestedFrom": "en",
    "inputs": [
      {
        "name": "text",
        "source": "/document/description"
      }
    ],
    "outputs": [
      {
        "name": "translatedText",
        "targetName": "description_jp"
      }
    ]
  },
  {
    "@odata.type": "#Microsoft.Skills.Text.TranslationSkill",
    "name": "#2",
    "description": null,
    "context": "/document/description",
    "defaultFromLanguageCode": "en",
    "defaultToLanguageCode": "uk",
    "suggestedFrom": "en",
    "inputs": [
      {
        "name": "text",
        "source": "/document/description"
      }
    ],
    "outputs": [
      {
        "name": "translatedText",
        "targetName": "description_uk"
      }
    ]
  }
]
```

#### Map the translated output into the index

The last step is to update the indexer to map the translated text into the index.

```json
"outputFieldMappings": [
  {
    "sourceFieldName": "/document/description/description_jp",
    "targetFieldName": "description_jp"
  },
  {
    "sourceFieldName": "/document/description/description_uk",
    "targetFieldName": "description_uk"
  }
]
```

The documents now all have two new translated description fields.

```json
  "value": [
    {
      "@search.score": 1,
      "listingId": "OTM4MjI2NQ2",
      "beds": 5,
      "baths": 4,
      "description": "This is an apartment residence and is perfect for entertaining.  This home provides lakefront property located close to parks and features a detached garage, beautiful bedroom floors, and lots of storage.",
      "description_de": "Dies ist eine Wohnanlage und ist perfekt für Unterhaltung.  Dieses Haus bietet Seeliegenschaft Parks in der Nähe und verfügt über eine freistehende Garage schöne Zimmer-Etagen and viel Stauraum.",
      "description_fr": "Il s'agit d'un appartement de la résidence et est parfait pour se divertir.  Cette maison offre propriété au bord du lac Situé à proximité de Parcs et dispose d'un garage détaché, planchers de belle chambre and beaucoup de rangement.",
      "description_it": "Si tratta di un appartamento residence ed è perfetto per intrattenere.  Questa casa fornisce proprietà lungolago Situato vicino ai parchi e dispone di un garage indipendente, piani di bella camera da letto and sacco di stoccaggio.",
      "description_es": "Se trata de una residencia Apartamento y es perfecto para el entretenimiento.  Esta casa ofrece propiedad de lago situado cerca de parques y cuenta con un garaje independiente, pisos de dormitorio hermoso and montón de almacenamiento.",
      "description_pl": "Jest to apartament residence i jest idealny do zabawy.  Ten dom zapewnia lakefront Wlasciwosc usytuowany w poblizu parków i oferuje garaz wolnostojacy, piekna sypialnia podlogi and mnóstwo miejsca do przechowywania.",
      "description_nl": "Dit is een appartement Residentie en is perfect voor entertaining.  Dit huis biedt lakefront eigenschap vlakbij parken en beschikt over een vrijstaande garage, mooie slaapkamer vloeren and veel opslag.",
      "description_jp": "これはアパートの住居であり、娯楽に最適です。 この家は公園の近くに位置する湖畔のプロパティを提供し、独立したガレージ、美しいベッドルームの床とストレージの多くを備えています。",
      "description_uk": "Це багатоквартирна резиденція і прекрасно підходить для розваг.  Цей будинок забезпечує нерухомість на березі озера, розташовану недалеко від парків, і має окремий гараж, красиві підлоги спальні та багато місць для зберігання речей.",
      ...
    },
```
