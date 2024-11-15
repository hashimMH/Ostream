import { AuthProvider } from './context/AuthContext';
import AppRoutes from './routes/AppRoutes';
import { Box } from '@mui/material';

function App() {
  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>
      <AuthProvider>
        <AppRoutes />
      </AuthProvider>
    </Box>
  );
}

export default App;