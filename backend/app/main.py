from fastapi import FastAPI, UploadFile, File, HTTPException
from typing import Dict, List, Union, Any, Optional
from pydantic import BaseModel
import fitz  # PyMuPDF
import logging
from io import BytesIO
from openai import OpenAI
import json
from fastapi.middleware.cors import CORSMiddleware
import uuid
import os
from dotenv import load_dotenv
from openai import AsyncOpenAI  # Update this import
from datetime import datetime, timedelta
import base64

# Load environment variables
load_dotenv()

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# OpenAI API key
OpenAI.api_key = os.getenv("OPENAI_API_KEY")
print(OpenAI.api_key)

app = FastAPI(title="Document Analysis API")

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define all models first
class RiskFactor(BaseModel):
    factor: str
    probability: int
    impact: int
    mitigationStatus: int

class KeyMetrics(BaseModel):
    costPerUnit: float
    beneficiaries: int
    implementationProgress: int
    riskFactors: List[RiskFactor]

class BudgetItem(BaseModel):
    category: str
    amount: float
    percentage: float
    description: str

class EnvironmentalMetric(BaseModel):
    metric: str
    current: float
    projected: float
    unit: str
    improvementPercentage: float
    description: str

class TimelinePhase(BaseModel):
    phase: str
    duration: str
    progress: int
    startDate: str
    endDate: str
    description: str

class ChartData(BaseModel):
    budgetAllocation: List[BudgetItem]
    environmentalImpact: List[EnvironmentalMetric]
    implementationTimeline: List[TimelinePhase]

class RelatedDepartment(BaseModel):
    name: str
    involvement: str
    role: str
    impact: str
    coordinationLevel: str
    approvalRequired: bool

class Trend(BaseModel):
    name: str
    impact: str
    probability: int
    timeframe: str
    marketImpact: int
    recommendations: str

class SummaryData(BaseModel):
    executiveSummary: str
    projectCost: float
    estimatedDuration: str
    riskLevel: str
    sustainabilityScore: int
    energyEfficiencyRating: str
    expectedROI: str

class SimilarProject(BaseModel):
    projectId: str
    title: str
    completionStatus: str  # 'Completed', 'In Progress', 'Cancelled'
    successRate: int
    actualCost: float
    plannedCost: float
    leadDepartment: str
    completionDate: str
    keyLessonsLearned: List[str]
    challenges: List[str]
    successFactors: List[str]

class ProjectResponse(BaseModel):
    title: str
    summary: SummaryData
    department: str
    chart: ChartData
    relatedDepartments: List[RelatedDepartment]
    trends: List[Trend]
    keyMetrics: KeyMetrics
    similarProjects: List[SimilarProject]

# OpenAI API key

# Add this mock database before the extract_text_from_pdf function
MOCK_PROJECTS_DB = {
    "PRJ001": {
        "projectId": "PRJ001",
        "title": "Smart City Infrastructure Enhancement",
        "completionStatus": "Completed",
        "successRate": 95,
        "actualCost": 15000000,
        "plannedCost": 14000000,
        "leadDepartment": "Abu Dhabi Digital Authority",
        "completionDate": "2023-12-15",
        "keyLessonsLearned": [
            "Early stakeholder engagement crucial",
            "Phased implementation reduced risks",
            "Regular feedback loops improved outcomes"
        ],
        "challenges": [
            "Initial resistance to digital transformation",
            "Integration with legacy systems",
            "Training requirements underestimated"
        ],
        "successFactors": [
            "Strong executive sponsorship",
            "Comprehensive change management",
            "Effective vendor partnerships"
        ]
    },
    "PRJ002": {
        "projectId": "PRJ002",
        "title": "Sustainable Energy Initiative",
        "completionStatus": "Completed",
        "successRate": 88,
        "actualCost": 25000000,
        "plannedCost": 23000000,
        "leadDepartment": "Department of Energy",
        "completionDate": "2023-09-30",
        "keyLessonsLearned": [
            "Environmental impact assessments critical",
            "Community engagement improved acceptance",
            "Technology selection crucial for success"
        ],
        "challenges": [
            "Weather-related delays",
            "Supply chain disruptions",
            "Technical expertise gaps"
        ],
        "successFactors": [
            "Strong project governance",
            "Effective risk management",
            "Regular stakeholder communication"
        ]
    }
}

