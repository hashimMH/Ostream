import { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext';
import { useLocation } from 'react-router-dom';
import { 
  Container, 
  Grid, 
  Paper, 
  Typography, 
  Box,
  Divider,
  Card,
  CardContent,
  IconButton,
  Button,
  Fab,
} from '@mui/material';
import {
  VisibilityOutlined,
  AnalyticsOutlined,
  ShareOutlined,
  EditOutlined,
  CloudUploadOutlined,
  Chat,
} from '@mui/icons-material';
import ProposalSummary from '../components/proposal/ProposalSummary';
import ProposalCharts from '../components/proposal/ProposalCharts';
import ProposalRecommendations from '../components/proposal/ProposalRecommendations';
import RelatedDepartments from '../components/proposal/RelatedDepartments';
import ProposalComments from '../components/proposal/ProposalComments';
import RejectionModal from '../components/proposal/RejectionModal';
import PreviewModal from '../components/documents/PreviewModal';
import ChatWithPDFModal from '../components/proposal/ChatWithPDFModal';

function ProposalDashboard() {
  const { currentUser } = useAuth();
  const location = useLocation();
  const document = location.state?.document;
  const [proposalData, setProposalData] = useState({
    summary: {},
    departments: { primary: '', related: [] },
    charts: { budgetAllocation: [], environmentalImpact: [], implementationTimeline: [] },
    trends: [],
    keyMetrics: {},
    similarProjects: []
  });

  const [rejectModalOpen, setRejectModalOpen] = useState(false);
  const [proposalStatus, setProposalStatus] = useState('in_review');
  const [showPreview, setShowPreview] = useState(false);
  const [chatModalOpen, setChatModalOpen] = useState(false);

  const handleAddComment = (newComment) => {
    setProposalData(prev => ({
      ...prev,
      comments: [
        ...prev.comments,
        {
          id: Date.now(),
          ...newComment
        }
      ]
    }));
  };

  const handleEditComment = (commentId, newText) => {
    setProposalData(prev => ({
      ...prev,
      comments: prev.comments.map(comment =>
        comment.id === commentId
          ? { ...comment, text: newText, edited: true }
          : comment
      )
    }));
  };

  const handleDeleteComment = (commentId) => {
    setProposalData(prev => ({
      ...prev,
      comments: prev.comments.filter(comment => comment.id !== commentId)
    }));
  };

  const handleApprove = () => {
    setProposalData(prev => ({
      ...prev,
      status: 'approved'
    }));
    setProposalStatus('approved');
  };

  const handleReject = (reason) => {
    setProposalData(prev => ({
      ...prev,
      status: 'rejected',
      rejectionReason: reason,
      comments: [
        ...prev.comments,
        {
          id: Date.now(),
          user: currentUser.username,
          text: `Rejection reason: ${reason}`,
          timestamp: new Date().toISOString(),
          type: 'rejection'
        }
      ]
    }));
    setProposalStatus('rejected');
    setRejectModalOpen(false);
  };

  useEffect(() => {
    if (document) {
      console.log(JSON.stringify(document));
      setProposalData({
        summary: {
          ...document.summary,
          status: document.status || 'in_review'
        },
        departments: {
          primary: typeof document.department === 'string' ? document.department : document.department?.primary || '',
          related: document.relatedDepartments || []
        },
        charts: {
          budgetAllocation: document.chart?.budgetAllocation?.map(item => ({
            category: item.category,
            amount: item.amount,
            percentage: item.percentage,
            description: item.description
          })) || [],
          environmentalImpact: document.chart?.environmentalImpact?.map(item => ({
            name: item.metric,
            current: item.current,
            projected: item.projected,
            unit: item.unit,
            improvementPercentage: item.improvementPercentage,
            description: item.description
          })) || [],
          implementationTimeline: document.chart?.implementationTimeline?.map(item => ({
            phase: item.phase,
            progress: item.progress,
            duration: item.duration,
            startDate: item.startDate,
            endDate: item.endDate,
            description: item.description
          })) || []
        },
        trends: document.trends?.map(trend => ({
          id: trend.name || Math.random().toString(),
          title: trend.name,
          description: trend.recommendations,
          priority: trend.impact,
          estimatedImpact: `${trend.probability}% probability, ${trend.marketImpact}% market impact`,
          timeframe: trend.timeframe
        })) || [],
        keyMetrics: document.keyMetrics || {},
        similarProjects: document.similarProjects || []
      });
    }
  }, [document]);

  return (
    <>
      <Container maxWidth="xl">
        <Box sx={{ mt: 4, mb: 4 }}>
          <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 3 }}>
            <Typography variant="h4">
              {document?.title || 'Project Proposal'}
            </Typography>
            <Box>
              {document && (
                <Button
                  variant="outlined"
                  startIcon={<VisibilityOutlined />}
                  onClick={() => setShowPreview(true)}
                  sx={{ mr: 2 }}
                >
                  Preview Document
                </Button>
              )}
              <Button
                variant="contained"
                color="success"
                onClick={handleApprove}
                disabled={proposalStatus === 'approved' || proposalStatus === 'rejected'}
                sx={{ mr: 1 }}
              >
                Approve
              </Button>
              <Button
                variant="contained"
                color="error"
                onClick={() => setRejectModalOpen(true)}
                disabled={proposalStatus === 'approved' || proposalStatus === 'rejected'}
                sx={{ mr: 2 }}
              >
                Reject
              </Button>
              <IconButton title="Share">
                <ShareOutlined />
              </IconButton>
              <IconButton title="Edit">
                <EditOutlined />
              </IconButton>
              <Button
                variant="contained"
                startIcon={<CloudUploadOutlined />}
                sx={{ ml: 2 }}
              >
                Export Report
              </Button>
            </Box>
          </Box>
          <Divider sx={{ mb: 4 }} />
          
          <Grid container spacing={3}>
            <Grid item xs={12} md={6}>
              <ProposalSummary summary={proposalData.summary} />
            </Grid>
            
            <Grid item xs={12} md={6}>
              <RelatedDepartments 
                primary={proposalData.departments.primary}
                departments={proposalData.departments.related} 
              />
            </Grid>
            
            <Grid item xs={12}>
              <Paper sx={{ p: 3, mb: 3 }}>
                <Typography variant="h5" gutterBottom>
                  Project Analytics
                </Typography>
                <ProposalCharts charts={proposalData.charts} />
              </Paper>
            </Grid>
            
            <Grid item xs={12}>
              <ProposalRecommendations recommendations={proposalData.trends} />
            </Grid>

            {/* Key Metrics Section */}
            <Grid item xs={12}>
              <Paper sx={{ p: 3 }}>
                <Typography variant="h5" gutterBottom>Key Metrics</Typography>
                <Grid container spacing={2}>
                  {Object.entries(proposalData.keyMetrics || {}).map(([key, value]) => {
                    if (key === 'riskFactors') return null;
                    return (
                      <Grid item xs={12} sm={6} md={3} key={key}>
                        <Box sx={{ p: 2, border: 1, borderColor: 'divider', borderRadius: 1 }}>
                          <Typography variant="subtitle2" color="text.secondary">
                            {key.replace(/([A-Z])/g, ' $1').replace(/^./, str => str.toUpperCase())}
                          </Typography>
                          <Typography variant="h6">
                            {typeof value === 'number' ? value.toLocaleString() : value || 'N/A'}
                          </Typography>
                        </Box>
                      </Grid>
                    );
                  })}
                </Grid>
              </Paper>
            </Grid>

            {/* Similar Projects Section */}
            {proposalData.similarProjects?.length > 0 && (
              <Grid item xs={12}>
                <Paper sx={{ p: 3 }}>
                  <Typography variant="h5" gutterBottom>Similar Projects</Typography>
                  <Grid container spacing={2}>
                    {proposalData.similarProjects.map((project, index) => (
                      <Grid item xs={12} md={6} key={index}>
                        <Card>
                          <CardContent>
                            <Typography variant="h6">{project.title}</Typography>
                            <Typography variant="body2" color="text.secondary">
                              Status: {project.completionStatus}
                            </Typography>
                            <Typography variant="body2">
                              Success Rate: {project.successRate}%
                            </Typography>
                            <Typography variant="subtitle2" gutterBottom sx={{ mt: 1 }}>
                              Key Lessons:
                            </Typography>
                            <ul>
                              {project.keyLessonsLearned?.map((lesson, i) => (
                                <li key={i}>{lesson}</li>
                              ))}
                            </ul>
                          </CardContent>
                        </Card>
                      </Grid>
                    ))}
                  </Grid>
                </Paper>
              </Grid>
            )}
          </Grid>
          <RejectionModal
            open={rejectModalOpen}
            onClose={() => setRejectModalOpen(false)}
            onReject={handleReject}
          />
        </Box>
      </Container>

      {(document && showPreview) && (
        <PreviewModal
          open={showPreview}
          onClose={() => setShowPreview(false)}
          document={document}
        />
      )}

      <Fab
        color="primary"
        sx={{
          position: 'fixed',
          bottom: 16,
          right: 16,
        }}
        onClick={() => setChatModalOpen(true)}
      >
        <Chat />
      </Fab>

      <ChatWithPDFModal
        open={chatModalOpen}
        onClose={() => setChatModalOpen(false)}
        document={document}
      />
    </>
  );
}

export default ProposalDashboard; 