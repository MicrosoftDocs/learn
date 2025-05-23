Some of the earliest techniques used to analyze text with computers involve statistical analysis of a body of text (a *corpus*) to infer some kind of semantic meaning. Put simply, if you can determine the most commonly used words in a given document, you can often get a good idea of what the document is about.

## Tokenization

The first step in analyzing a corpus is to break it down into *tokens*. For the sake of simplicity, you can think of each distinct word in the training text as a token, though in reality, tokens can be generated for partial words, or combinations of words and punctuation.

For example, consider this phrase from a famous US presidential speech: `"we choose to go to the moon"`. The phrase can be broken down into the following tokens, with numeric identifiers:

```
1. we 
2. choose
3. to
4. go
5. the
6. moon
```

Notice that `"to"` (token number 3) is used twice in the corpus. The phrase `"we choose to go to the moon"` can be represented by the tokens :::no-loc text="{1,2,3,4,3,5,6}":::.

We've used a simple example in which tokens are identified for each distinct word in the text. However, consider the following concepts that may apply to tokenization depending on the specific kind of NLP problem you're trying to solve:

|**Concept**|**Description**|
|-|-|
|**Text normalization**| Before generating tokens, you may choose to *normalize* the text by removing punctuation and changing all words to lower case. For analysis that relies purely on word frequency, this approach improves overall performance. However, some semantic meaning may be lost - for example, consider the sentence `"Mr Banks has worked in many banks."`. You may want your analysis to differentiate between the person `"Mr Banks"` and the `"banks"` in which he has worked. You may also want to consider `"banks."` as a separate token to `"banks"` because the inclusion of a period provides the information that the word comes at the end of a sentence|
|**Stop word removal**| Stop words are words that should be excluded from the analysis. For example, `"the"`, `"a"`, or `"it"` make text easier for people to read but add little semantic meaning. By excluding these words, a text analysis solution may be better able to identify the important words.|
|**n-grams**| Multi-term phrases such as `"I have"` or `"he walked"`. A single word phrase is a `unigram`, a two-word phrase is a `bi-gram`, a three-word phrase is a `tri-gram`, and so on. By considering words as groups, a machine learning model can make better sense of the text.|
| **Stemming**| A technique in which algorithms are applied to consolidate words before counting them, so that words with the same root, like `"power"`, `"powered"`, and `"powerful"`, are interpreted as being the same token.|

Next, let's see how statistical techniques enable us to model language.

