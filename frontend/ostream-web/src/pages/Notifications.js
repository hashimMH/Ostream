import { Container, Typography, Paper, Box } from '@mui/material';

function Notifications() {
  return (
    <Container maxWidth="lg">
      <Box sx={{ mt: 4 }}>
        <Paper sx={{ p: 3 }}>
          <Typography variant="h4" component="h1" gutterBottom>
            Notifications
          </Typography>
          <Typography variant="body1">
            View your system notifications here.
          </Typography>
        </Paper>
      </Box>
    </Container>
  );
}

export default Notifications;