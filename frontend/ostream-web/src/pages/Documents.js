import { useState, useMemo } from 'react';
import { useAuth } from '../context/AuthContext';
import useDocumentStore from '../store/documentStore';
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
  const { documents } = useDocumentStore();
  const { currentUser } = useAuth();
  const navigate = useNavigate();
  
  // Add modal states
  const [selectedDoc, setSelectedDoc] = useState(null);
  const [modalStates, setModalStates] = useState({
    upload: false,
    preview: false,
    edit: false,
    share: false,
    analysis: false,
    comments: false,
    versionHistory: false
  });
  
  const [searchQuery, setSearchQuery] = useState('');
  const [filters, setFilters] = useState({
    type: 'all',
    status: 'all'
  });

  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(5);

  // Add modal handlers
  const handleModalOpen = (modalType, document = null) => {
    if (document) {
      setSelectedDoc(document);
    }
    setModalStates(prev => ({
      ...prev,
      [modalType]: true
    }));
  };

  const handleModalClose = (modalType) => {
    setModalStates(prev => ({
      ...prev,
      [modalType]: false
    }));
    if (modalType === 'upload') {
      setSelectedDoc(null);
    }
  };

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };

  // Filter documents based on user role and department
  const filteredDocuments = useMemo(() => {
    return documents.filter(doc => {
      // Basic search and filter conditions
      const matchesSearch = doc.name.toLowerCase().includes(searchQuery.toLowerCase());
      const matchesType = filters.type === 'all' || doc.type === filters.type;
      const matchesStatus = filters.status === 'all' || doc.status === filters.status;

      // Access control based on role and department
      if (currentUser.role === 'superadmin') {
        return matchesSearch && matchesType && matchesStatus;
      }

      // For non-admin users, show only their department's documents and shared documents
      const hasAccess = 
        doc.department === currentUser.department || 
        doc.sharedWith?.includes(currentUser.department);

      return matchesSearch && matchesType && matchesStatus && hasAccess;
    });
  }, [documents, searchQuery, filters, currentUser]);

  const renderActionButtons = (doc) => {
    return (
      <>
        <IconButton 
          size="small" 
          title="Preview"
          onClick={() => handleModalOpen('preview', doc)}
        >
          <VisibilityOutlined />
        </IconButton>
        
        {(currentUser.role === 'superadmin' || doc.department === currentUser.department) && (
          <IconButton 
            size="small" 
            title="Edit"
            onClick={() => handleModalOpen('edit', doc)}
          >
            <EditOutlined />
          </IconButton>
        )}
        
        <IconButton 
          size="small" 
          title="Analysis"
          onClick={() => handleModalOpen('analysis', doc)}
        >
          <AnalyticsOutlined />
        </IconButton>
        
        {(currentUser.role === 'superadmin' || doc.department === currentUser.department) && (
          <IconButton 
            size="small" 
            title="Share"
            onClick={() => handleModalOpen('share', doc)}
          >
            <ShareOutlined />
          </IconButton>
        )}
        
        <IconButton 
          size="small" 
          title="Comments"
          onClick={() => handleModalOpen('comments', doc)}
        >
          <CommentOutlined />
        </IconButton>
        
        <IconButton 
          size="small" 
          title="Version History"
          onClick={() => handleModalOpen('versionHistory', doc)}
        >
          <HistoryOutlined />
        </IconButton>
      </>
    );
  };

  return (
    <>
      <Container maxWidth="xl">
        <Box sx={{ mt: 4 }}>
          <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 3 }}>
            <Typography variant="h4">
              Documents {currentUser.role !== 'superadmin' && `- ${currentUser.department}`}
            </Typography>
            <Button
              variant="contained"
              startIcon={<CloudUploadOutlined />}
              onClick={() => handleModalOpen('upload')}
            >
              Upload Document
            </Button>
          </Box>

          {/* Filters */}
          <Box sx={{ mb: 3, display: 'flex', gap: 2 }}>
            <TextField
              size="small"
              placeholder="Search documents..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              InputProps={{
                startAdornment: (
                  <InputAdornment position="start">
                    <Search />
                  </InputAdornment>
                ),
              }}
              sx={{ width: 300 }}
            />

            <FormControl size="small" sx={{ minWidth: 120 }}>
              <InputLabel>Type</InputLabel>
              <Select
                value={filters.type}
                label="Type"
                onChange={(e) => setFilters({ ...filters, type: e.target.value })}
              >
                <MenuItem value="all">All Types</MenuItem>
                <MenuItem value="PDF">PDF</MenuItem>
                <MenuItem value="DOCX">DOCX</MenuItem>
                <MenuItem value="XLSX">XLSX</MenuItem>
              </Select>
            </FormControl>

            <FormControl size="small" sx={{ minWidth: 120 }}>
              <InputLabel>Status</InputLabel>
              <Select
                value={filters.status}
                label="Status"
                onChange={(e) => setFilters({ ...filters, status: e.target.value })}
              >
                <MenuItem value="all">All Status</MenuItem>
                <MenuItem value="draft">Draft</MenuItem>
                <MenuItem value="in_review">In Review</MenuItem>
                <MenuItem value="approved">Approved</MenuItem>
              </Select>
            </FormControl>
          </Box>

          {/* Documents Table */}
          <Paper>
            <TableContainer>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell>Document Name</TableCell>
                    <TableCell>Type</TableCell>
                    <TableCell>Department</TableCell>
                    <TableCell>Status</TableCell>
                    <TableCell>Last Modified</TableCell>
                    <TableCell align="right">Actions</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {filteredDocuments
                    .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                    .map((doc) => (
                      <TableRow 
                        key={doc.id} 
                        onClick={() => navigate('/proposal')}
                        sx={{ cursor: 'pointer' }}
                      >
                        <TableCell>{doc.name}</TableCell>
                        <TableCell>{doc.type}</TableCell>
                        <TableCell>{doc.department}</TableCell>
                        <TableCell>
                          <Box sx={{ display: 'flex', alignItems: 'center' }}>
                            {doc.status === 'approved' && <CheckCircleOutlined color="success" sx={{ mr: 1 }} />}
                            {doc.status === 'in_review' && <PendingOutlined color="warning" sx={{ mr: 1 }} />}
                            {doc.status === 'draft' && <DescriptionOutlined color="info" sx={{ mr: 1 }} />}
                            {doc.status}
                          </Box>
                        </TableCell>
                        <TableCell>
                          {new Date(doc.lastModified).toLocaleDateString()}
                        </TableCell>
                        <TableCell align="right">
                          <IconButton 
                            size="small"
                            onClick={(e) => {
                              e.stopPropagation();
                              navigate('/proposal');
                            }}
                          >
                            <VisibilityOutlined />
                          </IconButton>
                        </TableCell>
                      </TableRow>
                    ))}
                  {filteredDocuments.length === 0 && (
                    <TableRow>
                      <TableCell colSpan={6} align="center">
                        No documents found
                      </TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </TableContainer>
            <TablePagination
              rowsPerPageOptions={[5, 10, 25]}
              component="div"
              count={filteredDocuments.length}
              rowsPerPage={rowsPerPage}
              page={page}
              onPageChange={handleChangePage}
              onRowsPerPageChange={handleChangeRowsPerPage}
            />
          </Paper>
        </Box>
      </Container>

      {/* Modals */}
      <UploadModal
        open={modalStates.upload}
        onClose={() => handleModalClose('upload')}
      />

      <PreviewModal
        open={modalStates.preview}
        onClose={() => handleModalClose('preview')}
        document={selectedDoc}
      />

      <EditDocumentModal
        open={modalStates.edit}
        onClose={() => handleModalClose('edit')}
        document={selectedDoc}
      />

      <ShareModal
        open={modalStates.share}
        onClose={() => handleModalClose('share')}
        document={selectedDoc}
      />

      <CommentsModal
        open={modalStates.comments}
        onClose={() => handleModalClose('comments')}
        document={selectedDoc}
      />

      <AnalysisModal
        open={modalStates.analysis}
        onClose={() => handleModalClose('analysis')}
        document={selectedDoc}
      />

      <VersionHistoryModal
        open={modalStates.versionHistory}
        onClose={() => handleModalClose('versionHistory')}
        document={selectedDoc}
      />
    </>
  );
}

export default Documents;