::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=74a44e51-3a04-4a19-8b33-40ee0672c782]

> [!NOTE]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

The first step in analyzing a body of text (referred to as a *corpus*) is to break it down into *tokens*. For the sake of simplicity, you can think of each distinct word in the text as a token. In reality, tokens can be generated for partial words or combinations of words and punctuation.

For example, consider this phrase from a famous US presidential speech: `"We choose to go to the moon"`. The phrase can be broken down into the following tokens, with numeric identifiers:

1. `We` 
2. `choose`
3. `to`
4. `go`
3. `to`
5. `the`
6. `moon`

Notice that `"to"` (token number 3) is used twice in the corpus. The phrase `"We choose to go to the moon"` can be represented by the tokens.

With each token assigned a discrete value, we can easily count their frequency in the text and use that to determine the most commonly used terms; which might help identify the main subject of the text.

We've used a simple example in which tokens are identified for each distinct word in the text. However, consider the following pre-processing techniques that might apply to tokenization depending on the specific text analysis problem you're trying to solve:

|**Technique**|**Description**|
|-|-|
|**Text normalization**| Before generating tokens, you might choose to *normalize* the text by removing punctuation and changing all words to lower case. For analysis that relies purely on word frequency, this approach improves overall performance. However, some semantic meaning could be lost - for example, consider the sentence `"Mr Banks has worked in many banks."`. You may want your analysis to differentiate between the person `"Mr Banks"` and the `"banks"` in which he's worked. You might also want to consider `"banks."` as a separate token to `"banks"` because the inclusion of a period provides the information that the word comes at the end of a sentence|
|**Stop word removal**| Stop words are words that should be excluded from the analysis. For example, `"the"`, `"a"`, or `"it"` make text easier for people to read but add little semantic meaning. By excluding these words, a text analysis solution might be better able to identify the important words.|
|**N-gram extraction**| Finding multi-term phrases such as `"artificial intelligence"` or `"natural language processing"`. A single word phrase is a *unigram*, a two-word phrase is a *bigram*, a three-word phrase is a *trigram*, and so on. In many cases, by considering frequently appearing sequences of words as groups, a text analysis algorithm can make better sense of the text.|
| **Stemming**| A technique used to consolidate words by stripping endings like "s", "ing", "ed", and so on, before counting them; so that words with the same etymological root, like `"powering"`, `"powered"`, and `"powerful"`, are interpreted as being the same token (`"power"`).|
| **Lemmatization** | Another approach to reducing words to their base or dictionary form (called a *lemma*). Unlike stemming, which simply chops off word endings, lemmatization uses linguistic rules and vocabulary to ensure the resulting form is a valid word (for example, `"running"`: → `"run"`, `"global"` → `"globe"`).|
| **Parts of speech (POS) tagging** | Labeling each token with its grammatical category, such as noun, verb, adjective, or adverb. This technique uses linguistic rules and often statistical models to determine the correct tag based on both the token itself and its context within the sentence. |

::: zone-end