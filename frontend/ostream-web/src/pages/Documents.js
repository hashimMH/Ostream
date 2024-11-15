import { Container, Typography, Paper, Box } from '@mui/material';

function Documents() {
  return (
    <Container maxWidth="lg">
      <Box sx={{ mt: 4 }}>
        <Paper sx={{ p: 3 }}>
          <Typography variant="h4" component="h1" gutterBottom>
            Documents
          </Typography>
          <Typography variant="body1">
            Manage your documents and opinion requests here.
          </Typography>
        </Paper>
      </Box>
    </Container>
  );
}

export default Documents;