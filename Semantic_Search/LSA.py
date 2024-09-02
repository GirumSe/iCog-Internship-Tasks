import numpy as np
from sklearn.feature_extraction.text import CountVectorizer, TfidfTransformer
from sklearn.decomposition import TruncatedSVD
from sklearn.metrics.pairwise import cosine_similarity

# Sample documents and their corresponding answers
documents = [
    "The sky is blue.",
    "The sun is bright.",
    "The sun in the sky is bright.",
    "We can see the shining sun, the bright sun."
]
answers = [
    "The sky appears blue due to scattering.",
    "The sun emits bright light.",
    "The sun is bright and located in the sky.",
    "We can see the sun because it shines brightly."
]

# Step 1: Convert the documents to a term-document matrix
vectorizer = CountVectorizer()
X = vectorizer.fit_transform(documents)
print("Term-Document Matrix (Raw):")
print(X.toarray())

# Step 2: Apply TF-IDF to the term-document matrix
tfidf_transformer = TfidfTransformer()
X_tfidf = tfidf_transformer.fit_transform(X)
print("\nTerm-Document Matrix (TF-IDF Weighted):")
print(X_tfidf.toarray())

# Step 3: Perform SVD (TruncatedSVD) to reduce dimensionality
n_components = 4
svd = TruncatedSVD(n_components=n_components)
X_svd = svd.fit_transform(X_tfidf)
print("\nTerm-Document Matrix (SVD Reduced):")
print(X_svd)

# Function to answer a question
def answer_question(question):
    # Convert the question to the same format as the documents
    question_vector = vectorizer.transform([question])
    question_tfidf = tfidf_transformer.transform(question_vector)
    question_svd = svd.transform(question_tfidf)
    
    print("\nQuestion Vector (TF-IDF):")
    print(question_tfidf.toarray())
    print("\nQuestion Vector (SVD Reduced):")
    print(question_svd)
    
    # Compute similarity between the question and all documents
    similarities = cosine_similarity(question_svd, X_svd)
    print("\nSimilarity Scores:")
    print(similarities)
    
    # Find the index of the most similar document
    most_similar_idx = np.argmax(similarities)
    
    return answers[most_similar_idx]

# Example question
question = "What can we see in the sky?"
print("\nQuestion:", question)
print("Answer:", answer_question(question))
