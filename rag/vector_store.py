"""
Vector store module for RAG system
"""
import os
from typing import List
from langchain_community.vectorstores import Chroma
from langchain_core.documents import Document
from .embeddings import get_embeddings_model

def get_vector_store(persist_directory: str):
    """
    Get the vector store
    
    Args:
        persist_directory: Directory to persist the vector store
        
    Returns:
        Chroma vector store
    """
    # Create directory if it doesn't exist
    os.makedirs(persist_directory, exist_ok=True)
    
    # Get embeddings model
    embeddings = get_embeddings_model()
    
    # Return vector store
    return Chroma(persist_directory=persist_directory, embedding_function=embeddings)

def add_documents(vector_store, documents: List[Document]):
    """
    Add documents to the vector store
    
    Args:
        vector_store: Vector store to add documents to
        documents: List of documents to add
        
    Returns:
        None
    """
    vector_store.add_documents(documents)
    
def similarity_search(vector_store, query: str, k: int = 4):
    """
    Search for similar documents in the vector store
    
    Args:
        vector_store: Vector store to search
        query: Query to search for
        k: Number of results to return
        
    Returns:
        List of documents
    """
    return vector_store.similarity_search(query, k=k)
