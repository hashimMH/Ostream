import { AppBar, Toolbar, Typography, Button, Box, IconButton } from '@mui/material';
import { useNavigate, Link } from 'react-router-dom';
import HomeIcon from '@mui/icons-material/Home';
import DocumentIcon from '@mui/icons-material/Description';
import TaskIcon from '@mui/icons-material/Assignment';
import NotificationIcon from '@mui/icons-material/Notifications';
import LogoutIcon from '@mui/icons-material/Logout';
import { useAuth } from '../../context/AuthContext';
import logo from '../../assets/logo.png';

function Navbar() {
  const navigate = useNavigate();
  const { isAuthenticated, logout } = useAuth();

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  return (
    <AppBar position="static">
      <Toolbar>
        <Box sx={{ display: 'flex', alignItems: 'center', flexGrow: 1 }}>
          <img 
            src={logo}
            alt="Logo" 
            style={{ height: 40, marginRight: 10 }}
          />
          <Typography variant="h6" component="div">
            OStream
          </Typography>
        </Box>
        {isAuthenticated ? (
          <Box sx={{ display: 'flex', gap: 2 }}>
            <Button
              color="inherit"
              component={Link}
              to="/"
              startIcon={<HomeIcon />}
            >
              Home
            </Button>
            <Button
              color="inherit"
              component={Link}
              to="/documents"
              startIcon={<DocumentIcon />}
            >
              Documents
            </Button>
            <Button
              color="inherit"
              component={Link}
              to="/tasks"
              startIcon={<TaskIcon />}
            >
              Tasks
            </Button>
            <Button
              color="inherit"
              component={Link}
              to="/notifications"
              startIcon={<NotificationIcon />}
            >
              Notifications
            </Button>
            <Button
              color="error"
              variant="contained"
              onClick={handleLogout}
              startIcon={<LogoutIcon />}
              sx={{ ml: 2 }}
            >
              Logout
            </Button>
          </Box>
        ) : (
          <Box sx={{ display: 'flex', gap: 2 }}>
            <Button color="inherit" onClick={() => navigate('/login')}>
              Login
            </Button>
            <Button color="inherit" onClick={() => navigate('/signup')}>
              Sign Up
            </Button>
          </Box>
        )}
      </Toolbar>
    </AppBar>
  );
}

export default Navbar;