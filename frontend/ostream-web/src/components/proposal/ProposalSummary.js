import { Paper, Typography, Box, Chip, Grid } from '@mui/material';
import { Assessment, Timer, Warning, TrendingUp } from '@mui/icons-material';

function ProposalSummary({ summary = {} }) {
  const metrics = [
    { 
      icon: <Assessment />, 
      label: 'Project Cost', 
      value: summary.projectCost ? `$${summary.projectCost.toLocaleString()}` : 'N/A'
    },
    { 
      icon: <Timer />, 
      label: 'Duration', 
      value: summary.estimatedDuration || 'N/A'
    },
    { 
      icon: <Warning />, 
      label: 'Risk Level', 
      value: summary.riskLevel || 'N/A'
    },
    { 
      icon: <TrendingUp />, 
      label: 'ROI', 
      value: summary.expectedROI || 'N/A'
    }
  ];

  return (
    <Paper sx={{ p: 3 }}>
      <Typography variant="h5" gutterBottom>Project Summary</Typography>
      <Typography variant="body1" paragraph>
        {summary.executiveSummary || 'No summary available'}
      </Typography>

      <Box sx={{ mb: 2 }}>
        <Chip
          label={`Status: ${summary.status || 'In Review'}`}
          color={
            summary.status === 'approved' ? 'success' :
            summary.status === 'rejected' ? 'error' :
            'warning'
          }
          sx={{ mr: 1 }}
        />
        {summary.status === 'rejected' && summary.rejectionReason && (
          <Typography color="error" variant="body2" sx={{ mt: 1 }}>
            Rejection Reason: {summary.rejectionReason}
          </Typography>
        )}
      </Box>

      <Grid container spacing={2}>
        {metrics.map((metric, index) => (
          <Grid item xs={6} key={index}>
            <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
              {metric.icon}
              <Box sx={{ ml: 1 }}>
                <Typography variant="caption" color="text.secondary">
                  {metric.label}
                </Typography>
                <Typography variant="h6">
                  {metric.value}
                </Typography>
              </Box>
            </Box>
          </Grid>
        ))}
      </Grid>

      <Box sx={{ mt: 2 }}>
        <Chip 
          label={`Sustainability: ${summary.sustainabilityScore}%`}
          color="success"
          sx={{ mr: 1 }}
        />
        <Chip 
          label={`Energy Rating: ${summary.energyEfficiencyRating}`}
          color="primary"
        />
      </Box>
    </Paper>
  );
}

export default ProposalSummary; 