import { Container, Typography, Paper, Box } from '@mui/material';

function Home() {
  return (
    <Container maxWidth="lg">
      <Box sx={{ mt: 4 }}>
        <Paper sx={{ p: 3 }}>
          <Typography variant="h4" component="h1" gutterBottom>
            Welcome to Gov Opinion Portal
          </Typography>
          <Typography variant="body1">
            This is where you can manage and view opinion requests.
          </Typography>
        </Paper>
      </Box>
    </Container>
  );
}

export default Home;