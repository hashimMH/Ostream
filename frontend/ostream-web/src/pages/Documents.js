import { useState, useEffect } from 'react';
import { documentApi } from '../services/api';
import {
  Container,
  Typography,
  Paper,
  Box,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  IconButton,
  Button,
  TextField,
  InputAdornment,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  TablePagination,
  CircularProgress,
  Alert,
  Chip,
} from '@mui/material';
import {
  VisibilityOutlined,
  AnalyticsOutlined,
  ShareOutlined,
  EditOutlined,
  CommentOutlined,
  CloudUploadOutlined,
  HistoryOutlined,
  Search,
  CheckCircleOutlined,
  PendingOutlined,
  DescriptionOutlined,
} from '@mui/icons-material';
import EditDocumentModal from '../components/documents/EditDocumentModal';
import UploadModal from '../components/documents/UploadModal';
import PreviewModal from '../components/documents/PreviewModal';
import ShareModal from '../components/documents/ShareModal';
import CommentsModal from '../components/documents/CommentsModal';
import AnalysisModal from '../components/documents/AnalysisModal';
import VersionHistoryModal from '../components/documents/VersionHistoryModal';
import { useNavigate } from 'react-router-dom';

function Documents() {
  const navigate = useNavigate();
  const [analyses, setAnalyses] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(5);
  const [documentFiles, setDocumentFiles] = useState({});

  useEffect(() => {
    const fetchAnalyses = async () => {
      try {
        setIsLoading(true);
        const response = await fetch('http://127.0.0.1:8000/api/analyses');
        
        if (!response.ok) {
          throw new Error('Failed to fetch analyses');
        }

        const data = await response.json();
        const analysesArray = Object.entries(data.analyses.analyses).map(([id, analysisData]) => {
          const latestDate = Object.keys(analysisData.analysis)[0];
          const analysis = analysisData.analysis[latestDate];
          const document = analysisData.document;
          
          return {
            id,
            title: analysis.title,
            summary: analysis.summary,
            department: analysis.department,
            relatedDepartments: analysis.relatedDepartments || [],
            chart: analysis.chart,
            trends: analysis.trends || [],
            keyMetrics: analysis.keyMetrics || {},
            similarProjects: analysis.similarProjects || [],
            file: document ? new File(
              [Uint8Array.from(atob(document.content), c => c.charCodeAt(0))],
              document.metadata.file_name,
              { type: 'application/pdf' }
            ) : null,
            fileName: document?.metadata.file_name
          };
        });
        setAnalyses(analysesArray);
      } catch (err) {
        console.error('Error fetching analyses:', err);
        setError('Failed to load analyses');
      } finally {
        setIsLoading(false);
      }
    };

    fetchAnalyses();
  }, []);

  const handleFileUpload = (analysisId, file) => {
    setDocumentFiles(prev => ({
      ...prev,
      [analysisId]: {
        file,
        fileName: file.name,
        type: file.type
      }
    }));
  };

  const handleViewProposal = (analysis) => {
    navigate('/proposal', { 
      state: { 
        document: {
          ...analysis,
          file: analysis.file,
          fileName: analysis.fileName
        }
      }
    });
  };

  return (
    <Container maxWidth="xl">
      <Box sx={{ mt: 4 }}>
        <Paper>
          <TableContainer>
            <Table>
              <TableHead>
                <TableRow>
                  <TableCell>ID</TableCell>
                  <TableCell>Title</TableCell>
                  <TableCell>Risk Level</TableCell>
                  <TableCell>Project Cost</TableCell>
                  <TableCell>Duration</TableCell>
                  <TableCell align="right">Actions</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {isLoading ? (
                  <TableRow>
                    <TableCell colSpan={6} align="center">
                      <CircularProgress size={24} sx={{ mr: 1 }} />
                      Loading analyses...
                    </TableCell>
                  </TableRow>
                ) : error ? (
                  <TableRow>
                    <TableCell colSpan={6}>
                      <Alert severity="error" sx={{ m: 1 }}>
                        {error}
                      </Alert>
                    </TableCell>
                  </TableRow>
                ) : (
                  analyses
                    .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                    .map((analysis) => (
                      <TableRow 
                        key={analysis.id}
                        sx={{ '&:hover': { backgroundColor: 'action.hover' } }}
                      >
                        <TableCell>{analysis.id}</TableCell>
                        <TableCell>{analysis.title}</TableCell>
                        <TableCell>
                          <Chip
                            label={analysis.summary?.riskLevel?.split('-')[0].trim() || 'Not Specified'}
                            color={
                              analysis.summary?.riskLevel?.includes('Low') ? 'success' :
                              analysis.summary?.riskLevel?.includes('Medium') ? 'warning' :
                              'error'
                            }
                            size="small"
                          />
                        </TableCell>
                        <TableCell>
                          {analysis.summary?.projectCost?.toLocaleString() || 'N/A'} AED
                        </TableCell>
                        <TableCell>{analysis.summary?.estimatedDuration || 'N/A'}</TableCell>
                        <TableCell align="right">
                          <input
                            type="file"
                            id={`file-upload-${analysis.id}`}
                            style={{ display: 'none' }}
                            onChange={(e) => handleFileUpload(analysis.id, e.target.files[0])}
                          />
                          <label htmlFor={`file-upload-${analysis.id}`}>
                            <IconButton component="span" size="small">
                              <CloudUploadOutlined />
                            </IconButton>
                          </label>
                          <IconButton 
                            size="small"
                            onClick={() => handleViewProposal(analysis)}
                          >
                            <VisibilityOutlined />
                          </IconButton>
                        </TableCell>
                      </TableRow>
                    ))
                )}
                {!isLoading && analyses.length === 0 && (
                  <TableRow>
                    <TableCell colSpan={6} align="center">
                      No analyses found
                    </TableCell>
                  </TableRow>
                )}
              </TableBody>
            </Table>
          </TableContainer>
          <TablePagination
            rowsPerPageOptions={[5, 10, 25]}
            component="div"
            count={analyses.length}
            rowsPerPage={rowsPerPage}
            page={page}
            onPageChange={(e, newPage) => setPage(newPage)}
            onRowsPerPageChange={(e) => {
              setRowsPerPage(parseInt(e.target.value, 10));
              setPage(0);
            }}
          />
        </Paper>
      </Box>
    </Container>
  );
}

export default Documents;