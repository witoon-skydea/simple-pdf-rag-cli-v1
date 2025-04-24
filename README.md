# Simple PDF RAG CLI

A command-line tool for PDF and document Q&A with OCR capabilities. This project combines PDF OCR capabilities with RAG (Retrieval Augmented Generation) to enable question answering on documents, including PDFs with images.

## Features

- **Document Ingestion**: Import TXT, PDF, DOCX, CSV, and MD files into a vector database
- **OCR for PDFs**: Process PDFs containing images or scanned content using OCR
- **Multiple OCR Engines**: Support for Tesseract OCR and EasyOCR
- **Multilingual OCR**: Support for multiple languages including Thai, English, and others
- **Question Answering**: Query the ingested documents using natural language
- **Raw Chunks View**: View the raw document chunks used for answering without LLM processing

## Requirements

- Python 3.8+
- [Ollama](https://ollama.com/) for LLM and embeddings
- [Tesseract OCR](https://github.com/tesseract-ocr/tesseract) (Optional, for OCR functionality)

## Installation

1. Clone the repository:
   ```
   git clone <repository-url>
   cd simple-pdf-rag-cli
   ```

2. Run the setup script:
   ```
   ./setup.sh
   ```

   This will:
   - Create a virtual environment
   - Install required dependencies
   - Check for Ollama and Tesseract OCR installations
   - Provide usage instructions

## Usage

### Using the Run Script

The `run.sh` script provides a convenient way to use the tool:

```bash
# Ingest a document
./run.sh ingest path/to/document.pdf

# Ingest a document with OCR
./run.sh ingest path/to/document.pdf --ocr

# Ingest a document with OCR and specify language
./run.sh ingest path/to/document.pdf --ocr --ocr-lang "tha+eng"

# Query the documents
./run.sh query "Your question here"

# Query and see raw chunks
./run.sh query "Your question here" --raw-chunks
```

### Direct Usage

You can also use the python script directly:

```bash
# Activate the virtual environment
source venv/bin/activate

# Ingest a document
python main.py ingest path/to/document.pdf

# Ingest with OCR
python main.py ingest path/to/document.pdf --ocr

# Query the documents
python main.py query "Your question here"

# Deactivate the virtual environment when done
deactivate
```

## OCR Options

### Tesseract OCR (Default)

```bash
python main.py ingest path/to/document.pdf --ocr --ocr-engine tesseract --ocr-lang "eng"
```

Additional options:
- `--tesseract-cmd`: Path to Tesseract executable (if not in PATH)
- `--tessdata-dir`: Path to directory containing Tesseract language data files
- `--ocr-dpi`: DPI for image processing (default: 300)

### EasyOCR

```bash
python main.py ingest path/to/document.pdf --ocr --ocr-engine easyocr --ocr-lang "eng"
```

Additional options:
- `--gpu/--no-gpu`: Whether to use GPU for OCR (default: --gpu)
- `--ocr-dpi`: DPI for image processing (default: 300)

## Language Support

### Tesseract OCR Language Codes

Common language codes for Tesseract:
- `eng`: English
- `tha`: Thai
- `deu`: German
- `fra`: French
- `jpn`: Japanese
- `kor`: Korean
- `chi_sim`: Chinese (Simplified)
- `chi_tra`: Chinese (Traditional)

Multiple languages can be specified with a plus sign, e.g., `tha+eng` for Thai and English.

### EasyOCR Language Codes

EasyOCR uses different language codes:
- `en`: English
- `th`: Thai
- `de`: German
- `fr`: French
- `ja`: Japanese
- `ko`: Korean
- `zh`: Chinese

When using EasyOCR, the tool will automatically convert Tesseract language codes to EasyOCR format.

## Project Structure

```
simple-pdf-rag-cli/
├── data/                  # Sample data directory
├── db/                    # Vector database storage
├── rag/
│   ├── __init__.py
│   ├── document_loader.py  # Enhanced with OCR capabilities
│   ├── vector_store.py     # Vector store operations
│   ├── llm.py              # LLM interface
│   ├── embeddings.py       # Embeddings model
│   └── ocr.py              # OCR functionality
├── main.py                 # Main CLI entry point
├── requirements.txt        # Dependencies
├── setup.sh                # Setup script
└── run.sh                  # Run script
```

## License

[MIT License](LICENSE)

## Acknowledgements

This project combines functionality from:
- [simple-rag-cli](https://github.com/username/simple-rag-cli) - RAG functionality
- [pdf-ocr-cli](https://github.com/username/pdf-ocr-cli) - PDF OCR functionality
