import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import {
  Container,
  Box,
  Typography,
  TextField,
  Button,
  Alert,
  Paper,
} from '@mui/material';
import logo from '../assets/logo.png'; // Import the logo

function Login() {
  const [formData, setFormData] = useState({
    username: '',
    password: '',
  });
  const [error, setError] = useState('');
  const navigate = useNavigate();
  const { login } = useAuth();

  const handleSubmit = (e) => {
    e.preventDefault();
    setError('');

    try {
      const success = login(formData.username, formData.password);
      if (success) {
        navigate('/documents');
      } else {
        setError('Invalid username or password');
      }
    } catch (err) {
      setError('An error occurred during login');
    }
  };

  return (
    <Container maxWidth="sm">
      <Box
        sx={{
          mt: 8,
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
        }}
      >
        {/* Logo Section */}
        <Box sx={{ mb: 4, textAlign: 'center' }}>
          <img
            src={logo}
            alt="OStream Logo"
            style={{
              height: '80px',
              width: 'auto',
              marginBottom: '16px'
            }}
          />
          <Typography variant="h4" component="h1" gutterBottom>
            OStream
          </Typography>
        </Box>

        <Paper elevation={3} sx={{ p: 4, width: '100%' }}>
          <Typography variant="h5" component="h2" gutterBottom align="center">
            Login
          </Typography>
          
          {error && (
            <Alert severity="error" sx={{ mb: 2 }}>
              {error}
            </Alert>
          )}

          <Box component="form" onSubmit={handleSubmit}>
            <TextField
              margin="normal"
              required
              fullWidth
              label="Username"
              autoFocus
              value={formData.username}
              onChange={(e) => setFormData({ ...formData, username: e.target.value })}
            />
            <TextField
              margin="normal"
              required
              fullWidth
              label="Password"
              type="password"
              value={formData.password}
              onChange={(e) => setFormData({ ...formData, password: e.target.value })}
            />
            <Button
              type="submit"
              fullWidth
              variant="contained"
              sx={{ mt: 3, mb: 2 }}
            >
              Sign In
            </Button>
          </Box>

          <Typography variant="body2" color="text.secondary" align="center">
            Demo Users:
          </Typography>
          <Typography variant="caption" color="text.secondary" align="center" component="div">
            admin / admin123 (Superadmin)<br />
            finance_manager / finance123 (Finance Manager)<br />
            hr_user / hr123 (HR User)<br />
            it_user / it123 (IT User)
          </Typography>
        </Paper>
      </Box>
    </Container>
  );
}

export default Login;