# Add this near the top with other mock databases
MOCK_PDF_DB = {}  # Will store PDF files with analysis_id as key

class MockDatabase:
    def __init__(self):
        self.analyses = {}
        self.documents = {}  # This will now store PDF metadata instead of content
    
    async def save_analysis(self, analysis_id: str, analysis_data: dict, pdf_file: bytes):
        current_date = datetime.now().strftime("%Y-%m-%d")
        # Store analysis data
        self.analyses[analysis_id] = {
            current_date: analysis_data
        }
        
        # Store PDF in the PDF database
        MOCK_PDF_DB[analysis_id] = pdf_file
        
        # Store PDF metadata
        self.documents[analysis_id] = {
            "file_size": len(pdf_file),
            "upload_date": current_date,
            "file_name": f"document_{analysis_id}.pdf"
        }
    
    async def get_document(self, analysis_id: str) -> Optional[bytes]:
        return MOCK_PDF_DB.get(analysis_id)
    
    async def get_all_analyses(self) -> Dict[str, Any]:
        analyses_list = {}
        for aid, data in self.analyses.items():
            if data:
                first_date = list(data.keys())[0]
                analysis_data = data[first_date]
                pdf_content = MOCK_PDF_DB.get(aid)
                
                analyses_list[str(aid)] = {
                    "analysis": analysis_data,
                    "document": {
                        "content": base64.b64encode(pdf_content).decode('utf-8') if pdf_content else None,  # Convert to base64
                        "metadata": self.documents.get(aid, {})
                    }
                }
        
        return {
            "total": len(analyses_list),
            "analyses": analyses_list
        }

# Initialize mock database
db = MockDatabase()

# Add a helper function to find similar projects
def find_similar_projects(analysis_content: dict) -> List[dict]:
    # This is a simple implementation - you might want to make it more sophisticated
    # based on department, cost range, project type, etc.
    return list(MOCK_PROJECTS_DB.values())[:2]  # Returns top 2 similar projects

def extract_text_from_pdf(file_content: bytes) -> str:
    try:
        doc = fitz.open(stream=file_content, filetype="pdf")
        text = ""
        for page in doc:
            text += page.get_text("text")
        return text
    except Exception as e:
        logger.error(f"Error extracting text from PDF: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to extract text from PDF")

# Initialize the client
client = AsyncOpenAI(api_key=os.getenv("OPENAI_API_KEY"))

