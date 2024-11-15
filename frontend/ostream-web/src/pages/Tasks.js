import { Container, Typography, Paper, Box } from '@mui/material';

function Tasks() {
  return (
    <Container maxWidth="lg">
      <Box sx={{ mt: 4 }}>
        <Paper sx={{ p: 3 }}>
          <Typography variant="h4" component="h1" gutterBottom>
            Tasks
          </Typography>
          <Typography variant="body1">
            View and manage your assigned tasks here.
          </Typography>
        </Paper>
      </Box>
    </Container>
  );
}

export default Tasks;