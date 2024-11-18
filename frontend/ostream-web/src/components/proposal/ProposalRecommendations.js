import { Paper, Typography, Box, Chip, List, ListItem, ListItemText, ListItemIcon } from '@mui/material';
import { PriorityHigh, TrendingUp } from '@mui/icons-material';

function ProposalRecommendations({ recommendations = [] }) {
  if (!recommendations || recommendations.length === 0) {
    return null;
  }

  return (
    <Paper sx={{ p: 3 }}>
      <Typography variant="h5" gutterBottom>Recommendations</Typography>
      <List>
        {recommendations.map((rec) => (
          <ListItem key={rec.id} alignItems="flex-start" sx={{ borderBottom: 1, borderColor: 'divider' }}>
            <ListItemIcon>
              <PriorityHigh color={rec.priority === 'High' ? 'error' : 'action'} />
            </ListItemIcon>
            <ListItemText
              primary={rec.title}
              secondary={
                <Box>
                  <Typography variant="body2" paragraph>
                    {rec.description}
                  </Typography>
                  <Box sx={{ display: 'flex', gap: 1 }}>
                    <Chip 
                      icon={<TrendingUp />} 
                      label={rec.estimatedImpact} 
                      size="small" 
                      color="primary"
                    />
                    <Chip 
                      label={`Priority: ${rec.priority}`}
                      size="small"
                      color={rec.priority === 'High' ? 'error' : 'default'}
                    />
                  </Box>
                </Box>
              }
            />
          </ListItem>
        ))}
      </List>
    </Paper>
  );
}

export default ProposalRecommendations; 