async def analyze_document_content(text: str) -> dict:
    prompt = """
    As an expert Abu Dhabi government project analyst, analyze the document considering the following departments and entities:

    External Abu Dhabi Departments:
    1. Department of Municipalities and Transport (DMT)
    2. Abu Dhabi Department of Economic Development (ADDED)
    3. Department of Health (DOH)
    4. Department of Education and Knowledge (ADEK)
    5. Department of Culture and Tourism (DCT)
    6. Abu Dhabi Agriculture and Food Safety Authority (ADAFSA)
    7. Abu Dhabi Digital Authority (ADDA)
    8. Department of Energy (DoE)
    9. Environment Agency Abu Dhabi (EAD)
    10. Abu Dhabi Police
    11. Abu Dhabi Civil Defense
    12. Abu Dhabi Housing Authority
    13. Abu Dhabi Quality and Conformity Council (QCC)
    14. Abu Dhabi Investment Office (ADIO)

    Internal Executive Office Departments:
    1. Strategy and Planning Department
    2. Project Management Office (PMO)
    3. Performance and Follow-up Department
    4. Government Services Department
    5. Government Excellence Department
    6. Government Communication Department
    7. Legal Affairs Department
    8. Financial Affairs Department
    9. Human Resources Department
    10. Information Technology Department

    Return the analysis in this exact JSON structure with proper numerical values for charts:
    {
        "2024-01-01": {
            "title": "Specific project title",
            "summary": {
                "executiveSummary": "Comprehensive analysis...",
                "projectCost": number (in AED),
                "estimatedDuration": "X years Y months",
                "riskLevel": "Low/Medium/High ",
                "sustainabilityScore": number (0-100),
                "energyEfficiencyRating": "Specific rating (A+ to F) with justification",
                "expectedROI": "X% over Y years"
            },
            "department": "Specific Abu Dhabi department name",
            "chart": {
                "budgetAllocation": [
                    {
                        "category": "Specific category",
                        "amount": number (in AED),
                        "percentage": number (0-100),
                        "description": "Detailed justification"
                    }
                ],
                "environmentalImpact": [
                    {
                        "metric": "Specific environmental metric",
                        "current": number,
                        "projected": number,
                        "unit": "specific measurement unit",
                        "improvementPercentage": number,
                        "description": "Impact analysis"
                    }
                ],
                "implementationTimeline": [
                    {
                        "phase": "Phase name",
                        "duration": "X months/years",
                        "progress": number (0-100),
                        "startDate": "YYYY-MM-DD",
                        "endDate": "YYYY-MM-DD",
                        "description": "Detailed phase description"
                    }
                ]
            },
            "relatedDepartments": [
                {
                    "name": "Specific Abu Dhabi department name OR Internal Executive Office department name",
                    "involvement": "High/Medium/Low",
                    "role": "Specific responsibilities",
                    "impact": "How this department's involvement affects project success",
                    "coordinationLevel": "Primary/Secondary/Supporting",
                    "approvalRequired": boolean
                }
            ],
            "trends": [
                {
                    "name": "Specific trend name",
                    "impact": "High/Medium/Low",
                    "probability": number (0-100),
                    "timeframe": "X months/years",
                    "marketImpact": number (0-100),
                    "recommendations": "Specific actions to take"
                }
            ],
            "keyMetrics": {
                "costPerUnit": number,
                "beneficiaries": number,
                "implementationProgress": number (0-100),
                "riskFactors": [
                    {
                        "factor": "Specific risk factor",
                        "probability": number (0-100),
                        "impact": number (0-100),
                        "mitigationStatus": number (0-100)
                    }
                ]
            },
            "similarProjects": [
                {
                    "projectId": "Unique project ID",
                    "title": "Project title",
                    "completionStatus": "Completed/In Progress/Cancelled",
                    "successRate": number (0-100),
                    "actualCost": number (in AED),
                    "plannedCost": number (in AED),
                    "leadDepartment": "Department name",
                    "completionDate": "YYYY-MM-DD",
                    "keyLessonsLearned": ["Lesson 1", "Lesson 2"],
                    "challenges": ["Challenge 1", "Challenge 2"],
                    "successFactors": ["Factor 1", "Factor 2"]
                }
            ]
        }
    }

    Important Guidelines:
    1. All numerical values must be specific numbers, not text descriptions
    2. Durations must include both number and unit (months/years)
    3. Monetary values should be in AED
    4. Percentages should be numbers between 0-100
    5. Department names must match the provided list exactly
    6. Environmental metrics must include specific measurement units
    7. Timeline phases must include specific dates
    8. All probabilities must be numerical (0-100)
    9. Include both internal and external departments in related departments
    10. Consider cross-departmental dependencies and approval requirements

    For charts and metrics:
    1. Budget allocation must sum to 100%
    2. Progress indicators must be specific numbers
    3. Timeline durations must be in specific months/years
    4. Environmental impacts must have measurable metrics
    5. Risk assessments must have numerical probabilities

    Provide specific, justified values based on the document context and Abu Dhabi government standards.

    Important Guidelines for Timeline:
    1. Duration must be a string (e.g., '1 year', '6 months')
    2. All dates must be in YYYY-MM-DD format
    3. Every phase must include a description
    4. For ongoing phases, specify an estimated end date
    5. Progress must be a number between 0-100
    """

    try:
        response = await client.chat.completions.create(
            model=os.getenv("OPENAI_MODEL", "gpt-4"),
            messages=[
                {
                    "role": "system",
                    "content": "You are an expert project analyst. Ensure all timeline entries include duration as strings (e.g., '1 year'), start/end dates, and descriptions."
                },
                {
                    "role": "user",
                    "content": f"{prompt}\n\nAnalyze this document content:\n{text}"
                }
            ],
            max_tokens=int(os.getenv("MAX_TOKENS", "2000")),
            temperature=0.3,
            presence_penalty=0,
            frequency_penalty=0,
            top_p=0.8,
        )

        result = response.choices[0].message.content.strip()
        
        # Extract JSON from response
        try:
            start = result.find('{')
            end = result.rfind('}') + 1
            if start >= 0 and end > start:
                result = result[start:end]
            
            return json.loads(result)
        except json.JSONDecodeError as e:
            logger.error(f"JSON Decode Error: {str(e)}\nResponse was: {result}")
            raise HTTPException(status_code=500, detail="Failed to parse AI response")

    except Exception as e:
        logger.error(f"OpenAI API Error: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to analyze document")

