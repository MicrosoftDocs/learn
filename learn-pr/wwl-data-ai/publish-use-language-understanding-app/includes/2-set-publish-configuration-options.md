When you publish a Language Understanding app, you can select various publishing options.

## Publishing slot

Every Language Understanding app has two publishing slots:

- **Staging**. Use this slot to publish and test new versions of your language model without disrupting production applications.
- **Production**. Use this slot for "live" models that are used by production applications.

## Publish settings

Regardless of which slot you publish your Language Understanding app to, you can configure the following publish settings to enable specific behavior:

- **Sentiment analysis**. Enable this to include a sentiment score from 0 (negative) to 1 (positive) in predictions. This score reflects the sentiment of the input utterance.
- **Spelling correction**. Enable this to use the Bing Spell Check service to correct the spelling on input utterances before intent prediction.
- **Speech priming**. Enable this if you plan to use the language model with the Speech service. This option sends the model to the Speech service ahead of prediction to improve intent recognition from spoken input.
