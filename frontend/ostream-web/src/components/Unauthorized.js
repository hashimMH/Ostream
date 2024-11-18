import React from 'react';
import { Box, Typography, Button } from '@mui/material';
import { useNavigate } from 'react-router-dom';

function Unauthorized() {
  const navigate = useNavigate();

  return (
    <Box
      sx={{
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        minHeight: '100vh',
      }}
    >
      <Typography variant="h4" component="h1" gutterBottom>
        Unauthorized Access
      </Typography>
      <Typography variant="body1" gutterBottom>
        You don't have permission to access this resource.
      </Typography>
      <Button
        variant="contained"
        color="primary"
        onClick={() => navigate(-1)}
        sx={{ mt: 2 }}
      >
        Go Back
      </Button>
    </Box>
  );
}

export default Unauthorized; 