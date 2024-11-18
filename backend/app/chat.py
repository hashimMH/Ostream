from openai import OpenAI
from fastapi import FastAPI, UploadFile, Form, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import logging
from io import BytesIO
from dotenv import load_dotenv
from PyPDF2 import PdfReader


# Load environment variables
load_dotenv()

app = FastAPI(redirect_slashes=False)

# Add CORS middleware configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],  # Your frontend URL
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE"],
    allow_headers=["*"],
)

# Initialize OpenAI client
key = os.getenv("api_key")
client = OpenAI(api_key=key)  # Replace with your API key

# Set up logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

def extract_pdf_text(pdf_file: UploadFile) -> str:
    """Extract text from an uploaded PDF file."""
    try:
        # Log file details
        logger.debug(f"Attempting to read PDF file: {pdf_file.filename}")
        
        # Read the file content
        file_content = pdf_file.file.read()
        logger.debug(f"File content length: {len(file_content)} bytes")
        
        # Create PDF reader
        pdf_reader = PdfReader(BytesIO(file_content))
        logger.debug(f"PDF has {len(pdf_reader.pages)} pages")
        
        text = ""
        for i, page in enumerate(pdf_reader.pages):
            try:
                page_text = page.extract_text()
                text += page_text
                logger.debug(f"Successfully extracted text from page {i+1}")
            except Exception as e:
                logger.error(f"Error extracting text from page {i+1}: {str(e)}")
                raise HTTPException(
                    status_code=500,
                    detail=f"Error extracting text from page {i+1}: {str(e)}"
                )
        
        return text.strip()
    except Exception as e:
        logger.error(f"PDF extraction error: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail=f"PDF extraction error: {str(e)}"
        )

@app.post("/chat_with_pdf")
async def chat_with_pdf(pdf_file: UploadFile = Form(...), question: str = Form(...)):
    try:
        # Log incoming request
        logger.debug(f"Received file: {pdf_file.filename}")
        logger.debug(f"Question: {question}")
        
        # Validate file type
        if not pdf_file.filename.endswith(".pdf"):
            logger.error("Invalid file type")
            raise HTTPException(
                status_code=400,
                detail="File must be a PDF."
            )
        
        # Extract text from PDF
        try:
            pdf_text = extract_pdf_text(pdf_file)
            if not pdf_text:
                logger.error("Empty PDF content")
                raise HTTPException(
                    status_code=400,
                    detail="PDF is empty or text cannot be extracted."
                )
            logger.debug(f"Extracted text length: {len(pdf_text)} characters")
        except HTTPException as he:
            raise he
        except Exception as e:
            logger.error(f"PDF processing error: {str(e)}")
            raise HTTPException(
                status_code=500,
                detail=f"Error processing PDF: {str(e)}"
            )
        
        # Updated OpenAI API call
        messages = [
            {"role": "system", "content": "You are an assistant who answers questions strictly based on the provided PDF content. Do not add any extra information."},
            {"role": "user", "content": f"PDF content: {pdf_text}"},
            {"role": "user", "content": f"Question: {question}"}
        ]

        try:
            logger.debug("Sending request to OpenAI")
            response = client.chat.completions.create(
                model="gpt-3.5-turbo",
                messages=messages,
                max_tokens=150,
                temperature=0
            )
            answer = response.choices[0].message.content.strip()
            logger.debug("Successfully received OpenAI response")
        except Exception as e:
            logger.error(f"OpenAI API error: {str(e)}")
            raise HTTPException(
                status_code=500,
                detail=f"OpenAI API error: {str(e)}"
            )
        
        return {
            "status": "success",
            "question": question,
            "answer": answer,
            "pdf_text_length": len(pdf_text)
        }
        
    except HTTPException as he:
        raise he
    except Exception as e:
        logger.error(f"Unexpected error: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail=f"Unexpected error: {str(e)}"
        )