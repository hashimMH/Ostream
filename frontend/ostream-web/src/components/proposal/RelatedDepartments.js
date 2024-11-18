import { Paper, Typography, Box, Avatar, Chip, Grid } from '@mui/material';
import { Business } from '@mui/icons-material';

function RelatedDepartments({ primary = '', departments = [] }) {
  return (
    <Paper sx={{ p: 3 }}>
      <Typography variant="h5" gutterBottom>Related Departments</Typography>
      
      <Box sx={{ mb: 3 }}>
        <Typography variant="subtitle1" gutterBottom>
          Primary Department
        </Typography>
        <Chip
          icon={<Business />}
          label={primary || 'Not Specified'}
          color="primary"
          size="large"
        />
      </Box>

      <Typography variant="subtitle1" gutterBottom>
        Related Departments
      </Typography>
      <Grid container spacing={2}>
        {departments?.map((dept, index) => (
          <Grid item xs={12} key={index}>
            <Box sx={{ 
              display: 'flex', 
              alignItems: 'center',
              p: 2,
              border: 1,
              borderColor: 'divider',
              borderRadius: 1
            }}>
              <Avatar sx={{ bgcolor: 'primary.main', mr: 2 }}>
                {dept.name?.[0] || '?'}
              </Avatar>
              <Box>
                <Typography variant="subtitle2">{dept.name}</Typography>
                <Typography variant="body2" color="text.secondary">
                  {dept.role}
                </Typography>
                <Chip 
                  label={`Involvement: ${dept.involvement}`}
                  size="small"
                  sx={{ mt: 1 }}
                  color={dept.involvement === 'High' ? 'error' : 'default'}
                />
              </Box>
            </Box>
          </Grid>
        ))}
      </Grid>
    </Paper>
  );
}

export default RelatedDepartments; 