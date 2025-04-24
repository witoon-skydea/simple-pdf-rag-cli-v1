"""
Embeddings module for RAG system
"""
from langchain_community.embeddings import OllamaEmbeddings

def get_embeddings_model():
    """
    Get the embeddings model (mxbai-embed-large from Ollama)
    
    Returns:
        OllamaEmbeddings model
    """
    return OllamaEmbeddings(model="mxbai-embed-large:latest")
