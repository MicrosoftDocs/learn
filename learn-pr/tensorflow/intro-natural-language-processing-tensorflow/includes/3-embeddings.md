In our previous example, we operated on high-dimensional bag-of-words vectors with length `vocab_size`, and we explicitly converted low-dimensional positional representation vectors into sparse one-hot representation. This one-hot representation isn't memory-efficient. In addition, each word is treated independently from each other, so one-hot encoded vectors don't express semantic similarities between words.

In this unit, we continue exploring the **AG News** dataset. To begin, let's load the data and get some definitions from the previous unit.

```python
import tensorflow as tf
import keras
import tensorflow_datasets as tfds
import numpy as np

# In this tutorial, we will be training a lot of models. In order to use GPU memory cautiously,
# we will set tensorflow option to grow GPU memory allocation when required.
physical_devices = tf.config.list_physical_devices('GPU') 
if len(physical_devices)>0:
    tf.config.set_memory_growth(physical_devices[0], True)

dataset = tfds.load('ag_news_subset')
ds_train = dataset['train']
ds_test = dataset['test']
```

### What's an embedding?

The idea of **embedding** is to represent words using lower-dimensional dense vectors that reflect the semantic meaning of the word. We'll later discuss how to build meaningful word embeddings, but for now let's just think of embeddings as a way to reduce the dimensionality of a word vector.

So, an embedding layer takes a word as input, and produces an output vector of specified `embedding_size`. In a sense, it's similar to a `Dense` layer, but instead of taking a one-hot encoded vector as input, it's able to take a word number.

By using an embedding layer as the first layer in our network, we can switch from bag-or-words to an **embedding bag** model, where we first convert each word in our text into the corresponding embedding, and then compute some aggregate function over all those embeddings, such as `sum`, `average` or `max`.  

![Image showing an embedding classifier for five sequence words.](../media/embedding-classifier-example.svg)

Our classifier neural network consists of the following layers:

- TextVectorization layer, which takes a string as input, and produces a tensor of token numbers. We'll specify some reasonable vocabulary size `vocab_size`, and ignore less-frequently used words. The input shape is 1, and the output shape will be $n$, since we get $n$ tokens as a result, each of them containing numbers from 0 to `vocab_size`.
- Embedding layer, which takes $n$ numbers, and reduces each number to a dense vector of a given length (100 in our example). Thus, the input tensor of shape $n$ will be transformed into an $n\times 100$ tensor. 
- Aggregation layer, which takes the average of this tensor along the first axis, that is, it computes the average of all $n$ input tensors corresponding to different words. To implement this layer, we'll use a `Lambda` layer, and pass into it the function to compute the average. The output will have shape of 100, and it is the numeric representation of the whole input sequence.
- Final Dense linear classifier.

We can implement these layers with the following code:

```python
vocab_size = 30000
batch_size = 128

vectorizer = keras.layers.TextVectorization(max_tokens=vocab_size)

model = keras.Sequential([
    keras.Input(shape=(1,), dtype=tf.string),
    vectorizer,    
    keras.layers.Embedding(vocab_size,100),
    keras.layers.Lambda(lambda x: tf.reduce_mean(x,axis=1)),
    keras.layers.Dense(4, activation='softmax')
])
model.summary()
```

Running this code produces the following output:

```
Model: "sequential"
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┓
┃ Layer (type)                 ┃ Output Shape              ┃       Param # ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━┩
│ text_vectorization            │ (None, None)              │             0 │
│ (TextVectorization)          │                           │               │
├──────────────────────────────┼───────────────────────────┼───────────────┤
│ embedding (Embedding)        │ (None, None, 100)         │     3,000,000 │
├──────────────────────────────┼───────────────────────────┼───────────────┤
│ lambda (Lambda)              │ (None, 100)               │             0 │
├──────────────────────────────┼───────────────────────────┼───────────────┤
│ dense (Dense)                │ (None, 4)                 │           404 │
└──────────────────────────────┴───────────────────────────┴───────────────┘
 Total params: 3,000,404 (11.45 MB)
 Trainable params: 3,000,404 (11.45 MB)
 Non-trainable params: 0 (0.00 B)
```

