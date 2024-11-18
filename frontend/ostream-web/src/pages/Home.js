import { useState, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import useDocumentStore from '../store/documentStore';
import {
  Container,
  Grid,
  Paper,
  Typography,
  Box,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  IconButton,
  Button,
  Card,
  CardContent,
  LinearProgress,
} from '@mui/material';
import {
  VisibilityOutlined,
  CloudUploadOutlined,
  DescriptionOutlined,
  AssignmentOutlined,
  NotificationsOutlined,
  PendingOutlined,
  TrendingUpOutlined,
  CheckCircleOutlined,
} from '@mui/icons-material';

// Import modals
import UploadModal from '../components/documents/UploadModal';
import PreviewModal from '../components/documents/PreviewModal';

function Home() {
  const navigate = useNavigate();
  const { currentUser } = useAuth();
  const { documents } = useDocumentStore();
  const [selectedDoc, setSelectedDoc] = useState(null);
  const [modalStates, setModalStates] = useState({
    upload: false,
    preview: false,
  });
  // Calculate statistics based on user role and department
  const stats = useMemo(() => {
    const userDocs = currentUser.role === 'superadmin'
      ? documents
      : documents.filter(doc =>
          doc.department === currentUser.department ||
          doc.sharedWith?.includes(currentUser.department)
        );

    return {
      totalDocuments: userDocs.length,
      pendingReview: userDocs.filter(doc => doc.status === 'in_review').length,
      drafts: userDocs.filter(doc => doc.status === 'draft').length,
      approved: userDocs.filter(doc => doc.status === 'approved').length,
      recentActivity: userDocs
        .sort((a, b) => new Date(b.lastModified) - new Date(a.lastModified))
        .slice(0, 5),
      departmentBreakdown: documents.reduce((acc, doc) => {
        acc[doc.department] = (acc[doc.department] || 0) + 1;
        return acc;
      }, {}),
    };
  }, [documents, currentUser]);

  // Modal handlers
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

  // Calculate completion percentage
  const getCompletionPercentage = () => {
    if (stats.totalDocuments === 0) return 0;
    return Math.round((stats.approved / stats.totalDocuments) * 100);
  };

  return (
    <Container maxWidth="xl">
      <Box sx={{ mt: 4 }}>
        <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 3 }}>
          <Typography variant="h4">
            Welcome, {currentUser.username}!
          </Typography>
          <Button
            variant="contained"
            startIcon={<CloudUploadOutlined />}
            onClick={() => handleModalOpen('upload')}
          >
            Upload Document
          </Button>
        </Box>

        {/* Statistics Cards */}
        <Grid container spacing={3} sx={{ mb: 4 }}>
          <Grid item xs={12} sm={6} md={3}>
            <Card>
              <CardContent>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
                  <DescriptionOutlined color="primary" sx={{ mr: 1 }} />
                  <Typography variant="h6">Total Documents</Typography>
                </Box>
                <Typography variant="h3">{stats.totalDocuments}</Typography>
                <LinearProgress 
                  variant="determinate" 
                  value={getCompletionPercentage()} 
                  sx={{ mt: 2 }}
                />
                <Typography variant="caption" color="text.secondary">
                  {getCompletionPercentage()}% Completed
                </Typography>
              </CardContent>
            </Card>
          </Grid>

          <Grid item xs={12} sm={6} md={3}>
            <Card>
              <CardContent>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
                  <PendingOutlined color="warning" sx={{ mr: 1 }} />
                  <Typography variant="h6">Pending Review</Typography>
                </Box>
                <Typography variant="h3">{stats.pendingReview}</Typography>
                <Typography variant="caption" color="text.secondary">
                  Documents awaiting review
                </Typography>
              </CardContent>
            </Card>
          </Grid>

          <Grid item xs={12} sm={6} md={3}>
            <Card>
              <CardContent>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
                  <TrendingUpOutlined color="info" sx={{ mr: 1 }} />
                  <Typography variant="h6">Drafts</Typography>
                </Box>
                <Typography variant="h3">{stats.drafts}</Typography>
                <Typography variant="caption" color="text.secondary">
                  Documents in progress
                </Typography>
              </CardContent>
            </Card>
          </Grid>

          <Grid item xs={12} sm={6} md={3}>
            <Card>
              <CardContent>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
                  <CheckCircleOutlined color="success" sx={{ mr: 1 }} />
                  <Typography variant="h6">Approved</Typography>
                </Box>
                <Typography variant="h3">{stats.approved}</Typography>
                <Typography variant="caption" color="text.secondary">
                  Finalized documents
                </Typography>
              </CardContent>
            </Card>
          </Grid>
        </Grid>

        {/* Recent Activity */}
        <Box sx={{ mb: 4 }}>
          <Typography variant="h5" gutterBottom>
            Recent Activity
          </Typography>
          <TableContainer component={Paper}>
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
                {stats.recentActivity.map((doc) => (
                  <TableRow 
                    key={doc.id} 
                    onClick={() => navigate('/proposal', { state: { document: doc } })}
                    sx={{ cursor: 'pointer', '&:hover': { backgroundColor: 'action.hover' } }}
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
                          navigate('/proposal', { state: { document: doc } });
                        }}
                      >
                        <VisibilityOutlined />
                      </IconButton>
                    </TableCell>
                  </TableRow>
                ))}
                {stats.recentActivity.length === 0 && (
                  <TableRow>
                    <TableCell colSpan={6} align="center">
                      No recent activity
                    </TableCell>
                  </TableRow>
                )}
              </TableBody>
            </Table>
          </TableContainer>
        </Box>

        {/* Department Breakdown */}
        {currentUser.role === 'superadmin' && (
          <Box>
            <Typography variant="h5" gutterBottom>
              Department Breakdown
            </Typography>
            <Grid container spacing={2}>
              {Object.entries(stats.departmentBreakdown).map(([dept, count]) => (
                <Grid item xs={12} sm={6} md={3} key={dept}>
                  <Paper sx={{ p: 2 }}>
                    <Typography variant="h6">{dept}</Typography>
                    <Typography variant="h4">{count}</Typography>
                    <Typography variant="body2" color="text.secondary">
                      Documents
                    </Typography>
                  </Paper>
                </Grid>
              ))}
            </Grid>
          </Box>
        )}
      </Box>

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
    </Container>
  );
}

export default Home;