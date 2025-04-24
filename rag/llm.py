"""
LLM module for RAG system
"""
from typing import List
from langchain_community.llms import Ollama
from langchain.prompts import PromptTemplate
from langchain_core.documents import Document
from langchain.chains import LLMChain

# Define a prompt template that includes context
PROMPT_TEMPLATE = """
You are a helpful assistant. Use the following pieces of context to answer the user's question.
If you don't know the answer, just say that you don't know, don't try to make up an answer.

Context:
{context}

User Question: {question}

Your Answer:
"""

def get_llm_model():
    """
    Get the LLM model (llama3:8b from Ollama)
    
    Returns:
        Ollama LLM model
    """
    return Ollama(model="llama3:8b")

def format_context(documents: List[Document]) -> str:
    """
    Format a list of documents into a context string
    
    Args:
        documents: List of documents
        
    Returns:
        Formatted context string
    """
    return "\n\n".join([doc.page_content for doc in documents])

def generate_response(llm, documents: List[Document], question: str) -> str:
    """
    Generate a response using the LLM and context documents
    
    Args:
        llm: LLM model
        documents: List of context documents
        question: User question
        
    Returns:
        Generated response
    """
    # Format documents into context string
    context = format_context(documents)
    
    # Create prompt from template
    prompt = PromptTemplate(
        template=PROMPT_TEMPLATE,
        input_variables=["context", "question"]
    )
    
    # Create chain
    chain = LLMChain(llm=llm, prompt=prompt)
    
    # Run chain
    response = chain.invoke({"context": context, "question": question})
    
    return response["text"]