In the `summary` printout, in the **output shape** column, the first tensor dimension `None` corresponds to the minibatch size, and the second corresponds to the length of the token sequence. All token sequences in the minibatch have different lengths. We'll discuss how to deal with it in the next section.

We can train the network with the following code:

```python
def extract_text(x):
    return x['title']+' '+x['description']

def tupelize(x):
    return (extract_text(x),x['label'])

print("Training vectorizer")
vectorizer.adapt(ds_train.take(500).map(extract_text))

model.compile(loss='sparse_categorical_crossentropy',optimizer='adam',metrics=['acc'])
model.fit(ds_train.map(tupelize).batch(batch_size),validation_data=ds_test.map(tupelize).batch(batch_size))
```

> [!NOTE]
> We're building vectorizer based on a subset of the data. This is done in order to speed up the process, and it might result in a situation when not all tokens from our text are present in the vocabulary. In this case, those tokens would be ignored, which may result in slightly lower accuracy. However, in real life, a subset of text often gives a good vocabulary estimation.

### Dealing with variable sequence sizes

Let's understand how training happens in minibatches. In the example above, the input tensor has dimension 1, and we use 128-long minibatches, so that actual size of the tensor is $128 \times 1$. However, the number of tokens in each sentence is different. If we apply the `TextVectorization` layer to a single input, the number of tokens returned is different, depending on how the text is tokenized:

```python
print(vectorizer('Hello, world!'))
print(vectorizer('I am glad to meet you!'))
```

Running this code produces the following output:

```
tf.Tensor([ 1 45], shape=(2,), dtype=int64)
tf.Tensor([ 112 1271    1    3 1747  158], shape=(6,), dtype=int64)
```

However, when we apply the vectorizer to several sequences, it has to produce a tensor of rectangular shape, so it fills unused elements with the PAD token (which in our case is zero):

```python
vectorizer(['Hello, world!','I am glad to meet you!'])
```

Running this code produces the following output:

```
<tf.Tensor: shape=(2, 6), dtype=int64, numpy=
array([[   1,   45,    0,    0,    0,    0],
       [ 112, 1271,    1,    3, 1747,  158]])>
```

Here we can see the embeddings:

```python
model.layers[1](vectorizer(['Hello, world!','I am glad to meet you!'])).numpy()
```

Running this code produces the following output:

```
array([[[-0.02485236, -0.00416857, -0.06599288, ..., -0.02404598,
          0.03529833, -0.02100844],
        [ 0.22493948,  0.01383338,  0.12420551, ...,  0.19531338,
          0.13524376,  0.04216914],
        [ 0.04510409,  0.00708018, -0.0310419 , ..., -0.0188726 ,
         -0.0179676 , -0.04813331],
        [ 0.04510409,  0.00708018, -0.0310419 , ..., -0.0188726 ,
         -0.0179676 , -0.04813331],
        [ 0.04510409,  0.00708018, -0.0310419 , ..., -0.0188726 ,
         -0.0179676 , -0.04813331],
        [ 0.04510409,  0.00708018, -0.0310419 , ..., -0.0188726 ,
         -0.0179676 , -0.04813331]],

       [[-0.00226152, -0.0972852 , -0.00063103, ...,  0.00504377,
          0.22460397,  0.1497297 ],
        [-0.15621698, -0.13758421, -0.02889572, ..., -0.02577994,
          0.03472563,  0.08767739],
        [-0.02485236, -0.00416857, -0.06599288, ..., -0.02404598,
          0.03529833, -0.02100844],
        [-0.06490357, -0.08200071, -0.06175491, ..., -0.02477042,
         -0.06802022, -0.01040947],
        [ 0.03279151,  0.12563369,  0.06062867, ..., -0.04349922,
         -0.12154414, -0.12533969],
        [-0.14435016, -0.304014  , -0.00378676, ...,  0.05609043,
          0.20370889,  0.28518862]]], dtype=float32)
```

> [!NOTE]
> To minimize the amount of padding, in some cases it makes sense to sort all sequences in the dataset in the order of increasing length (or, more precisely, number of tokens). This ensures that each minibatch contains sequences of similar length.

## Semantic embeddings: Word2Vec

