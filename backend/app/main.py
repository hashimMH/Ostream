from fastapi import FastAPI, UploadFile, File, HTTPException
from typing import Dict, List, Union, Any
from pydantic import BaseModel
import fitz  # PyMuPDF
import logging
from io import BytesIO
import openai
import json
from fastapi.middleware.cors import CORSMiddleware
import uuid
from decouple import config
import os

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Load OpenAI API key from .env
openai.api_key = config("OPENAI_API_KEY")

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

class ProjectResponse(BaseModel):
    title: str
    summary: SummaryData
    department: str
    chart: ChartData
    relatedDepartments: List[RelatedDepartment]
    trends: List[Trend]
    keyMetrics: KeyMetrics

# OpenAI API key

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
                "riskLevel": "Low/Medium/High with specific reasons",
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
                    "name": "Specific Abu Dhabi department name from the list above",
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
            }
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
        response = await openai.ChatCompletion.acreate(
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

# Store analysis results in memory (in production, use a proper database)
analysis_results = {}

@app.post("/api/upload", response_model=Dict[str, str])
async def upload_document(file: UploadFile = File(...)):
    try:
        # Generate unique ID for this analysis
        analysis_id = str(uuid.uuid4())
        
        file_content = await file.read()
        text = extract_text_from_pdf(file_content)
        analysis = await analyze_document_content(text)
        
        # Store the analysis result
        analysis_results[analysis_id] = analysis
        
        return {
            "status": "success",
            "message": "Document analyzed successfully",
            "analysis_id": analysis_id
        }
        
    except Exception as e:
        logger.error(f"Error processing document: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/api/analysis/{analysis_id}", response_model=Dict[str, ProjectResponse])
async def get_analysis(analysis_id: str):
    if analysis_id not in analysis_results:
        raise HTTPException(status_code=404, detail="Analysis not found")
    
    return analysis_results[analysis_id]
