import { useAuth } from '../context/AuthContext';
import { Button } from '@mui/material';

function Navigation() {
  const { logout, currentUser } = useAuth();

  return (
    <AppBar position="static">
      <Toolbar>
        {/* Your existing navigation items */}
        {currentUser && (
          <Box sx={{ ml: 'auto' }}>
            <Typography variant="body2" sx={{ mr: 2 }}>
              {currentUser.username} ({currentUser.role})
            </Typography>
            <Button color="inherit" onClick={logout}>
              Logout
            </Button>
          </Box>
        )}
      </Toolbar>
    </AppBar>
  );
} 