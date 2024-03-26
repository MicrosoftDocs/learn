In this Learn Module, we've covered all basics of Natural Language Processing, from text representation to traditional recurrent network models. This serves as an introductory lesson to get you started on any natural language task, and we hope that you'll now be able to approach any NLP problem without fear.

You've learned the following key areas:
  - How to tokenize text into word tokens based on a vocabulary
  - The different ways of changing token indices to vector using Bag of Word or TF-IDF
  - How to use Embedding models to store words in vectors for vocabulary lookup while using padding or offsets
  - How to build a model using an RNN neural network for text classification

We focus mainly on text classification tasks.  To continue your learning of the NLP field, you should experiment with some of the other capabilities such as named entity recognition, machine translation or question answering. To implement the tasks, the same basic principles or recurrent networks are used, however top layer architectures of those networks are different. 

To extend your knowledge and get an in-depth learning on NLP, you can explore the following emerging topics:
* **Attention Mechanisms and Transformers**:  Instead of forwarding the context of each previous cell into the next evaluation step, transformer models use positional encodings and attention mechanism.  This technique ignores the input order to capture the context relationship between each word in the sequence. This is an emerging way to learn to understand the context of each word in the text sequence. It doesn't lose context in long sequences that we see in RNNs.  In addition, it can learn in parallel processing instead of sequential RNN models. 
* **BERT**:  [BERTology](https://arxiv.org/abs/2002.12327) provides a pretrained model from transformers. It's a powerful method trained to predict next sentence.  It converts text to numeric representation by learning the contextual embedding for words. 
* **GPT-3**: GPT-3 are the latest text generative models that are slightly different from BERT.  The model can be "programmed" to solving different tasks just by providing suitable "initial sequence" for text generation. This leads us to possible paradigm shift, where instead of doing transfer learning training we would be focusing on creating suitable questions for giant pre-trained networks. If you want to get serious about NLP, you probably need to explore some of the latest text generative models, such as [GPT-3](https://github.com/openai/gpt-3), or [Microsoft Turing NLG](https://www.microsoft.com/en-us/research/blog/turing-nlg-a-17-billion-parameter-language-model-by-microsoft/).

Training such large models involves numerous efforts, and needs to be done in a distributed manner. Distributed training is another area that you need to focus on if you're planning any serious NLP projects. It's definitely worth checking out [Azure Machine Learning](../../../paths/explore-azure-machine-learning-workspace/index.yml).

Now that you learned some of the basics of machine learning using neural networks concepts, we invite you to proceed with [PyTorch Fundamentals Learning Path](/training/paths/pytorch-fundamentals), and learn more:

[!include[](../../../includes/open-link-in-new-tab-note.md)]

* [Introduction to PyTorch](/training/modules/intro-machine-learning-pytorch)
* [Computer Vision with PyTorch](/training/modules/intro-computer-vision-pytorch)
* [Audio Classification with PyTorch](/training/modules/intro-audio-classification-pytorch)

Happy learning!
