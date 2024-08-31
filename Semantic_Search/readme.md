# **semantic search**

Semantic search is a sophisticated data searching technique that leverages natural language processing (NLP) and machine learning (ML) to enhance the accuracy and relevance of search results. Unlike traditional keyword-based search methods, which focus solely on exact term matches, semantic search aims to understand the user's intent and the contextual meaning of their queries.

In short, semantic search works as follows:
- It uses a [text embedding](https://towardsdatascience.com/text-embeddings-comprehensive-guide-afd97fce8fb5) to turn words into vectors (lists of numbers).
- Uses [similarity](https://hyperskill.org/learn/step/22997) to find the vector among the responses which is the most similar to the vector corresponding to the query.
- Outputs the response corresponding to this most similar vector.

## **Text embeddings**

Text embeddings are a way to represent words and sentences as vectors in a high-dimensional space. the evolution of embeddings starts from bag-of-words which does't take to account semantic meanings, so  TF-IDF (Term Frequency — Inverse Document Frequency) come to existence, which try to give wights as a vector for words in order to calculate the relevance of words in a corpus, but this representation create a sparse vector where the length of the vector is equal to the corpus size, while not garbing that much of the semantic meaning.

For word embeddings, each word is converted into a vector that captures its meaning based on its meaning in a large corpus of text, This allows words with similar meanings or contexts to be placed closer together in the space. Sentence embeddings extend this concept to entire sentences, representing them as single vectors that encapsulate the overall meaning of the sentence. Methods like [Word2Vec](https://www.tensorflow.org/text/tutorials/word2vec) and [GloVe](https://nlp.stanford.edu/projects/glove/) are commonly used for word embeddings, while more advanced models like [Sentence-BERT](https://arxiv.org/pdf/1908.10084) are used for generating sentence embeddings. 

When using word embeddings in semantic search, the first step involves converting both the user's query and the documents in the search index into numerical vector representations. For the query, each word is transformed into a vector using a pre-trained word embedding model, resulting in a query vector that captures the semantic meaning of the entire query. Similarly, documents are also converted into vectors, either by averaging the word vectors within them or by using sentence embeddings that capture the meaning of the whole text. These embeddings allow the search system to understand the content's meaning, enabling more contextually relevant search results. the we will proceed into calculating similarity between the query and the data(responses) we have.

## **Calculating Similarity**