In our previous example, the embedding layer learned to map words to vector representations, however, these representations didn't have semantic meaning. It would be nice to learn a vector representation such that similar words or synonyms correspond to vectors that are close to each other in terms of some vector distance (for example euclidian distance).

To do that, we need to pretrain our embedding model on a large collection of text using a technique such as [Word2Vec](https://en.wikipedia.org/wiki/Word2vec). It's based on two main architectures that are used to produce a distributed representation of words:

- **Continuous bag-of-words** (CBoW), where we train the model to predict a word from the surrounding context. Given the ngram $(W_{-2},W_{-1},W_0,W_1,W_2)$, the goal of the model is to predict $W_0$ from $(W_{-2},W_{-1},W_1,W_2)$.
- **Continuous skip-gram** is the opposite of CBoW. The model uses the input word ($W_0$) to predict the surrounding window of context words.

CBoW is faster, and while skip-gram is slower, it does a better job of representing infrequent words.

![Diagram showing both CBoW and Skip-Gram algorithms to convert words to vectors.](../media/example-algorithms-converting-words-vectors.png)

To experiment with the Word2Vec embedding pretrained on Google News dataset, we can use the **gensim** library. Below we find the words most similar to 'neural'.

> [!NOTE]
> When you first create word vectors, downloading them can take some time!

```python
import gensim.downloader as api
w2v = api.load('word2vec-google-news-300')
for w,p in w2v.most_similar('neural'):
    print(f"{w} -> {p}")
```

Running this code produces the following output:

```
neuronal -> 0.7804799675941467
neurons -> 0.7326500415802002
neural_circuits -> 0.7252851724624634
neuron -> 0.7174385190010071
cortical -> 0.6941086649894714
brain_circuitry -> 0.6923246383666992
synaptic -> 0.6699118614196777
neural_circuitry -> 0.6638563275337219
neurochemical -> 0.6555314064025879
neuronal_activity -> 0.6531826257705688
```

We can also extract the vector embedding from the word, to be used in training the classification model. The embedding has 300 components, but here we only show the first 20 components of the vector for clarity:

```python
w2v['play'][:20]
```

Running this code produces the following output:

```
array([ 0.01226807,  0.06225586,  0.10693359,  0.05810547,  0.23828125,
        0.03686523,  0.05151367, -0.20703125,  0.01989746,  0.10058594,
       -0.03759766, -0.1015625 , -0.15820312, -0.08105469, -0.0390625 ,
       -0.05053711,  0.16015625,  0.2578125 ,  0.10058594, -0.25976562],
      dtype=float32)
```

The great thing about semantic embeddings is that you can manipulate the vector encoding based on semantics. For example, we can ask to find a word whose vector representation is as close as possible to the words *king* and *woman*, and as far as possible from the word *man*:

```python
w2v.most_similar(positive=['king','woman'],negative=['man'])[0]
```

Running this code produces the following output:

```
('queen', 0.7118192911148071)
```

The example above uses some internal Gensim magic, but the underlying logic is simple. An interesting thing about embeddings is that you can perform normal vector operations on embedding vectors, and that would reflect operations on word **meanings**. The example above can be expressed in terms of vector operations: we calculate the vector corresponding to **KING-MAN+WOMAN** (operations `+` and `-` are performed on vector representations of corresponding words), and then find the closest word in the dictionary to that vector:

```python
# get the vector corresponding to king-man+woman
qvec = w2v['king'] - w2v['man'] + w2v['woman']
# find the index of the closest embedding vector, excluding input words
d = np.sum((w2v.vectors-qvec)**2,axis=1)
exclude = {w2v.key_to_index[w] for w in ['king', 'man', 'woman']}
d[list(exclude)] = np.inf
min_idx = np.argmin(d)
# find the corresponding word
w2v.index_to_key[min_idx]
```

Running this code produces the following output:

```
'queen'
```

To find the closest vector, we use NumPy to compute a vector of distances between our vector and all vectors in the vocabulary, and then find the index of the closest word using `argmin`. We exclude the input words (`king`, `man`, `woman`) from the search, since the `most_similar` method does this automatically.

While Word2Vec seems like a great way to express word semantics, it has many disadvantages, including the following:

- Both CBoW and skip-gram models are **predictive embeddings**, and they only take local context into account. Word2Vec doesn't take advantage of global context.
- Word2Vec doesn't take into account word **morphology**, that is, the fact that the meaning of the word can depend on different parts of the word, such as the root.  

**FastText** tries to overcome the second limitation, and builds on Word2Vec by learning vector representations for each word and the character n-grams found within each word. The values of the representations are then averaged into one vector at each training step. While this adds numerous additional computations to pretraining, it enables word embeddings to encode subword information.

Another method, **GloVe**, uses a different approach to word embeddings, based on the factorization of the word-context matrix. First, it builds a large matrix that counts the number of word occurrences in different contexts, and then it tries to represent this matrix in lower dimensions in a way that minimizes reconstruction loss.

The gensim library supports those word embeddings, and you can experiment with them by changing the model loading code above.

## Using pretrained embeddings in Keras

We can modify the example above to prepopulate the matrix in our embedding layer with semantic embeddings, such as Word2Vec. The vocabularies of the pretrained embedding and the text corpus will likely not match, so we need to choose one. Here we explore the two possible options: using the tokenizer vocabulary, and using the vocabulary from Word2Vec embeddings.

### Using tokenizer vocabulary

When using the tokenizer vocabulary, some of the words from the vocabulary have corresponding Word2Vec embeddings, and some will be missing. Given that our vocabulary size is `vocab_size`, and the Word2Vec embedding vector length is `embed_size`, the embedding layer will be represented by a weight matrix of shape `vocab_size`$\times$`embed_size`. We'll populate this matrix by going through the vocabulary:

```python
embed_size = len(w2v.get_vector('hello'))
print(f'Embedding size: {embed_size}')

vocab = vectorizer.get_vocabulary()
W = np.zeros((vocab_size,embed_size))
print('Populating matrix, this will take some time...',end='')
found, not_found = 0,0
for i,w in enumerate(vocab):
    try:
        W[i] = w2v.get_vector(w)
        found+=1
    except KeyError:
        # W[i] = np.random.normal(0.0,0.3,size=(embed_size,))
        not_found+=1

print(f"Done, found {found} words, {not_found} words missing")
```

For words that are not present in the Word2Vec vocabulary, we can either leave them as zeroes, or generate a random vector.

To define an embedding layer with pretrained weights, we run the following code:

```python
emb = keras.layers.Embedding(vocab_size,embed_size,weights=[W],trainable=False)
model = keras.Sequential([
    keras.Input(shape=(1,), dtype=tf.string),
    vectorizer, emb,
    keras.layers.Lambda(lambda x: tf.reduce_mean(x,axis=1)),
    keras.layers.Dense(4, activation='softmax')
])
```

Once this is done, we can train our model.

```python
model.compile(loss='sparse_categorical_crossentropy',optimizer='adam',metrics=['acc'])
model.fit(ds_train.map(tupelize).batch(batch_size),
          validation_data=ds_test.map(tupelize).batch(batch_size))
```

> [!NOTE]
> Notice that we set `trainable=False` when creating the `Embedding`, which means that we're not retraining the Embedding layer. This may cause accuracy to be slightly lower, but it speeds up the training.

### Using embedding vocabulary

One issue with the previous approach is that the vocabularies used in the TextVectorization and Embedding are different. To overcome this problem, we can use one of the following solutions:

- Retrain the Word2Vec model on our vocabulary.
- Load our dataset with the vocabulary from the pretrained Word2Vec model. Vocabularies used to load the dataset can be specified during loading.

The latter approach seems easier, so let's implement it. First of all, we create a `TextVectorization` layer with the specified vocabulary, taken from the Word2Vec embeddings:

```python
vocab = list(w2v.key_to_index.keys())
vectorizer = keras.layers.TextVectorization()
vectorizer.set_vocabulary(vocab)
```

Now we need to build the embedding weight matrix from the Word2Vec vectors. We create a matrix where each row corresponds to a word in the vocabulary, and manually construct the Keras embedding layer:

```python
embed_size = w2v.vector_size
vocab_size_w2v = len(vocab) + 2  # +2 for padding and unknown tokens
W = np.zeros((vocab_size_w2v, embed_size))
for i, word in enumerate(vocab):
    W[i + 2] = w2v[word]  # offset by 2 for padding (0) and unknown (1) tokens

emb_w2v = keras.layers.Embedding(vocab_size_w2v, embed_size, weights=[W], trainable=False)

model = keras.Sequential([
    keras.Input(shape=(1,), dtype=tf.string),
    vectorizer,
    emb_w2v,
    keras.layers.Lambda(lambda x: tf.reduce_mean(x,axis=1)),
    keras.layers.Dense(4, activation='softmax')
])
model.compile(loss='sparse_categorical_crossentropy',optimizer='adam',metrics=['acc'])
model.fit(ds_train.map(tupelize).batch(128),validation_data=ds_test.map(tupelize).batch(128),epochs=5)
```

Running this code produces the following output:

```
Epoch 1/5
938/938 ━━━━━━━━━━━━━━━━━━━━ 7s 7ms/step - loss: 1.3381 - acc: 0.4961 - val_loss: 1.2996 - val_acc: 0.5682
Epoch 2/5
938/938 ━━━━━━━━━━━━━━━━━━━━ 7s 7ms/step - loss: 1.2591 - acc: 0.5714 - val_loss: 1.2340 - val_acc: 0.5839
Epoch 3/5
938/938 ━━━━━━━━━━━━━━━━━━━━ 7s 7ms/step - loss: 1.1983 - acc: 0.5883 - val_loss: 1.1827 - val_acc: 0.5951
Epoch 4/5
938/938 ━━━━━━━━━━━━━━━━━━━━ 7s 7ms/step - loss: 1.1505 - acc: 0.6001 - val_loss: 1.1417 - val_acc: 0.6021
Epoch 5/5
938/938 ━━━━━━━━━━━━━━━━━━━━ 7s 7ms/step - loss: 1.1122 - acc: 0.6093 - val_loss: 1.1084 - val_acc: 0.6103
```

One of the reasons we don't see higher accuracy is because some words from our dataset are missing in the pretrained Word2Vec vocabulary, and thus they're ignored. The pretrained Word2Vec model was trained on the Google News corpus, which has a different domain and vocabulary distribution than the AG News classification dataset. Words present in our training data but absent from the Word2Vec vocabulary is mapped to zero vectors, reducing the effective signal available to the classifier. Additionally, using `trainable=False` on the embedding layer means the model can't adapt the word vectors to our specific classification task, which limits its ability to learn task-specific features. To overcome this, we can train our own embeddings based on our dataset.

> [!NOTE]
> The lower accuracy seen here compared to training embeddings from scratch is expected. The pretrained Word2Vec model was trained on the Google News corpus, which has a different vocabulary and domain than the AG News classification dataset. Words present in the module's training data but absent from the Word2Vec vocabulary are silently ignored (mapped to zero vectors), reducing the effective signal available to the classifier. For best results on domain-specific tasks, consider fine-tuning embeddings on in-domain data.

## Training your own embeddings

In our examples, we have been using pretrained semantic embeddings, but it's interesting to see how those embeddings can be trained using either CBoW, or skip-gram architectures. This exercise goes beyond this module, but those interested might want to check out this [official TensorFlow tutorial on training Word2Vec model](https://www.tensorflow.org/tutorials/text/word2vec). Also, the **gensim** framework can be used to train the most commonly used embeddings in a few lines of code, as described [in the official documentation](https://radimrehurek.com/gensim/auto_examples/tutorials/run_word2vec.html#training-your-own-model).

## Contextual embeddings

One key limitation of traditional pretrained embedding representations such as Word2Vec is the fact that, even though they can capture some meaning of a word, they can't differentiate between different meanings. This can cause problems in downstream models.

For example the word 'play' has different meaning in these two different sentences:

- I went to a **play** at the theater.
- John wants to **play** with his friends.

The pretrained embeddings we talked about represent both meanings of the word 'play' in the same embedding. To overcome this limitation, we need to build embeddings based on the **language model**, which is trained on a large corpus of text, and *knows* how words can be put together in different contexts. Discussing contextual embeddings is out of scope for this module, but we'll come back to them when talking about language models in the next unit.