# Update upload endpoint to handle PDF properly
@app.post("/api/upload", response_model=Dict[str, str])
async def upload_document(file: UploadFile = File(...)):
    try:
        # Generate new ID
        existing_ids = [int(k) for k in db.analyses.keys()] if db.analyses else [0]
        new_id = str(max(existing_ids) + 1)
        
        file_content = await file.read()
        
        # Process the document
        text = extract_text_from_pdf(file_content)
        analysis_result = await analyze_document_content(text)
        
        # Store analysis and PDF
        await db.save_analysis(new_id, analysis_result, file_content)
        
        return {
            "message": "Document uploaded and analyzed successfully",
            "analysis_id": new_id
        }
        
    except Exception as e:
        logger.error(f"Upload error: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))

# Update get analysis endpoint to return PDF properly
@app.get("/api/analysis/{analysis_id}")
async def get_analysis(analysis_id: str):
    analysis = await db.get_analysis(analysis_id)
    if not analysis:
        raise HTTPException(status_code=404, detail="Analysis not found")
    
    pdf_content = await db.get_document(analysis_id)
    
    first_date = list(analysis.keys())[0]
    return {
        "analysis": analysis[first_date],
        "document": {
            "content": base64.b64encode(pdf_content).decode('utf-8') if pdf_content else None,  # Convert to base64
            "metadata": db.documents.get(analysis_id, {})
        }
    }

# Optional: Add a new endpoint to get just the PDF file
@app.get("/api/analysis/{analysis_id}/pdf")
async def get_pdf(analysis_id: str):
    pdf_content = await db.get_document(analysis_id)
    if not pdf_content:
        raise HTTPException(status_code=404, detail="PDF not found")
    
    return Response(
        content=pdf_content,
        media_type="application/pdf",
        headers={
            "Content-Disposition": f"attachment; filename=document_{analysis_id}.pdf"
        }
    )

# New endpoint to list all analyses
@app.get("/api/analyses")
async def list_analyses():
    analyses = await db.get_all_analyses()
    return {
        "total": len(analyses),
        "analyses": analyses
    }

# New endpoint to get analysis metadata
@app.get("/api/analysis/{analysis_id}/metadata")
async def get_analysis_metadata(analysis_id: str):
    analysis = await db.get_analysis(analysis_id)
    if not analysis:
        raise HTTPException(status_code=404, detail="Analysis not found")
    
    # Extract title from the first date key in the analysis
    first_date = list(analysis.keys())[0]
    title = analysis[first_date].get("title", "Untitled")
    
    return {
        "analysis_id": analysis_id,
        "title": title,
        "created_at": datetime.now().isoformat(),  # or store actual creation time
        "file_name": f"document_{analysis_id[:8]}.pdf"
    }