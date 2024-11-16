import { useState } from 'react';
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
} from '@mui/material';
import {
  VisibilityOutlined,
  AnalyticsOutlined,
  ShareOutlined,
  EditOutlined,
  CloudUploadOutlined,
} from '@mui/icons-material';
import ProposalSummary from '../components/proposal/ProposalSummary';
import ProposalCharts from '../components/proposal/ProposalCharts';
import ProposalRecommendations from '../components/proposal/ProposalRecommendations';
import RelatedDepartments from '../components/proposal/RelatedDepartments';

function ProposalDashboard() {
  const [proposalData] = useState({
    summary: {
      projectCost: 15000000,
      estimatedDuration: "24 months",
      riskLevel: "Medium",
      expectedROI: "35%",
      executiveSummary: "Implementation of an integrated smart transportation system across major city districts",
      sustainabilityScore: 85,
      energyEfficiencyRating: "A"
    },
    departments: {
      primary: "Urban Development",
      related: [
        { name: "Transportation", role: "Infrastructure Planning", involvement: "High" },
        { name: "Technology", role: "System Integration", involvement: "High" },
        { name: "Environment", role: "Impact Assessment", involvement: "Medium" }
      ]
    },
    charts: {
      budgetAllocation: [
        { category: "Infrastructure", amount: 7500000 },
        { category: "Technology", amount: 4500000 },
        { category: "Operations", amount: 2000000 },
        { category: "Consulting", amount: 1000000 }
      ],
      environmentalImpact: [
        { name: "CO2 Emissions", current: 100, projected: 45 },
        { name: "Energy Usage", current: 90, projected: 40 },
        { name: "Waste", current: 85, projected: 35 }
      ],
      implementationTimeline: [
        { month: "Q1", progress: 25 },
        { month: "Q2", progress: 45 },
        { month: "Q3", progress: 75 },
        { month: "Q4", progress: 100 }
      ]
    },
    recommendations: [
      {
        id: 1,
        title: "Smart Traffic Management",
        description: "Implement AI-driven traffic management system",
        priority: "High",
        estimatedImpact: "40% reduction in congestion"
      },
      {
        id: 2,
        title: "Green Transportation",
        description: "Electric vehicle charging infrastructure",
        priority: "Medium",
        estimatedImpact: "30% emission reduction"
      }
    ]
  });

  return (
    <Container maxWidth="xl">
      <Box sx={{ mt: 4, mb: 4 }}>
        <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 3 }}>
          <Typography variant="h4">
            Smart City Transportation Proposal
          </Typography>
          <Box>
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
            <RelatedDepartments departments={proposalData.departments} />
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
            <ProposalRecommendations recommendations={proposalData.recommendations} />
          </Grid>
        </Grid>
      </Box>
    </Container>
  );
}

export default ProposalDashboard; 