
Azure AI Search is configured by default to analyze text and identify tokens that will be helpful in your index. The right tokens ensure that users can find the documents they need quickly. In most cases, the default configuration produces an optimal index. However, when you have unusual or unique fields, you might want to configure exactly how text is analyzed.

Here, you'll learn how to define a custom analyzer to control how the content of a field is split into tokens for inclusion in the index.

## Analyzers in AI Search

When AI Search indexes your content, it retrieves text. To build a useful index, with terms that help users locate documents, that text needs processing. For example:

- The text should be broken into words, often by using whitespace and punctuation characters as delimiters.
- Stopwords, such as "the" and "it", should be removed because users don't search for them.
- Words should be reduced to their root form. For example, past tense words, such as "ran", should be replaced with present tense words, such as "run".

In AI Search, this kind of processing is performed by analyzers. If you don't specify an analyzer for a field, the default Lucene analyzer is used. The default Lucene analyzer is a good choice for most fields because it can process many languages and return useful tokens for your index. 

Alternatively, you can specify one of the analyzers that are built into AI Search. Built-in analyzers are of two types:

- **Language analyzers.** If you need advanced capabilities for specific languages, such as lemmatization, word decompounding, and entity recognition, use a built-in language analyzer. Microsoft provides 50 analyzers for different languages.
- **Specialized analyzers.** These analyzers are language-agnostic and used for specialized fields such as zip codes or product IDs. You can, for example, use the **PatternAnalyzer** and specify a regular expression to match token separators.

## What is a custom analyzer?

The built-in analyzers provide you with many options but sometimes you need an analyzer with unusual behavior for a field. In these cases, you can create a **custom analyzer**.

A custom analyzer consists of:

- **Character filters**. These filters process a string before it reaches the tokenizer.
- **Tokenizers**. These components divide the text into tokens to be added to the index.
- **Token filters.** These filters remove or modify the tokens emitted by the tokenizer.

Let's examine these components in more detail.

### Character filters

Some operations might need to be completed on the text before it's split into tokens. Character filters enable these operations. There are three character filters that you can use:

- **html_strip.** This filter removes HTML constructs such as tags and attributes.
- **mapping.** This filter enables you to specify mappings that replace one string with another. For example, you could specify a mapping that replaces *TX* with *Texas*.
- **pattern_replace.** This filter enables you to specify a regular expression that identifies patterns in the input text and how matching text should be replaced.

### Tokenizers

The tokenizer is the component that divides the text into the tokens that will be stored in the index. Tokenizers also break down words into their root forms. Often, a token is a single word, but you might want to create unusual tokens such as:

- A full postal address.
- A complete URL or email address.
- Words based on the grammar of a specific language.

There are 13 different tokenizers to choose from. These tokenizers include:

- **classic.** This tokenizer processes text based on grammar for European languages.
- **keyword.** This tokenizer emits the entire input as a single token. Use this tokenizer for fields that should always be indexed as one value.
- **lowercase.** This tokenizer divides text at non-letters and then modifies the resulting tokens to all lower case.
- **microsoft_language_tokenizer.** This tokenizer divides text based on the grammar of the language you specify.
- **pattern.** This tokenizer divides texts where it matches a regular expression that you specify.
- **whitespace.** This tokenizer divides text wherever there's white space.

> [!NOTE]
> For a full list of tokenizers, see **Add custom analyzers to string fields in an Azure AI Search index** in the **Learn more** section below.

### Token filters

Once the tokenizer has divided the incoming text into tokens, you might want to add some extra processing, such as removing stopwords or trimming punctuation marks. You can execute this processing by specifying a token filter. There are forty one different token filters available, including:

- Language-specific filters, such as **arabic_normalization**. These filters apply language-specific grammar rules to ensure that forms of words are removed and replaced with roots.
- **apostrophe**. This filter removes any apostrophe from a token and any characters after the apostrophe.
- **classic.** This filter removes English possessives and dots from acronyms.
- **keep.** This filter removes any token that doesn't include one or more words from a list you specify.
- **length.** This filter removes any token that is longer than your specified minimum or shorter than your specified maximum.
- **trim.** This filter removes any leading and trailing white space from tokens.

> [!NOTE]
> For a full list of token filters, see **Add custom analyzers to string fields in an Azure AI Search index** in the **Learn more** section below.

## Create a custom analyzer

You create a custom analyzer by specifying it when you define the index. You must do this with JSON code - there's no way to specify a custom index in the Azure portal. Use the `analyzers` section of the index at design time. You can include only one tokenizer but one or more character filters and one or more token filters. Use a unique name for your analyzer and set the `@odata.type` property to `Microsoft.Azure.Search.CustomAnalyzer`.

In this example, a character filter removes HTML formatting, a tokenizer splits the text according to the grammar of Icelandic, and a token filter removes apostrophes:

```json
"analyzers":(optional)[
   {
      "name":"ContosoAnalyzer",
      "@odata.type":"#Microsoft.Azure.Search.CustomAnalyzer",
      "charFilters":[
         "WebContentRemover"
      ],
      "tokenizer":"IcelandicTokenizer",
      "tokenFilters":[
         "ApostropheFilter"
      ]
   }
],
"charFilters":(optional)[
   {
      "name":"WebContentRemover",
      "@odata.type":"#html_strip"
   }
],
"tokenizers":(optional)[
   {
      "name":"IcelandicTokenizer",
      "@odata.type":"#microsoft_language_tokenizer",
      "language":"icelandic",
      "isSearchTokenizer":false,
   }
],
"tokenFilters":(optional)[
   {
      "name":"ApostropheFilter",
      "@odata.type":"#apostrophe"
   }
]
```

## Test a custom analyzer

Once you've defined your custom analyzer as part of your index, you can use the REST API's **Analyze Text** function to submit test text and ensure that the analyzer returns tokens correctly. Use any REST testing tool to formulate these requests, such as the popular **Postman** application.

Your test REST requests should look like this:

```http
POST https://<search service name>.search.windows.net/indexes/<index name>/analyze?api-version=<api-version>
   Content-Type: application/json
   api-key: <api key>
```

In this request:

- Replace `<search service name>` with the name of your AI Search resource.
- Replace `<index name>` with the name of the index that includes the custom analyzer.
- Replace `<api-version>` with the version number of the REST API.
- Replace `<api-key>` with the access key for your AI Search resource. You can obtain this key from the Azure portal.

Your request must also include a JSON body like this:

```json
{
  "text": "Test text to analyze.",
  "analyzer": "<analyzer name>"
}
```

Replace `<analyzer name>` with the name you specified when you defined the custom analyzer. Be sure to test with lots of different `text` values until you're sure that the custom analyzer behaves as you expect.

## Use a custom analyzer for a field

Once you've defined and tested a custom analyzer, you can configure your index to use it. You can specify an analyzer for each field in your index.

You can use the `analyzer` field when you want to use the same analyzer for both indexing and searching:

```json
"fields": [
 {
   "name": "IcelandicDescription",
   "type": "Edm.String",
   "retrievable": true,
   "searchable": true,
   "analyzer": "ContosoAnalyzer",
   "indexAnalyzer": null,
   "searchAnalyzer": null
 },
```

It's also possible to use a different analyzer when indexing the field and when searching the field. Use this configuration if you need a different set of processing steps when you index a field to when you analyze a query:

```json
"fields": [
 {
   "name": "IcelandicDescription",
   "type": "Edm.String",
   "retrievable": true,
   "searchable": true,
   "analyzer": null,
   "indexAnalyzer": "ContosoIndexAnalyzer",
   "searchAnalyzer": "ContosoSearchAnalyzer"
 },
```
